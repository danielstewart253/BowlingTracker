//
//  BLRLandscapeScorecardViewController.m
//  Bowlr
//
//  Created by Daniel Stewart on 4/5/17.
//  Copyright © 2017 Daniel Stewart. All rights reserved.
//

#import "BLRLandscapeScorecardViewController.h"
#import "BLRScorecardLineItemViewController.h"
#import "BLRActivityViewController.h"
#import "BLRCircledNumber.h"
#import "UIView+Frame.h"

@interface BLRLandscapeScorecardViewController ()

@property (strong, nonatomic) BLRScorecardLineItemViewController *lineItem;
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *alleyLabel;
@property (weak, nonatomic) IBOutlet UIButton *shareButton;

- (IBAction)shareScorecard;

@end

@implementation BLRLandscapeScorecardViewController

#define BLR_VERTICAL_BUFFER 20

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.alleyLabel.text = @"Paradise Alley";
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    [self layoutLineItems];
    [self layoutCircledNumbers];
}

- (void)layoutLineItems
{
    for(int i = 0; i < [self.gameManager.allBowlrs count]; i++)
    {
        BLRScorecardLineItemViewController *lineItem = [self createScorecardLine: [self.gameManager.allBowlrs objectAtIndex: i]];
        
        CGRect lineItemFrame = lineItem.view.frame;
        lineItemFrame.origin.y = lineItem.view.frame.size.height * i + BLR_VERTICAL_BUFFER;
        lineItem.view.frame = lineItemFrame;
        [lineItem populateScorecardLine];
        [self.contentView addSubview: lineItem.view];
    }
}

- (void)layoutCircledNumbers
{
    self.lineItem = [self createScorecardLine: nil];
    self.lineItem.view.center = CGPointMake(self.lineItem.view.center.x, 0);
    [self.view addSubview: self.lineItem.view];
    for(int i = 0; i < [self.lineItem.allFrames count]; i++)
    {
        UIView *currentFrame = [self.lineItem.allFrames objectAtIndex: i];
    
        BLRCircledNumber *currentNumber = [[BLRCircledNumber alloc] initWithFrame: [UIView createMidSizeFrameWithView: currentFrame]
                                                                  backgroundColor: [UIColor BLRScorecardBackgroundColor]
                                                                      strokeColor: [UIColor BLRScorecardThemeDarkColor]];
        currentNumber.center = CGPointMake(CGRectGetWidth(currentFrame.frame) / 2, CGRectGetHeight(currentFrame.frame) / 2);
        [currentNumber setText: [NSString stringWithFormat: @"%i", i + 1]];
        [currentNumber setTextColor: [UIColor BLRScorecardThemeDarkColor]];
        [currentFrame addSubview: currentNumber];
    }

    self.lineItem.view.frame = [self.contentView convertRect: self.lineItem.view.frame
                                                      toView: self.view];
}

- (BLRScorecardLineItemViewController *)createScorecardLine:(Player *)player
{
    BLRScorecardLineItemViewController *lineItem = [[BLRScorecardLineItemViewController alloc] initWithNibName: bScorecardLineItemVC
                                                                                                        bundle: nil
                                                                                                        player: player];
    [lineItem adjustWidth: self.contentView.frame.size.width];
    return lineItem;
}

- (IBAction)shareScorecard
{
    BLRLandscapeScorecardViewController *scorecard = [[BLRLandscapeScorecardViewController alloc] initWithNibName: bLandscapeScorecardVC
                                                                                                           bundle: nil
                                                                                                      gameManager: self.gameManager
                                                                                                   stateProcessor: nil];
    
    BLRActivityViewController *activityController = [[BLRActivityViewController alloc] initWithActivityItems: @[bShareScoreMessage, [UIImage imageFromView: scorecard.view]]
                                                                                     applicationActivities: nil];
    activityController.excludedActivityTypes = @[UIActivityTypePrint, UIActivityTypeCopyToPasteboard, UIActivityTypeAssignToContact, UIActivityTypeAddToReadingList, UIActivityTypeAssignToContact];

    [self presentViewController: activityController
                       animated: YES
                     completion: nil];
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return UIInterfaceOrientationLandscapeRight;
}

@end
