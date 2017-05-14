//
//  BLRNotifyAlertView.h
//  Bowlr
//
//  Created by Daniel Stewart on 3/24/17.
//  Copyright © 2017 Daniel Stewart. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BLRNotifyAlertView : UIView

- (id)initWithTitle:(NSString *)title
            message:(NSString *)message
     buttonDelegate:(id)buttonDelegate
             action:(SEL)action;

@end
