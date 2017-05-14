//
//  BLRViewController.m
//  Bowlr
//
//  Created by Daniel Stewart on 7/18/15.
//  Copyright (c) 2015 Daniel Stewart. All rights reserved.
//

#import "BLRViewController.h"
#import "BLRNotifyAlertView.h"
#import "BLROptionsAlertView.h"

@interface BLRViewController ()

@end

@implementation BLRViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

// Creates a dim effect for the screen while an alertView is visible
- (void)alertDimViewAnimation
{
    self.dimView = [[UIView alloc] initWithFrame: CGRectMake(0, 0,self.view.bounds.size.width, self.view.bounds.size.height)];
    self.dimView.backgroundColor = [UIColor blackColor];
    self.dimView.alpha = 0.0;
    [self.view addSubview: self.dimView];
    
    [UIView animateWithDuration: 0.28
                          delay: 0
                        options: UIViewAnimationOptionCurveEaseInOut
                     animations: ^{self.dimView.alpha = 0.5;}
                     completion: ^(BOOL finished){}];
}

- (void)dismissDimViewAnimation
{
    [UIView animateWithDuration: 0.28
                          delay: 0
                        options: UIViewAnimationOptionCurveEaseInOut
                     animations: ^{self.dimView.alpha = 0.0;}
                     completion: ^(BOOL finished) {
                         [self.dimView removeFromSuperview];
                         self.dimView = nil;
                     }];
}

- (void)notifyAlertViewSetUpWithTitle:(NSString *)title
                              message:(NSString *)message
                               action:(SEL)action
{
    self.customAlert = [[BLRNotifyAlertView alloc] initWithTitle: title
                                                         message: message
                                                  buttonDelegate: self
                                                          action: action];
    
    self.customAlert.center = CGPointMake(self.view.frame.size.width / 2, self.view.frame.size.height / 2);
    
    [self.view addSubview: self.customAlert];
    [self alertViewPopUpAnimation: self.customAlert];
}

- (void)optionsAlertViewSetUpWithTitle:(NSString *)title
                               message:(NSString *)message
                                action:(SEL)action
                    primaryButtonTitle:(NSString *)buttonTitle
                       secondaryAction:(SEL)secondaryAction
{
    self.customAlert = [[BLROptionsAlertView alloc] initWithTitle: title
                                                          message: message
                                                   buttonDelegate: self
                                                    primaryAction: action
                                               primaryButtonTitle: buttonTitle
                                                  secondaryAction: secondaryAction];

    self.customAlert.center = CGPointMake(self.view.frame.size.width / 2, self.view.frame.size.height / 2);
    [self.view addSubview: self.customAlert];
    [self alertViewPopUpAnimation: self.customAlert];
}

// Animation that reveals the custom alertView
- (void)alertViewPopUpAnimation:(UIView *)alertView
{
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath: @"transform"];
    
    NSArray *frameValues = [NSArray arrayWithObjects:
                            [NSValue valueWithCATransform3D: CATransform3DMakeScale(0.6, 0.6, 1)],
                            [NSValue valueWithCATransform3D: CATransform3DMakeScale(1.15, 1.15, 1)],
                            [NSValue valueWithCATransform3D: CATransform3DMakeScale(0.9, 0.9, 1)],
                            [NSValue valueWithCATransform3D: CATransform3DMakeScale(1.0, 1.0, 1)],
                            nil];
    [animation setValues: frameValues];
    
    NSArray *frameTimes = [NSArray arrayWithObjects:
                           [NSNumber numberWithFloat:0.0],
                           [NSNumber numberWithFloat:0.4],
                           [NSNumber numberWithFloat:0.8],
                           [NSNumber numberWithFloat:1.0],
                           nil];
    [animation setKeyTimes: frameTimes];
    
    animation.fillMode = kCAFillModeForwards;
    animation.removedOnCompletion = NO;
    animation.duration = .28;
    
    [alertView.layer addAnimation: animation forKey: @"popup"];
}

// Dismisses the custom alertView
- (void)alertViewDismissAnimation
{
    [self dismissDimViewAnimation];
    
    [UIView animateWithDuration: 0.28
                          delay: 0
                        options: UIViewAnimationOptionCurveEaseInOut
                     animations: ^{
                         self.customAlert.alpha = 0.0;
                     } completion: ^(BOOL finished) {
                         [self.customAlert removeFromSuperview];
                         self.customAlert = nil;
                     }];
}

@end
