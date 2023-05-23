#import "SBIconLegibilityLabelView.h"

@implementation SBIconLegibilityLabelView

// all methods implemented

-(instancetype)initWithSettings:(id)settings {
 [self initWithSettings:settings strength:0 image:nil shadowImage:nil options:[SBIconLabelImage legibilityStrengthForLegibilityStyle:[settings style]]];
}
-(void)updateIconLabelWithSettings:(id)settings imageParameters:(id)imageParameters {
 SBIconLabelImageParameters * currentImageParameters = [self imageParameters];
 
 UIImage *imageForUILegibilityView;
 UIImage *shadowImageForUILegibilityView;
 
 // the line ((imageParameters && currentImageParameters) || (!imageParameters && !currentImageParameters)) means that either the imageParameters into the input, OR ones already on here, one must be nil and one must not be set
 // aka, if the icon label currently has no imageParameters and you passed in nil, this will return OK (although the isEqual will likely fail lol)
 // and if icon label already has imageParameters and you pass in some, this will also return OK
 // if not - else statement
 // there is a noticable fuck up here though
 // if you call this method before it gets imageParameters, and pass nil into imageParameters - it will try to run the method isEqual
 // but remember, this may be before this SBIconLegibilityLabelView gets its imageParameters!!! so you would be calling isEqual on nil
 // this means that if you call this method before SBIconLegibilityLabelView gets imageParameters and pass nil, it will crash
 // either that or I RE'd it wrong :P
 
 if (((imageParameters && currentImageParameters) || (!imageParameters && !currentImageParameters)) && [currentImageParameters isEqual:imageParameters]) {
  if ([self image]) {
   imageForUILegibilityView = [self image];
   shadowImageForUILegibilityView = [self shadowImage];
  } else {
   if (imageParameters) {
    id retImg = [[self iconView]labelImageWithParameters:imageParameters];
    if (!retImg) {
     retImg = [SBIconLabelImage imageWithParameters:imageParameters];
    }
    shadowImageForUILegibilityView = [retImg legibilityImage];
    [self setImageParameters:imageParameters];
   } else {
    imageForUILegibilityView = nil;
    shadowImageForUILegibilityView = nil;
   }
  }
 } else {
  if (imageParameters) {
    id retImg = [[self iconView]labelImageWithParameters:imageParameters];
    if (!retImg) {
     retImg = [SBIconLabelImage imageWithParameters:imageParameters];
    }
    shadowImageForUILegibilityView = [retImg legibilityImage];
    [self setImageParameters:imageParameters];
  } else {
   imageForUILegibilityView = nil;
   shadowImageForUILegibilityView = nil;
  }
 }
 
 // OK - regarding my comment from earlier - actually this method will 100% crash springboard if you call it with imageParameters nil
 // no safety checks or anything
 // i wonder why the if (imageParameters) are there then, since you are never supposed to call this method with nil for imageParameters...
 // also will crash of you pass in nil for settings

 if (![imageParameters containsEmoji] || ([settings style] != 2)) {
  [self setOptions:UILegibilityViewOptionNone];
  [self setSettings:settings image:imageForUILegibilityView shadowImage:shadowImageForUILegibilityView];
  [self setOptions:UILegibilityViewOptionUsesColorFilters];
  [self setSettings:settings image:imageForUILegibilityView shadowImage:shadowImageForUILegibilityView];
  return;
 }
 
 if (SBFBoolEquals(nil, [self usesColorFilters])) {
  UIImage *currentImage = [self image];
  if (currentImage == imageForUILegibilityView) {
   UIImage *currentShadowImage = [self image];
   if (currentShadowImage == shadowImageForUILegibilityView) {
    if ([settings isEqual:[self settings]]) {
     return;
    }
   }
  }
 }
 [self setOptions:UILegibilityViewOptionNone];
 [self setSettings:settings image:imageForUILegibilityView shadowImage:shadowImageForUILegibilityView];
}
@end
