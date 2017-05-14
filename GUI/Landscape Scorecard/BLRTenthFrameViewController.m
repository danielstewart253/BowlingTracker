//
//  BLRTenthFrameViewController.m
//  Bowlr
//
//  Created by Daniel Stewart on 4/2/17.
//  Copyright © 2017 Daniel Stewart. All rights reserved.
//

#import "BLRTenthFrameViewController.h"

@interface BLRTenthFrameViewController ()

@property (weak, nonatomic) IBOutlet UILabel *firstAttemptLabel;
@property (weak, nonatomic) IBOutlet UILabel *secondAttemptLabel;
@property (weak, nonatomic) IBOutlet UILabel *thirdAttemptLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalScoreLabel;
@property (strong, nonnull) Frame *currentFrame;

@end

@implementation BLRTenthFrameViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil
                         bundle:(NSBundle *)nibBundleOrNil
                          frame:(Frame *)frame
{
    self = [super initWithNibName: nibNameOrNil
                           bundle: nibBundleOrNil];
    if(self)
    {
        self.currentFrame = frame;
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self populateSingleFrame];
}

- (void)populateSingleFrame
{
    [self populateFirstAttempt];
    [self populateSecondAttempt];
    [self populateThirdAttempt];
    [self populateTotalScore];
}

- (void)populateThirdAttempt
{
    self.thirdAttemptLabel.text = [BLRStringProcessor stringForAttemptResult: self.currentFrame.thirdAttempt];
}

@end
