//
//  BLRGameHeaderViewController.m
//  Bowlr
//
//  Created by Daniel Stewart on 3/14/17.
//  Copyright © 2017 Daniel Stewart. All rights reserved.
//

#import "BLRGameHeaderViewController.h"
#import "BLRFrameBarViewController.h"
#import "AchievementsViewController.h"
#import "InGameAchievementsViewController.h"
#import "BLRBallSpeedViewController.h"
#import "Frame+Utils.h"
#import "Attempt+Utils.h"



@interface BLRGameHeaderViewController ()

@property (weak, nonatomic) IBOutlet UIView *backgroundView;
@property (weak, nonatomic) IBOutlet UIView *bandView;

@property (strong, nonatomic) BLRBallSpeedViewController *ballSpeedView;
@property (weak, nonatomic) IBOutlet UIView *ballSpeedContentView;

@property (strong, nonatomic) BLRFrameBarViewController *frameBarView;
@property (weak, nonatomic) IBOutlet UIView *frameBarContainerView;

@property (weak, nonatomic) IBOutlet UIButton *strikeButton;
@property (weak, nonatomic) IBOutlet UIButton *spareButton;
@property (weak, nonatomic) IBOutlet UIButton *gutterButton;
@property (weak, nonatomic) IBOutlet UIButton *foulButton;
@property (weak, nonatomic) IBOutlet UIButton *splitButton;
@property (weak, nonatomic) IBOutlet UIButton *missButton;
@property (weak, nonatomic) IBOutlet UIButton *achievementsButton;
@property (weak, nonatomic) IBOutlet UIButton *ballSpeedButton;

@end

@implementation BLRGameHeaderViewController

- (void)loadView
{
    [super loadView];
    
    self.ballSpeedView = [[BLRBallSpeedViewController alloc] initWithNibName: bBallSpeedDialVC
                                                                      bundle: nil
                                                                 gameManager: self.gameManager
                                                              stateProcessor: self.attemptProcessor
                                                           ballSpeedDelegate: self];
    
    self.frameBarView = [[BLRFrameBarViewController alloc] initWithNibName: bFrameBarVC
                                                                    bundle: nil
                                                               gameManager: self.gameManager
                                                            stateProcessor: self.attemptProcessor];
    
    [self.frameBarContainerView addSubview: self.frameBarView.view];
    [self.ballSpeedContentView addSubview: self.ballSpeedView.view];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view setBackgroundColor: [UIColor clearColor]];
    
    [[NSNotificationCenter defaultCenter] addObserver: self
                                             selector: @selector(updateInterface)
                                                 name: bUpdateGameInterface
                                               object: nil];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear: animated];
    [self updateHeaderViewsForAttempt];
    [self setBallSpeedForButtonTitle];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver: self];
}

- (void)updateInterface
{
    [self updateHeaderViews];
    [self updateHeaderViewsForAttempt];
    [self setBallSpeedForButtonTitle];
}

- (void)updateHeaderViews
{
    [self updateStrikeButton];
    [self updateSpareButton];
    [self updateGutterButton];
    [self updateFoulButton];
    [self updateSplitButton];
    [self updateMissButton];
}

- (void)updateHeaderViewsForAttempt
{
    BLRCurrentAttempt currentAttempt = self.gameManager.selectedFrame.currentAttempt;
    switch (currentAttempt) {
        case BLRCurrentAttemptFirst:
            [self updateHeaderViewsForFirstAttempt];
            break;
        case BLRCurrentAttemptSecond:
            [self updateHeaderViewsForSecondAttempt];
            break;
        case BLRCurrentAttemptThird:
            [self updateHeaderViewsForThirdAttempt];
            break;
        default:
            break;
    }
}

- (IBAction)strikeButtonAction:(UIButton *)sender
{
    [self.gameManager.selectedAttempt shouldSetScoreToStrike: !sender.isSelected];
    [self.attemptProcessor determineState: self.gameManager.selectedFrame];
    [self.gameManager updatePinStateToStrike: !sender.isSelected];
    [self.gameManager.selectedFrame resetFutureAttempts];
    [self setScoreForFrame];
    [[NSNotificationCenter defaultCenter] postNotificationName: bUpdateGameInterface object: nil];
}

- (void)updateStrikeButton
{
    self.strikeButton.selected = self.gameManager.selectedAttempt.result == BLRAttemptResultStrike;
}

- (IBAction)spareButtonAction:(UIButton *)sender
{    
    [self.gameManager.selectedAttempt shouldSetScoreToSpare: !sender.isSelected
                                          firstAttemptScore: self.gameManager.selectedFrame.firstAttempt.scoreForAttempt];
    [self.attemptProcessor determineState: self.gameManager.selectedFrame];
    [self.gameManager.selectedFrame resetFutureAttempts];
    [self setScoreForFrame];
    [self.pinViewDelegate shouldUpdatePinsForSpare: !sender.isSelected];
    [[NSNotificationCenter defaultCenter] postNotificationName: bUpdateGameInterface object: nil];
}

- (void)updateSpareButton
{
    self.spareButton.selected = self.gameManager.selectedAttempt.result == BLRAttemptResultSpare;
}

- (IBAction)gutterButtonAction:(UIButton *)sender
{
    self.gameManager.selectedAttempt.result = (self.gameManager.selectedAttempt.result == BLRAttemptResultGutter) ? BLRAttemptResultNoAttempt : BLRAttemptResultGutter;
    
    [self updateHeaderViews];
    
    self.gameManager.selectedAttempt.scoreForAttempt = BLR_GUTTER_SCORE;
    [self.gameManager.selectedAttempt setAllPinsStateForAttempt: BLRPinStateUp];
    [self.gameManager.selectedFrame resetFutureAttempts];
    [self setScoreForFrame];
    [[NSNotificationCenter defaultCenter] postNotificationName: bUpdateGameInterface object: nil];
}

