//
//  BLRSingleFrameViewController.m
//  Bowlr
//
//  Created by Daniel Stewart on 4/1/17.
//  Copyright © 2017 Daniel Stewart. All rights reserved.
//

#import "BLRSingleFrameViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface BLRSingleFrameViewController ()

@property (weak, nonatomic) IBOutlet UIView *backgroundView;
@property (weak, nonatomic) IBOutlet UILabel *firstAttemptLabel;
@property (weak, nonatomic) IBOutlet UILabel *secondAttemptLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalScoreLabel;
@property (strong, nonnull) Frame *currentFrame;

@end

@implementation BLRSingleFrameViewController

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
    [self populateTotalScore];
}

- (void)populateFirstAttempt
{
    self.firstAttemptLabel.text = [BLRStringProcessor stringForAttemptResult: self.currentFrame.firstAttempt];
}

- (void)populateSecondAttempt
{
    self.secondAttemptLabel.text = [BLRStringProcessor stringForAttemptResult: self.currentFrame.secondAttempt];
}

- (void)populateTotalScore
{
    self.totalScoreLabel.text = [BLRStringProcessor stringForFrameScore: self.currentFrame];
}

@end
