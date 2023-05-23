#import <UIKit/UIKit.h>

@interface SBIconLegibilityLabelView : _UILegibilityView <SBIconLabelView>

@property (nonatomic) SBIconView *iconView;
@property (nonatomic, retain) UIImage *image;
@property (nonatomic, retain) SBIconLabelImageParameters *imageParameters;

-(instancetype)initWithSettings:(id)settings;
-(void)updateIconLabelWithSettings:(id)settings imageParameters:(id)imageParameters;

@end
