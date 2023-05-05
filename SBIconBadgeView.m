#import "SBIconBadgeView.h"

//iOS 15.2 simulator

@interface SBIconBadgeView : UIView {
 UIImageView *_incomingTextView;
 BOOL _displayingAccessory;
 SBHIconAccessoryCountedMapImageTuple *_backgroundImageTuple;
 SBHIconAccessoryCountedMapImageTuple *_textImageTuple;
 SBDarkeningImageView *_backgroundView;
 UIImageView *_textView;
}
-(instancetype)init;
@end

@implementation SBIconBadgeView
+(id)badgeBackgroundColor {
 //0x1 arg passed in here is a UIUserInterfaceStyle
 NSArray* daArray = [NSArray arrayWithObjects:[UITraitCollection traitCollectionWithUserInterfaceStyle:0x1], [UITraitCollection traitCollectionWithAccessibilityContrast:0x0]];
 UITraitCollection* traitCollection = [UITraitCollection traitCollectionWithTraitsFromCollections:daArray];
 return [[UIColor systemRedColor]resolvedColorWithTraitCollection:traitCollection];
}
//headers.cynder.me does not list this method - maybe it is simulator only?
+(CGFloat)_textPadding {
 return 12.0;
}
-(instancetype)init {
 self = [super init];
 if (self) {
  _backgroundView = [[SBDarkeningImageView alloc]init];
  [self addSubview:_backgroundView];
  _textView = [[UIImageView alloc]init];
  [_backgroundView addSubview:_textView];
 }
 return self;
}
-(void)dealloc {
 [self _clearText];
 [self->_parallaxSettings removeKeyObserver:self];
 [[self super]dealloc];
}
-(id)font {
 id listLayout = [self listLayout];
 UIFont theFont;
 if ([listLayout respondsToSelector:@selector(accessoryFontForContentSizeCategory:options:)]) {
  //this method implemented by SBIconGridListLayout
  theFont = [listLayout accessoryFontForContentSizeCategory:UIContentSizeCategoryUnspecified options:((char)UIAccessibilityIsBoldTextEnabled())];
  if (!theFont) {
   theFont = [UIFont systemFontOfSize:16.0];
  }
 } else {
  theFont = [UIFont systemFontOfSize:16.0];
 }
 return theFont;
}
-(void)layoutSubviews {
 [[self super]layoutSubviews];
 if (!_backgroundImageTuple) {
  _backgroundImageTuple = [self _checkoutBackgroundImageTuple];
  [_backgroundView setImage:[[_backgroundImageTuple image]sbf_imageByTilingCenterPixel]];
 }
 if (_backgroundView) {
  [_backgroundView transform];
 } else {
  // there is something here but idk what it is lol
 }
 [UIView preformWithoutAnimation:^{ /* some block */ }];
 CGRect bgViewFrame = CGRectMake(0, 0, 0, 0); //this is not actual frame but too lazy to reverse
 [_backgroundView setFrame:bgViewFrame];
 //some more stuff below eh finish later
}
-(void)_layOutTextImageView:(id)arg0 {
 CGFloat badgeContentScale = [self badgeContentScale];
 UIImage* daImage = [arg0 image];
 [daImage size];
 if (daImage) {
  [daImage alignmentRectInsets];
  //stuff with UIEdgeInsets
 } else {
  //too lazy to rev
 }
 //a lot of stuff
 id bgView = [self->_backgroundView];
 if (bgView) {
 } else {
 }
 //a lot of stuff
}
-(CGFloat)badgeContentScale {
 CGFloat ret;
 if ([self listLayout]) {
  id listLayout = [self listLayout];
  if (listLayout) {
   [someVarIdk iconImageInfo];
   //stuff
  } else {
   //stuff
  }
 } else {
  ret = [[[self window] screen]scale];
 }
 return ret;
}
-(void)configureAnimatedForIcon:(id)arg0 infoProvider:(id)arg1 animator:(id)animator {
 id location = [arg1 location];
 [self _configureAnimatedForText:[arg0 accessoryTextForLocation:location] highlighted:[arg1 isHighlighted] animator:animator];
}
-(void)configureForIcon:(id)arg0 infoProvider:(id)arg1 {
 id location = [arg1 location];
 BOOL isHighlighted = [arg1 isHighlighted];
 id text = [arg0 accessoryTextForLocation:location];
 UIFont* font = [self font];
 id imageForText = [[self class]_checkoutImageForText:text font:font highlighted:isHighlighted];
 [self _clearText];
 _text = text;
 _textImageTuple = imageForText;
 [_textView setImage:[_textImageTuple image]];
 [_textView setAlpha:1.0];
 [self _resizeForTextImage:[_textImageTuple image]];
 _displayingAccessory = _textImageTuple != 0x0 ? YES : NO;
}
-(void)prepareForReuse {
 _displayingAccessory = NO;
 _text = NULL;
 [self _clearText];
 [self->_textView setImage:nil];
 [self _resizeForTextImage:nil];
}
-(struct CGSize )intrinsicContentSizeForTextImage:(id)arg0 {
 CGSize daSize = [self badgeSize];
 if (arg0) {
  daSize = [arg0 size];
 } else {
  daSize = CGSizeZero;
 }
 [[self class] _textPadding];
 //stuff
 return daSize;
}
-(struct CGSize )intrinsicContentSize {
 return [self intrinsicContentSizeForTextImage:[self->_textImageTuple image]];
}
-(struct CGSize )sizeThatFits:(struct CGSize )arg0 {
 return [self intrinsicContentSize];
}
-(void)setAccessoryBrightness:(CGFloat)arg0 {
 return [self->_backgroundView setBrightness:arg0];
}
-(void)setListLayout:(id)listLayout {
 if (_listLayout != listLayout) {
  _listLayout = listLayout;
  [self _clearText];
  [self setNeedsLayout];
  [self layoutIfNeeded];
 }
}
-(void)_configureAnimatedForText:(id)text highlighted:(BOOL)highlighted animator:(id)animator {
 //SBFEqualStrings is a function from SpringBoardFoundation
 if (SBFEqualStrings(text,_text)) {
  [self layoutIfNeeded];
  return;
 }
 id font = [self font];
 id imageForText = [[self class] _checkoutImageForText:text font:font highlighted:highlighted];
 self->_displayingAccessory
 [self _clearText];
 _text = text;
 _textImageTuple = imageForText;
 self->_displayingAccessory = imageForText != 0x0 ? YES : NO; //if imageForText not null, YES
 if ((!self->_displayingAccessory) || (!imageForText)) {
  if (!imageForText) {
   if (self->_displayingAccessory) {
    [self _zoomOutWithAnimator:animator];
    return;
   }
  } else {
   [self _zoomInWithTextImage:[imageForText image] animator:animator]
  }
 } else {
  [self _crossfadeToTextImage:[imageForText image] animator:animator];
  return;
 }
}
-(void)_crossfadeToTextImage:(id)arg0 animator:(id)arg1 {
 UIImageView* imageView = [[UIImageView alloc]init];
 [imageView setImage:arg0];
 [imageView setAlpha:arg0]; // ??
 [self->_backgroundView addSubview:imageView];
 _incomingTextView = imageView;
 [self setNeedsLayout];
 [self layoutIfNeeded];
 //FINISH LATER
}
-(void)_zoomInWithTextImage:(id)arg0 animator:(id)arg1 {
 [_textView setImage:arg0];
 [_textView setAlpha:1.0];
 [self _resizeForTextImage:arg0];
 [self setNeedsLayout];
 [self layoutIfNeeded];
}
-(void)_zoomOutWithAnimator:(id)arg0 {
 return;
}
@end
