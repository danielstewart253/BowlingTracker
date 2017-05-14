//
//  BLRViewController.h
//  Bowlr
//
//  Created by Daniel Stewart on 7/18/15.
//  Copyright (c) 2015 Daniel Stewart. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BLRButton.h"

@interface BLRViewController : UIViewController

// Used to create a dim effect when the alertView is visible
@property (strong, nonatomic) UIView *dimView;

@property (strong, nonatomic) UIView *customAlert;

- (void)alertDimViewAnimation;
- (void)dismissDimViewAnimation;
- (void)notifyAlertViewSetUpWithTitle:(NSString *)title
                              message:(NSString *)message
                               action:(SEL)action;
- (void)optionsAlertViewSetUpWithTitle:(NSString *)title
                               message:(NSString *)message
                                action:(SEL)action
                    primaryButtonTitle:(NSString *)buttonTitle
                       secondaryAction:(SEL)secondaryAction;
- (void)alertViewPopUpAnimation:(UIView *)alertView;
- (void)alertViewDismissAnimation;

@end
