#import "SBFolderIconImageView.h"

@implementation SBFolderIconImageView
-(instancetype)initWithFrame:(CGRect)frame {
 self = [super initWithFrame:frame];
 if (self) {
  _backgroundView = [[UIView alloc]init];
  [_backgroundView setUserInteractionEnabled:NO];
  [self insertSubview:_backgroundView atIndex:0];
  _pageGridContainer = [[UIView alloc]init];
  [rbx insertSubview:_pageGridContainer aboveSubview:_backgroundView]; //_pageGridContainer will be at subview index 1
  [_pageGridContainer setClipsToBounds:1];
  [_pageGridContainer setUserInteractionEnabled:NO];
  _leftWrapperView = [[_SBIconGridWrapperView alloc]init];
  [_leftWrapperView setFolderIconImageView:self];
  [_pageGridContainer addSubview:_leftWrapperView];
  _rightWrapperView = [[_SBIconGridWrapperView alloc]init];
  [_rightWrapperView setFolderIconImageView:self];
  [_pageGridContainer insertSubview:_rightWrapperView aboveSubview:_leftWrapperView];
  [self _updateRasterization];
  [self _updateAccessibilityBackgroundContrast];
  NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
  [defaultCenter addObserver:self selector:@selector(_updateAccessibilityBackgroundContrast) name:UIAccessibilityReduceTransparencyStatusDidChangeNotification object:nil];
 }
}
@end
