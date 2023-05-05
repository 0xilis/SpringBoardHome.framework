#import "SBIconBadgeView.h"

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
//headers.cynder.me does not list this method - maybe it is simulator only?
+(CGFloat)_textPadding {
 return 12.0;
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
@end