- (void)updateGutterButton
{
    self.gutterButton.selected = self.gameManager.selectedAttempt.result == BLRAttemptResultGutter;
}

- (IBAction)foulButtonAction:(UIButton *)sender
{
    self.gameManager.selectedAttempt.result = (self.gameManager.selectedAttempt.result == BLRAttemptResultFoul) ? BLRAttemptResultNoAttempt : BLRAttemptResultFoul;
    
    if(self.gameManager.selectedAttempt.result == BLRAttemptResultFoul)
    {
        self.gameManager.selectedAttempt.scoreForAttempt = BLR_FOUL_SCORE;
    }
    else
    {
        [self.gameManager.selectedAttempt setAllPinsStateForAttempt: BLRPinStateUp];
    }
    
    [self updateHeaderViews];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:bUpdateGameInterface object: nil];
}

- (void)updateFoulButton
{
    self.foulButton.selected = self.gameManager.selectedAttempt.result == BLRAttemptResultFoul;
}

- (IBAction)splitButtonAction:(UIButton *)sender
{
    self.gameManager.selectedAttempt.result = (self.gameManager.selectedAttempt.result == BLRAttemptResultSplit) ? BLRAttemptResultNoAttempt : BLRAttemptResultSplit;
    
    [self updateHeaderViews];
}

- (void)updateSplitButton
{
    self.splitButton.selected = self.gameManager.selectedAttempt.result == BLRAttemptResultSplit;
}

- (IBAction)missButtonAction:(UIButton *)sender
{
    self.gameManager.selectedAttempt.result = (self.gameManager.selectedAttempt.result == BLRAttemptResultMiss) ? BLRAttemptResultNoAttempt : BLRAttemptResultMiss;
    
    self.gameManager.selectedAttempt.scoreForAttempt = BLR_MISS_SCORE;
    [self.gameManager.selectedAttempt setAllPinsStateForAttempt: BLRPinStateUp];
    
    [self updateHeaderViews];
    
    [[NSNotificationCenter defaultCenter] postNotificationName: bUpdateGameInterface object: nil];
}

- (void)updateMissButton
{
    self.missButton.selected = self.gameManager.selectedAttempt.result == BLRAttemptResultMiss;
}

- (void)setScoreForFrame
{
    [self.gameManager.selectedFrame computeTotalFrameScore];
}

- (IBAction)achievementsButtonAction
{
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    UINavigationController *navController = [delegate getRootNavigationController];
    [navController pushViewController: [[InGameAchievementsViewController alloc] initWithNibName: bAchievementsVC
                                                                                          bundle: nil
                                                                                    listOfBowlrs: self.gameManager.allBowlrs]
                             animated: NO];
    
    [UIView transitionWithView: navController.view
                      duration: 0.6
                       options: UIViewAnimationOptionTransitionFlipFromRight
                    animations: nil
                    completion: nil];
}

- (IBAction)speedButtonAction
{
    CGFloat height = self.ballSpeedContentView.frame.size.height + self.bandView.frame.origin.y;
    CGFloat yOffset = !self.ballSpeedButton.selected ? height : -height;
    CGFloat yPoint = self.ballSpeedContentView.center.y + yOffset;
    
    [self animateBallSpeedDialToPoint: CGPointMake(self.ballSpeedContentView.center.x, yPoint)];
    self.ballSpeedButton.selected = !self.ballSpeedButton.selected;
}

- (void)animateBallSpeedDialToPoint:(CGPoint)point
{
    [UIView animateWithDuration: .22
                          delay: 0
                        options: UIViewAnimationOptionCurveLinear
                     animations:^{
                         self.ballSpeedContentView.center = point;
                     }
                     completion: nil];
}

// Sets the title of the ballSpeedButton to the current ball speed of the Attempt
- (void)setBallSpeedForAttempt
{
    [self.ballSpeedButton setTitle:[NSString stringWithFormat: @"%.1f", self.gameManager.selectedAttempt.ballSpeedForAttempt]
                          forState: UIControlStateNormal];
    [self.ballSpeedButton setTitle:[NSString stringWithFormat: @"%.1f", self.gameManager.selectedAttempt.ballSpeedForAttempt]
                          forState: UIControlStateSelected];
}

- (void)updateHeaderViewsForFirstAttempt
{
    self.strikeButton.hidden = NO;
    self.splitButton.hidden = NO;
    self.missButton.hidden = YES;
    self.spareButton.hidden = YES;
}

- (void)updateHeaderViewsForSecondAttempt
{
    self.strikeButton.hidden = YES;
    self.splitButton.hidden = YES;
    self.missButton.hidden = NO;
    self.spareButton.hidden = NO;
}

- (void)updateHeaderViewsForThirdAttempt
{
    
}

- (void)setBallSpeedForButtonTitle
{
    if(self.gameManager.selectedAttempt.ballSpeedForAttempt >= 0)
    {
        [self.ballSpeedButton setTitle:[NSString stringWithFormat:@"%.1f", self.gameManager.selectedAttempt.ballSpeedForAttempt] forState:UIControlStateNormal];
        [self.ballSpeedButton setTitle:[NSString stringWithFormat:@"%.1f", self.gameManager.selectedAttempt.ballSpeedForAttempt] forState:UIControlStateSelected];
    }
}

@end
