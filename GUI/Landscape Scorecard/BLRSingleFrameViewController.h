//
//  BLRSingleFrameViewController.h
//  Bowlr
//
//  Created by Daniel Stewart on 4/1/17.
//  Copyright © 2017 Daniel Stewart. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BLRStringProcessor.h"

@interface BLRSingleFrameViewController : UIViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil
                         bundle:(NSBundle *)nibBundleOrNil
                          frame:(Frame *)frame;
- (void)populateSingleFrame;
- (void)populateFirstAttempt;
- (void)populateSecondAttempt;
- (void)populateTotalScore;

@end
