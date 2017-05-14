//
//  UIView+CAAnimation.m
//  Bowlr
//
//  Created by Daniel Stewart on 3/19/17.
//  Copyright © 2017 Daniel Stewart. All rights reserved.
//

#import "UIView+CAAnimation.h"

@implementation UIView (CAAnimation)

- (void)achievementOccurredAnimation:(id<CAAnimationDelegate>)delegate
{
    CAKeyframeAnimation *animation = [CAKeyframeAnimation
                                      animationWithKeyPath: @"transform"];
    animation.delegate = delegate;
    
    NSArray *frameValues = [NSArray arrayWithObjects:
                            [NSValue valueWithCATransform3D: CATransform3DMakeScale(0.025, 0.025, 1)],
                            [NSValue valueWithCATransform3D: CATransform3DMakeScale(0.6, 0.6, 1)],
                            [NSValue valueWithCATransform3D: CATransform3DMakeScale(1.20, 1.20, 1)],
                            [NSValue valueWithCATransform3D: CATransform3DMakeScale(0.8, 0.8, 1)],
                            [NSValue valueWithCATransform3D: CATransform3DMakeScale(1.0, 1.0, 1)],
                            [NSValue valueWithCATransform3D: CATransform3DMakeScale(1.0, 1.0, 1)],
                            [NSValue valueWithCATransform3D: CATransform3DMakeScale(1.0, 1.0, 1)],
                            [NSValue valueWithCATransform3D: CATransform3DMakeScale(1.20, 1.20, 1)],
                            [NSValue valueWithCATransform3D: CATransform3DMakeScale(0.25, 0.25, 1)],
                            [NSValue valueWithCATransform3D: CATransform3DMakeScale(0.0, 0.0, 1)],
                            nil];
    [animation setValues: frameValues];
    
    NSArray *frameTimes = [NSArray arrayWithObjects:
                           [NSNumber numberWithFloat: 0.10],
                           [NSNumber numberWithFloat: 0.12],
                           [NSNumber numberWithFloat: 0.19],
                           [NSNumber numberWithFloat: 0.23],
                           [NSNumber numberWithFloat: 0.28],
                           [NSNumber numberWithFloat: 0.53],
                           [NSNumber numberWithFloat: 0.75],
                           [NSNumber numberWithFloat: 0.83],
                           [NSNumber numberWithFloat: 0.88],
                           [NSNumber numberWithFloat: 0.98],
                           nil];
    [animation setKeyTimes: frameTimes];
    
    animation.fillMode = kCAFillModeForwards;
    animation.removedOnCompletion = NO;
    animation.duration = 2.2;
    [[self layer] addAnimation: animation forKey: @"animation"];
}

@end
