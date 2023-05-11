@interface SBIconView : NSObject
+(CGFloat)_labelHeight;
+(CGFloat)defaultIconImageScale;
+(CGFloat)defaultIconImageCornerRadius;
+(struct CGSize )defaultIconImageSize;
@end

@implementation SBIconView
+(CGFloat)defaultIconImageScale {
 //accurate
 return 2.0;
}
+(CGFloat)defaultIconImageCornerRadius {
 //accutate
 return 20.0;
}
+(struct CGSize )defaultIconImageSize {
  //accurate
 return CGSizeMake(50.0, 50.0);
}
+(struct CGSize )defaultIconViewSize {
 //NOTE: INACCURATE
 CGSize returnSize = [self defaultIconImageSize];
 CGFloat labelHeight = [self _labelHeight];
 returnSize.width += labelHeight;
 return returnSize;
}
+(CGFloat)_labelHeight {
 //NOTE: INACCURATE
 BOOL isIPad;
 //__sb__runningInSpringBoard is a function from SpringBoardServices.framework
 if (__sb__runningInSpringBoard()) {
  //SBFEffectiveDeviceClass is a function from SpringBoardFoundation.framework
  isIPad = SBFEffectiveDeviceClass() == 0x2 ? YES : NO;
 } else {
  isIPad = [[UIDevice currentDevice] userInterfaceIdiom] == 0x1 ? YES : NO;
 }
 CGFloat ret;
 if (!isIPad) {
  ret = 14.0;
 } else {
  //this float is pointing to an address (0x2bbbd8) saying (3333334@)
  //so idrk what it is, maybe just a float that is a var
  ret = floatFromSomewhereInMem;
 }
 return ret;
}
-(id)badgeString {
 BOOL isClass = [_accessoryView isKindOfClass:[SBIconBadgeView class]];
 if (isClass) {
  return [_accessoryView text];
 } else {
  return 0;
 }
}
//i never know yanderedev worked at apple
+(NSInteger)continuityBadgeTypeForNSString:(NSString *)string {
 NSInteger badgeType;
 if ([string isEqualToString:@"SBIconContinuityBadgeTypeNone"]) {
  badgeType = 0;
 } else {
  badgeType = 13;
  if (![string isEqualToString:@"SBIconContinuityBadgeTypeIMac"]) {
   badgeType = 14;
   if (![string isEqualToString:@"SBIconContinuityBadgeTypeMacBook"]) {
    badgeType = 4;
    if (![string isEqualToString:@"SBIconContinuityBadgeTypeMac"]) {
     badgeType = 5;
     if (![string isEqualToString:@"SBIconContinuityBadgeTypeWatch"]) {
      badgeType = 12;
      if (![string isEqualToString:@"SBIconContinuityBadgeTypePhoneX"]) {
       badgeType = 1;
       if (![string isEqualToString:@"SBIconContinuityBadgeTypePhone"]) {
        badgeType = 2;
        if (![string isEqualToString:@"SBIconContinuityBadgeTypePad"]) {
         badgeType = 3;
         if (![string isEqualToString:@"SBIconContinuityBadgeTypePod"]) {
          badgeType = 6;
          if (![string isEqualToString:@"SBIconContinuityBadgeTypeAppleTV"]) {
           badgeType = 10;
           if (![string isEqualToString:@"SBIconContinuityBadgeTypeLocation"]) {
            badgeType = 9;
            if (![string isEqualToString:@"SBIconContinuityBadgeTypeHeadphones"]) {
             badgeType = 8;
             if (![string isEqualToString:@"SBIconContinuityBadgeTypeBluetooth"]) {
              badgeType = 7;
              if (![string isEqualToString:@"SBIconContinuityBadgeTypeAUX"]) {
               badgeType = 11;
               if (![string isEqualToString:@"SBIconContinuityBadgeTypeWake"]) {
                badgeType = 0;
               }
              }
             }
            }
           }
          }
         }
        }
       }
      }
     }
    }
   }
  }
 }
 return badgeType;
}
//your average wrapper method
-(id)initWithConfigurationOptions:(NSUInteger)configurationOptions {
 return [self initWithConfigurationOptions:configurationOptions listLayoutProvider:nil];
}
//your average wrapper method, nope SBIconView does not give a shit about the frame you pass in
-(id)initWithFrame:(struct CGRect )frame {
 return [self initWithConfigurationOptions:nil listLayoutProvider:nil];
}
//this is always YES
+(BOOL)allowsLabelAccessoryView {
 return YES;
}
-(BOOL)allowsLabelAccessoryView {
 BOOL returnAllowsLabelAccessoryView;
 if ([[self class] allowsLabelAccessoryView]) { //at least in iOS 15.2 sim, this will always return YES
  returnAllowsLabelAccessoryView = ![self isFolderIcon];
 } else {
  returnAllowsLabelAccessoryView = NO;
 }
 return returnAllowsLabelAccessoryView;
}
-(void)_createAccessoryViewIfNecessary {
 Class defaultViewClass = [[self class]defaultViewClassForAccessoryType:[self currentAccessoryType]];
 if (![_accessoryView isMemberOfClass:defaultViewClass]) {
  id reuseDelegate = [self reuseDelegate];
  [self _destroyAccessoryView];
  if (defaultViewClass) {
   id aView;
   if ([reuseDelegate respondsToSelector:@selector(iconView:iconAccessoryViewOfClass:)]) {
    aView = [reuseDelegate iconView:self iconAccessoryViewOfClass:defaultViewClass];
   } else {
    aView = [[defaultViewClass alloc]init];
   }
   _accessoryView = aView;
   if ([_accessoryView respondsToSelector:@selector(setLegibilityStyle:)]) {
    [_accessoryView setLegibilityStyle:[self->_legibilitySettings style]];
   }
   [_accessoryView setAccessoryBrightness:[self effectiveBrightness]];
   [_accessoryView setAlpha:[self effectiveIconAccessoryAlpha]];
   [_accessoryView setTransform:CGAffineTransformIdentity];
   [self updateParallaxSettings];
   if ([_accessoryView respondsToSelector:@selector(setListLayout:)]) {
    [_accessoryView setListLayout:[self listLayout]];
    [_accessoryView sizeToFit];
   }
   if ([_accessoryView respondsToSelector:@selector(setActionTapGestureRecognizer:)]) {
    UITapGestureRecognizer* tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(_accessoryViewTapGestureChanged:)];
    [tapGesture setDelegate:self];
    [_accessoryView addGestureRecognizer:tapGesture];
    [_accessoryView setActionTapGestureRecognizer:tapGesture];
    _accessoryViewCursorInteraction = [[UIPointerInteraction alloc]initWithDelegate:_accessoryView];
    [self->_accessoryView addInteraction:_accessoryViewCursorInteraction];
   }
  }
 }
 if (_accessoryView) {
  id currentImageView = [self currentImageView];
  id daSuperview = [_accessoryView superview];
  if (daSuperview != currentImageView) {
   [currentImageView addSubview:_accessoryView];
  }
  [currentImageView bringSubviewToFront:_accessoryView];
 }
}
-(BOOL)supportsConfigurationCard {
 BOOL ret;
 id configurationUIDelegate = [self configurationUIDelegate];
 if ([configurationUIDelegate respondsToSelector:@selector(iconView:supportsConfigurationForDataSource:)) {
  id visiblyActiveDataSource = [self _visiblyActiveDataSource];
  if (visiblyActiveDataSource) {
   ret = [configurationUIDelegate iconView:self supportsConfigurationForDataSource:visiblyActiveDataSource];
  } else {
   ret = NO;
  }
 } else {
  ret = NO;
 }
 return ret;
}
-(BOOL)supportsStackConfigurationCard {
 return [[self icon]supportsStackConfiguration];
}
-(void)presentConfigurationCard {
 id configuration = [self currentConfigurationInteraction];
 if (!configuration) {
  id configurationUIDelegate = [self configurationUIDelegate];
  if ([configurationUIDelegate respondsToSelector:@selector(iconView:configurationInteractionForDataSource:)]) {
   id visiblyActiveDataSource = [self _visiblyActiveDataSource];
   if (visiblyActiveDataSource) {
    id something = [configurationUIDelegate iconView:self configurationInteractionForDataSource:visiblyActiveDataSource];
    [something setDelegate:self];
    [self setCurrentConfigurationInteraction:something];
   }
  }
 }
 [configuration beginConfiguration];
 [[SBFAnalyticsClient sharedInstance]emitEvent:0x39];
}
-(void)presentStackConfigurationCard {
 //BSSafeCast is function from PrivateFrameworks/FrontBoardServices.framework
 id configuration = BSSafeCast([self currentStackConfigurationInteraction], NSClassFromString(@"SBHStackConfigurationInteraction"));
 if (!configuration) {
  configuration = [self currentConfigurationInteraction];
  if (!configuration) {
   id configurationUIDelegate = [self configurationUIDelegate];
   if ([configurationUIDelegate respondsToSelector:@selector(stackConfigurationInteractionForIconView:)]) {
    configuration = BSSafeCast([configurationUIDelegate stackConfigurationInteractionForIconView:self], NSClassFromString(@"SBHStackConfigurationInteraction"));
    [configuration setDelegate:self];
    [self setCurrentStackConfigurationInteraction:configuration];
   }
  }
 }
 [configuration beginConfiguration];
 [[SBFAnalyticsClient sharedInstance]emitEvent:0x3a];
}
-(void)popStackConfigurationCard {
 [[self currentStackConfigurationInteraction]popConfiguration];
}
-(void)dismissStackConfigurationCard {
 [[self currentStackConfigurationInteraction]endConfiguration];
}
-(void)dismissStackConfigurationCardImmediately {
 [[self currentStackConfigurationInteraction]endConfigurationImmediately];
}
-(void)popConfigurationCard {
  [[self currentConfigurationInteraction]popConfiguration];
}
-(void)dismissConfigurationCard {
 [[self currentConfigurationInteraction]endConfiguration];
}
-(void)dismissConfigurationCardImmediately {
 [[self currentConfigurationInteraction]endConfigurationImmediately];
}
-(id)containerViewControllerForConfigurationInteraction:(id)arg0 {
 id ret;
 id configurationUIDelegate = [self configurationUIDelegate];
 if ([configurationUIDelegate respondsToSelector:@selector(iconView:containerViewControllerForConfigurationInteraction:)]) {
  ret = [configurationUIDelegate iconView:self containerViewControllerForConfigurationInteraction:arg0];
 } else {
  ret = 0;
 }
 return ret;
}
@end
