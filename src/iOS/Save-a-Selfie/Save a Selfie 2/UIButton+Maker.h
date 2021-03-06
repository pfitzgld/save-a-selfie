//
//  UIButton+Maker.h
//  Photoapp4it
//
//  Created by Peter FitzGerald on 25/05/2013.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface UIButton (Maker)

+(UIButton *)makeButton:(NSString *)buttonText addShine:(BOOL)addShine dimensions:(CGRect)dimensions;
+(UIButton *)changeButton:(UIButton *) button buttonText:(NSString *)buttonText addShine:(BOOL)addShine dimensions:(CGRect)dimensions;
+(void)addShineLayer:(UIButton *)button;

@end
