//
//  BLROptionsAlertView.m
//  Bowlr
//
//  Created by Daniel Stewart on 3/24/17.
//  Copyright © 2017 Daniel Stewart. All rights reserved.
//

#import "BLROptionsAlertView.h"
#import "BLRAlertViewButton.h"

@interface BLROptionsAlertView()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *messageLabel;
@property (weak, nonatomic) IBOutlet BLRAlertViewButton *secondaryButton;
@property (weak, nonatomic) IBOutlet BLRAlertViewButton *primaryButton;

@end

@implementation BLROptionsAlertView

- (id)initWithTitle:(NSString *)title
            message:(NSString *)message
     buttonDelegate:(id)buttonDelegate
      primaryAction:(SEL)action
 primaryButtonTitle:(NSString *)buttonTitle
    secondaryAction:(SEL)secondaryAction
{
    self = [[[NSBundle mainBundle] loadNibNamed: bAlertViewOptions
                                          owner: self
                                        options: nil] objectAtIndex: 0];
    if(self)
    {
        self.titleLabel.text = title;
        self.messageLabel.text = message;
        [self.primaryButton setTitle: buttonTitle
                            forState: UIControlStateNormal];
        [self.secondaryButton setTitle: bCancelButtonTitle
                              forState: UIControlStateNormal];
        [self.primaryButton addTarget: buttonDelegate
                               action: action
                     forControlEvents: UIControlEventTouchUpInside];
        [self.secondaryButton addTarget: buttonDelegate
                               action: secondaryAction
                     forControlEvents: UIControlEventTouchUpInside];
    }

    return self;
}

@end
