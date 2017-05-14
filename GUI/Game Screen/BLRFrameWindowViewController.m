//
//  BLRFrameWindowViewController.m
//  Bowlr
//
//  Created by Daniel Stewart on 3/14/17.
//  Copyright © 2017 Daniel Stewart. All rights reserved.
//

#import "BLRFrameWindowViewController.h"
#import "BLRStringProcessor.h"
#import "Game+Utils.h"

@interface BLRFrameWindowViewController ()

@property (weak, nonatomic) IBOutlet UIButton *attempt1Button;
@property (weak, nonatomic) IBOutlet UIButton *attempt2Button;
@property (weak, nonatomic) IBOutlet UILabel *attempt3Label;
@property (weak, nonatomic) IBOutlet UILabel *currentScoreLabel;

@end

@implementation BLRFrameWindowViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view addGestureRecognizer: [[UITapGestureRecognizer alloc] initWithTarget: self
                                                                             action: @selector(setToNextAttempt)]];
    
    [self setFontColorForSubviews];
    [self updateAttemptButtonViews];
    
    [[NSNotificationCenter defaultCenter] addObserver: self
                                             selector: @selector(updateInterface)
                                                 name: bUpdateGameInterface
                                               object: nil];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver: self];
}

- (void)setFontColorForSubviews
{
    UIColor *patternColor = [UIColor colorWithPatternImage: [UIImage imageNamed: bCurrentScoreFrameBackground]];
    
    self.attempt1Button.titleLabel.textColor = patternColor;
    [self.attempt1Button setTitleColor: patternColor
                              forState: UIControlStateNormal];
    [self.attempt1Button setTitleColor: patternColor
                              forState: UIControlStateSelected];
    [self.attempt2Button setTitleColor: patternColor
                              forState: UIControlStateNormal];
    [self.attempt2Button setTitleColor: patternColor
                              forState: UIControlStateSelected];
    
    self.attempt3Label.textColor = patternColor;
    self.currentScoreLabel.textColor = patternColor;
}

- (void)setToNextAttempt
{
    if(self.attempt1Button.selected && self.gameManager.selectedAttempt.result == BLRAttemptResultStrike)
    {
        return;
    }
    
    self.attempt1Button.selected = !self.attempt1Button.selected;
    self.attempt2Button.selected = !self.attempt2Button.selected;
    
    if(self.attempt1Button.selected)
    {
        self.gameManager.selectedAttempt = self.gameManager.selectedFrame.firstAttempt;
        self.gameManager.selectedFrame.currentAttempt = BLRCurrentAttemptFirst;
    }
    else
    {
        self.gameManager.selectedAttempt = self.gameManager.selectedFrame.secondAttempt;
        self.gameManager.selectedFrame.currentAttempt = BLRCurrentAttemptSecond;
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName: bUpdateGameInterface
                                                        object: nil];
}

- (void)updateAttemptButtonViews
{
    BLRCurrentAttempt currentAttempt = self.gameManager.selectedFrame.currentAttempt;
    self.attempt1Button.selected = currentAttempt == BLRCurrentAttemptFirst ? YES : NO;
    self.attempt2Button.selected = currentAttempt == BLRCurrentAttemptSecond ? YES : NO;
    self.attempt3Label.enabled = currentAttempt == BLRCurrentAttemptThird ? YES : NO;
}

- (void)styleViewForStandardFrame
{
    self.attempt1Button.frame = CGRectMake(8.0, 9.0, 25.0, 26.0);
    self.attempt2Button.frame = CGRectMake(36.0, 9.0, 25.0, 26.0);
    self.attempt3Label.hidden = YES;
}

- (void)styleViewForFrame10
{
    self.attempt1Button.frame = CGRectMake(8.0, 9.0, 25.0, 26.0);
    self.attempt2Button.frame = CGRectMake(36.0, 9.0, 25.0, 26.0);
    self.attempt3Label.hidden = NO;
}

- (void)updateFirstAttemptScore
{
    NSString *resultString = [BLRStringProcessor stringForAttemptResult: self.gameManager.selectedFrame.firstAttempt];
    [self.attempt1Button setTitle: resultString
                         forState: UIControlStateNormal];
    [self.attempt1Button setTitle: resultString
                         forState: UIControlStateSelected];
}

- (void)updateSecondAttemptScore
{
    NSString *resultString = [BLRStringProcessor stringForAttemptResult: self.gameManager.selectedFrame.secondAttempt];
    [self.attempt2Button setTitle: resultString
                         forState: UIControlStateNormal];
    [self.attempt2Button setTitle: resultString
                         forState: UIControlStateSelected];
}

- (void)updateCurrentScoreLabel
{
    self.currentScoreLabel.text = [self displayCurrentScoreThroughCurrentFrame];
}

- (void)updateFrameWindow
{
    [self updateAttemptButtonViews];
    [self updateFirstAttemptScore];
    [self updateSecondAttemptScore];
    [self updateCurrentScoreLabel];
}

- (void)updateInterface
{
    [self updateFrameWindow];
}

- (NSString *)displayCurrentScoreThroughCurrentFrame
{
    Game *currentGame = self.gameManager.selectedBowlr.currentGame;
    Frame *currentFrame = self.gameManager.selectedFrame;
    
    if(currentFrame.frameNumber == bFrameNumberOne)
    {
        [currentGame computeCurrentGameScoreThroughFrame1];
    }
    else if(currentFrame.frameNumber == bFrameNumberTwo)
    {
        [currentGame computeCurrentGameScoreThroughFrame2];
    }
    else if(currentFrame.frameNumber == bFrameNumberThree)
    {
        [currentGame computeCurrentGameScoreThroughFrame3];
    }
    else if(currentFrame.frameNumber == bFrameNumberFour)
    {
        [currentGame computeCurrentGameScoreThroughFrame4];
    }
    else if(currentFrame.frameNumber == bFrameNumberFive)
    {
        [currentGame computeCurrentGameScoreThroughFrame5];
    }
    else if(currentFrame.frameNumber == bFrameNumberSix)
    {
        [currentGame computeCurrentGameScoreThroughFrame6];
    }
    else if(currentFrame.frameNumber == bFrameNumberSeven)
    {
        [currentGame computeCurrentGameScoreThroughFrame7];
    }
    else if(currentFrame.frameNumber == bFrameNumberEight)
    {
        [currentGame computeCurrentGameScoreThroughFrame8];
    }
    else if(currentFrame.frameNumber == bFrameNumberNine)
    {
        [currentGame computeCurrentGameScoreThroughFrame9];
    }
    else if(currentFrame.frameNumber == bFrameNumberTen)
    {
        [currentGame computeCurrentGameScoreThroughFrame10];
    }
    
    return [NSString stringWithFormat: @"%d", currentFrame.currentGameScore];
}

@end
