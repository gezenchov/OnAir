//
//  UIView+Animations.m
//  OnAir
//
//  Created by Petar Gezenchov on 24/01/2016.
//  Copyright © 2016 com.gezenchov. All rights reserved.
//

#import "UIView+Animations.h"

@implementation UIView (Animations)

-(void)startPulsing {
    CABasicAnimation *theAnimation;
    
    theAnimation=[CABasicAnimation animationWithKeyPath:@"opacity"];
    theAnimation.duration=1.0;
    theAnimation.repeatCount=HUGE_VALF;
    theAnimation.autoreverses=YES;
    theAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    theAnimation.fromValue=[NSNumber numberWithFloat:1.0];
    theAnimation.toValue=[NSNumber numberWithFloat:0.5];
    [self.layer addAnimation:theAnimation forKey:@"animateOpacity"];
}

-(void)stopPulsing {
    [self.layer removeAnimationForKey:@"animateOpacity"];
}

@end
