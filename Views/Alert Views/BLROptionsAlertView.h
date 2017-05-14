//
//  BLROptionsAlertView.h
//  Bowlr
//
//  Created by Daniel Stewart on 3/24/17.
//  Copyright © 2017 Daniel Stewart. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BLROptionsAlertView : UIView

- (id)initWithTitle:(NSString *)title
            message:(NSString *)message
     buttonDelegate:(id)buttonDelegate
      primaryAction:(SEL)action
 primaryButtonTitle:(NSString *)buttonTitle
    secondaryAction:(SEL)secondaryAction;

@end
