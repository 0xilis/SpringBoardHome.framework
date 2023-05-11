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
//lol
+(NSInteger)continuityBadgeTypeForContinuityInfo:(id)arg0 {
 id originatingDeviceType = [self originatingDeviceType];
 id devType;
 id ret;
 if (originatingDeviceType) {
  devType = [UTType typeWithIdentifier:originatingDeviceType]
 } else {
  devType = 0;
 }
 if (arg0) {
  ret = [devType conformsToType:[UTType typeWithIdentifier:@"com.apple.imac"]];
  if (ret) {
   ret = 13;
  } else {
   ret = [devType conformsToType:[UTType typeWithIdentifier:@"com.apple.mac.laptop"]];
   if (ret) {
    ret = 14;
   } else {
    ret = [devType conformsToType:[UTType typeWithIdentifier:@"com.apple.mac"]];
    if (ret) {
     ret = 4;
    } else {
     ret = [devType conformsToType:[UTType typeWithIdentifier:@"com.apple.watch"]];
     if (ret) {
      ret = 5;
     } else {
      ret = [devType conformsToType:[UTType typeWithIdentifier:@"com.apple.iphone-x"]];
      if (ret) {
       ret = 12;
      } else {
       ret = [devType conformsToType:[UTType typeWithIdentifier:@"com.apple.iphone"]];
       if (ret) {
        ret = 1;
       } else {
        ret = [devType conformsToType:[UTType typeWithIdentifier:@"com.apple.ipad"]];
        if (ret) {
         ret = 2;
        } else {
         ret = [devType conformsToType:[UTType typeWithIdentifier:@"com.apple.ipod"]];
         if (ret) {
          ret = 3;
         } else {
          ret = [devType conformsToType:[UTType typeWithIdentifier:@"com.apple.apple-tv"]];
          if (ret) {
           ret = 6;
          } else {
           if ([arg0 isLocationBasedSuggestion]) {
            ret = 10;
           } else {
            if ([arg0 isBluetoothAudioPrediction]) {
             ret = 9;
            } else {
             if ([arg0 isBluetoothPrediction]) {
              ret = 8;
             } else {
              if ([arg0 isHeadphonesPrediction]) {
               ret = 7;
              } else {
               ret = 11;
               if (![arg0 isFirstWakePrediction]) {
                ret = 0;
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
 } else {
  ret = 0;
 }
 return ret;
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
-(void)setIcon:(id)icon animated:(BOOL)animated {
 if (_icon != icon) {
  [_icon removeObserver:self];
  _icon = icon;
  if (_icon) {
   [_icon addObserver:self];
   [self setPaused:NO forReason:0x2];
   [self _updateIconImageViewAnimated:animated];
   [self _updateLabelArea];
   [self _updateProgressAnimated:animated];
   [self _updateAccessoryViewAnimated:animated];
   [self _updateCloseBoxAnimated:animated];
   [self _updateBrightness];
   [self _applyEditingStateAnimated:animated];
   [self addGesturesAndInteractionsIfNecessary];
  } else {
   [self setCustomIconImageViewController:nil];
   [self setPaused:YES forReason:0x2];
  }
  [self _updateLaunchDisabled];
  [self _fetchApplicationShortcutItemsIfAppropriate];
  [self _fetchSupportedMedusaShortcutActionsIfAppropriate];
 }
}
-(CGFloat)_continuousCornerRadius {
 CGFloat ret = _showsSquareCorners;
 if (!ret) {
  ret = [self iconImageCornerRadius];
 }
 return ret;
}
-(void)setIcon:(id)icon {
 [self setIcon:icon animated:NO];
}
-(void)setLocation:(NSString *)location {
 [self setLocation:location animated:NO];
}
-(void)setLocation:(NSString *)location animated:(BOOL)animated {
  //BSEqualObjects is function from PrivateFrameworks/FrontBoardServices.framework
 if (!BSEqualObjects(location, _iconLocation)) {
  _iconLocation = [location copy];
  [self _updateFrameToIconViewSize];
  [self _updateIconImageViewAnimated:animated];
  [self _updateLabel];
  [self _updateAccessoryViewAnimated:animated];
  [self _updateCloseBoxAnimated:animated];
 }
}
+(NSUInteger)defaultImageLoadingBehavior {
 return 0;
}
-(void)setContinuityInfo:(id)continuityInfo {
 [self setContinuityInfo:continuityInfo animated:NO];
}
-(void)setContinuityInfo:(id)continuityInfo animated:(BOOL)animated {
 if (_continuityInfo != continuityInfo) {
  _continuityInfo = continuityInfo;
  [self _updateAccessoryViewAnimated:animated];
 }
}
-(BOOL)_shouldEnableGroupBlending {
 return ![self labelStyle];
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
-(id)sourceIconViewForConfigurationInteraction:(id)arg0 {
 return [self representativeIconViewForModalInteractions];
}
-(void)configurationInteractionWillBegin:(id)arg0 {
 if ([arg0 isKindOfClass:[SBHWidgetConfigurationInteraction class]] || [arg0 isKindOfClass:[SBHStackConfigurationInteraction class]]) {
  [self _updateCloseBoxAnimated:NO];
  [self setAllowsEditingAnimation:NO];
 }
 id configurationUIDelegate = [self configurationUIDelegate];
 if ([configurationUIDelegate respondsToSelector:@selector(iconView:configurationWillBeginWithInteraction:)]) {
  [configurationUIDelegate iconView:self configurationWillBeginWithInteraction:arg0];
 }
}
-(void)configurationInteractionDidBegin:(id)arg0 {
 id configurationUIDelegate = [self configurationUIDelegate];
 if ([configurationUIDelegate respondsToSelector:@selector(iconView:configurationDidBeginWithInteraction:)]) {
  [configurationUIDelegate iconView:self configurationDidBeginWithInteraction:arg0];
 }
}
-(void)configurationInteractionDidCommit:(id)arg0 {
 id configurationUIDelegate = [self configurationUIDelegate];
 if ([configurationUIDelegate respondsToSelector:@selector(iconView:configurationDidUpdateWithInteraction:)]) {
  [configurationUIDelegate iconView:self configurationDidUpdateWithInteraction:arg0];
 }
}
-(void)configurationInteractionWillEnd:(id)arg0 {
 id configurationUIDelegate = [self configurationUIDelegate];
 if ([configurationUIDelegate respondsToSelector:@selector(iconView:configurationWillEndWithInteraction:)]) {
  [configurationUIDelegate iconView:self configurationWillEndWithInteraction:arg0];
 }
}
-(void)configurationInteractionDidEnd:(id)arg0 {
 if ([arg0 isKindOfClass:[SBHWidgetConfigurationInteraction class]]) {
  [self setCurrentConfigurationInteraction:nil];
 }
 if ([arg0 isKindOfClass:[SBHStackConfigurationInteraction class]]) {
  [self setCurrentStackConfigurationInteraction:nil];
 }
 [self _updateCloseBoxAnimated:YES];
 [self setAllowsEditingAnimation:YES];
 id configurationUIDelegate = [self configurationUIDelegate];
 if ([configurationUIDelegate respondsToSelector:@selector(iconView:configurationDidEndWithInteraction:)]) {
  [configurationUIDelegate iconView:self configurationDidEndWithInteraction:arg0];
 }
}
-(id)reuseDelegate {
 id delegate = [self delegate];
 if ([delegate respondsToSelector:@selector(reuseDelegateForIconView:)]) {
  delegate = [delegate reuseDelegateForIconView:self];
 }
 return delegate;
}
+(BOOL)supportsPreviewInteraction {
 return YES;
}
+(BOOL)showsPopovers {
 return [[SBHHomeScreenDomain rootSettings]showPopOvers];
}
-(BOOL)_hasPopover {
 BOOL ret;
 if ([[self class]showsPopovers]) {
  if (_reallyHasPopover) {
   return _reallyHasPopover;
  } else {
   ret = NO;
   if ([[self recentsDocumentExtensionProvider]canShowRecentsDocumentExtensionProviderForBundleIdentifier:[self applicationBundleIdentifierForShortcuts]]) {
    ret = YES;
   }
   _reallyHasPopover = ret;
  }
 } else {
  ret = NO;
 }
 return ret;
}
-(id)recentsDocumentExtensionProvider {
 id ret;
 if ([[self class]showsPopovers]) {
  if (_recentsDocumentExtensionProvider) {
   ret = _recentsDocumentExtensionProvider;
  } else {
   id shortcutsDelegate = [self shortcutsDelegate];
   if (!_recentsDocumentExtensionProvider) {
    if ([shortcutsDelegate respondsToSelector:@selector(recentDocumentExtensionProviderForIconView:)]) {
     _recentsDocumentExtensionProvider = [shortcutsDelegate recentDocumentExtensionProviderForIconView:self];
    } else {
     _recentsDocumentExtensionProvider = [[SBHRecentsDocumentExtensionProvider alloc]init];
    }
    [_recentsDocumentExtensionProvider setUsesIntrinsicContentSizeBasedOnScreenSize:YES];
   }
   ret = _recentsDocumentExtensionProvider;
  }
 } else {
  ret = nil;
 }
 return ret;
}
-(id)shortcutsDelegate {
 id shortcutsDelegate = [self delegate];
 if ([shortcutsDelegate respondsToSelector:@selector(shortcutsDelegateForIconView:)]) {
  shortcutsDelegate = [shortcutsDelegate shortcutsDelegateForIconView:self];
 }
 return shortcutsDelegate;
}
-(void)setEditing:(BOOL)editing animated:(BOOL)animated { // ????
 if (!_isEditing) {
  _isEditing = editing;
  [self _applyEditingStateAnimated:animated];
  return;
 }
 if ([self shouldShowCloseBox] != [self _isShowingCloseBox]) {
  [self _updateCloseBoxAnimated:animated];
 }
 BOOL shouldShowAccessoryView = [self shouldShowAccessoryView];
 BOOL isShowingAccessoryView = [self _isShowingAccessoryView];
 if (shouldShowAccessoryView == isShowingAccessoryView) {
  return;
 } else {
  [self _updateAccessoryViewAnimated:animated];
 }
}
-(BOOL)isAnimatingScrolling {
 return [[self _folderIconImageView]isAnimating];
}
-(BOOL)_shouldAnimatePropertyWithKey:(id)key {
 if (![key isEqualToString:@"zPosition"]) {
  return [[self super]_shouldAnimatePropertyWithKey:key];
 } else {
  return YES;
 }
}
-(void)_applyIconImageAlpha:(CGFloat)alpha {
 [[self currentImageView]setAlpha:alpha];
}
+(id)_jitterXTranslationAnimationWithStrength:(CGFloat)arg0 {
 return [self _jitterXTranslationAnimationWithAmount:(arg0 * 0.4)];
}
+(id)_jitterXTranslationAnimationWithAmount:(CGFloat)arg0 {
 //FYI I SUCK AT REVERSE ENGINEERING DOUBLES/FLOATS SOOOOO UH THIS MAY BE VERY INNACCURATE
 id animation = [[CABasicAnimation animationWithKeyPath:@"transform.translation.x"];
 [animation setDuration:0.134];
 [animation setBeginTime:(arc4random_uniform(100) / 100.0)];
 [animation setFromValue:[NSNumber numberWithDouble:arg0]];
 [animation setToValue:[NSNumber numberWithDouble:(arg0 ^ 0.457)];
 [animation setTimingFunction:[CAMediaTimingFunction functionWithControlPoints:0.36, 0.63, 1.0]];
 [animation setRepeatCount:INFINITY];
 [animation setAutoreverses:YES];
 [animation setRemovedOnCompletion:NO];
 return animation;
}
+(id)_jitterYTranslationAnimationWithStrength:(CGFloat)arg0 {
 return [self _jitterYTranslationAnimationWithAmount:(arg0 * 0.4)];
}
+(id)_jitterYTranslationAnimationWithAmount:(CGFloat)arg0 {
 //FYI I SUCK AT REVERSE ENGINEERING DOUBLES/FLOATS SOOOOO UH THIS MAY BE VERY INNACCURATE
 id animation = [[CABasicAnimation animationWithKeyPath:@"transform.translation.y"];
 [animation setDuration:0.142];
 [animation setBeginTime:(arc4random_uniform(100) / 100.0)];
 [animation setFromValue:[NSNumber numberWithDouble:arg0]];
 [animation setToValue:[NSNumber numberWithDouble:(arg0 ^ 0.457)];
 [animation setTimingFunction:[CAMediaTimingFunction functionWithControlPoints:0.36, 0.63, 1.0]];
 [animation setRepeatCount:INFINITY];
 [animation setAutoreverses:YES];
 [animation setRemovedOnCompletion:NO];
 return animation;
}
+(id)_jitterRotationAnimationWithStrength:(CGFloat)arg0 {
 return [self _jitterRotationAnimationWithAmount:(arg0 * 0.03)];
}
+(id)_jitterRotationAnimationWithAmount:(CGFloat)arg0 {
 //FYI I SUCK AT REVERSE ENGINEERING DOUBLES/FLOATS SOOOOO UH THIS MAY BE VERY INNACCURATE
 id animation = [[CABasicAnimation animationWithKeyPath:@"transform.rotation"];
 [animation setDuration:0.128];
 [animation setBeginTime:(arc4random_uniform(100) / 100.0)];
 [animation setFromValue:[NSNumber numberWithDouble:arg0]];
 [animation setToValue:[NSNumber numberWithDouble:(arg0 ^ 0.457)];
 [animation setTimingFunction:[CAMediaTimingFunction functionWithControlPoints:0.36, 0.63, 1.0]];
 [animation setRepeatCount:INFINITY];
 [animation setAutoreverses:YES];
 [animation setRemovedOnCompletion:NO];
 return animation;
}
-(void)_updateJitter {
 BOOL shouldJitter = NO;
 if (([self isEditing]) && (self->_allowJitter) && !(self->_isOverlapping)) {
  if (![self isPaused]) {
   if (!self->_crossfadeView) {
    shouldJitter = (self->_icon != NULL);
   }
  }
 }
 if (_isJittering == shouldJitter) {
  if (shouldJitter) {
   [self _addJitter];
  } else {
   [self _removeJitter];
  }
  [[self _iconImageView]setJittering:_isJittering];
 }
}
-(void)_addJitter {
 id suppressJitter = [[[SBHHomeScreenDomain rootSettings]iconSettings]suppressJitter];
 if (!suppressJitter) {
  _isJittering = YES;
  id layer = [self layer];
  id strength = [self editingAnimationStrength];
  [layer addAnimation:[SBIconView _jitterXTranslationAnimationWithStrength:strength] forKey:@"SBIconXTranslation"];
  [layer addAnimation:[SBIconView _jitterYTranslationAnimationWithStrength:strength] forKey:@"SBIconYTranslation"];
  id iconLayout = [[self listLayoutProvider]layoutForIconLocation:[self location]];
  //SBHIconListLayoutEditingAnimationStrengthForGridSizeClass is a function from this framework!
  [layer addAnimation:[SBIconView _jitterRotationAnimationWithStrength:(strength * SBHIconListLayoutEditingAnimationStrengthForGridSizeClass(iconLayout, [[self icon] gridSizeClass]))] forKey:@"SBIconRotation"];
 }
}
-(void)_removeJitter {
 _isJittering = NO;
 id layer = [self layer];
 [layer removeAnimationForKey:@"SBIconXTranslation"];
 [layer removeAnimationForKey:@"SBIconYTranslation"];
 [layer removeAnimationForKey:@"SBIconRotation"];
}
@end
