//
//  BLRNotifyAlertView.m
//  Bowlr
//
//  Created by Daniel Stewart on 3/24/17.
//  Copyright © 2017 Daniel Stewart. All rights reserved.
//

#import "BLRNotifyAlertView.h"
#import "BLRAlertViewButton.h"

@interface BLRNotifyAlertView()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *messageLabel;
@property (weak, nonatomic) IBOutlet BLRAlertViewButton *dismissButton;

@end

@implementation BLRNotifyAlertView


- (id)initWithTitle:(NSString *)title
            message:(NSString *)message
     buttonDelegate:(id)buttonDelegate
             action:(SEL)action
{
    self = [[[NSBundle mainBundle] loadNibNamed: bAlertViewNotify
                                          owner: self
                                        options: nil] objectAtIndex: 0];
    if(self)
    {
        self.titleLabel.text = title;
        self.messageLabel.text = message;
        [self.dismissButton setTitle: bOKButtonTitle
                            forState: UIControlStateNormal];
        [self.dismissButton addTarget: buttonDelegate
                               action: action
                     forControlEvents: UIControlEventTouchUpInside];
    }
    
    return self;
}

@end
