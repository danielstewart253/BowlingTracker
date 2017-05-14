//
//  BLRNumberPadViewController.m
//  Bowlr
//
//  Created by Daniel Stewart on 3/14/17.
//  Copyright © 2017 Daniel Stewart. All rights reserved.
//

#import "BLRNumberPadViewController.h"
#import "Attempt+Utils.h"

@interface BLRNumberPadViewController ()

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *numberPadButtons;
@property (weak, nonatomic) IBOutlet UIButton *numberPad1Button;
@property (weak, nonatomic) IBOutlet UIButton *numberPad2Button;
@property (weak, nonatomic) IBOutlet UIButton *numberPad3Button;
@property (weak, nonatomic) IBOutlet UIButton *numberPad4Button;
@property (weak, nonatomic) IBOutlet UIButton *numberPad5Button;
@property (weak, nonatomic) IBOutlet UIButton *numberPad6Button;
@property (weak, nonatomic) IBOutlet UIButton *numberPad7Button;
@property (weak, nonatomic) IBOutlet UIButton *numberPad8Button;
@property (weak, nonatomic) IBOutlet UIButton *numberPad9Button;
@property (weak, nonatomic) IBOutlet UIButton *numberPad10Button;
@property (weak, nonatomic) IBOutlet UIButton *pinButton;

@end

@implementation BLRNumberPadViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.alpha = 0.0;
    [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(updateInterface) name: bUpdateGameInterface object: nil];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver: self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)numberPadButtonAction:(UIButton *)sender
{
    [self deselectNumberPadButtonsWithoutTag: sender.tag];
    sender.selected = !sender.selected;
    
    [self setScoreForAttempt: sender.tag];
    [self setScoreForFrame];
    [self.attemptProcessor determineState: self.gameManager.selectedFrame];
    [self.gameManager.selectedAttempt setAllPinsStateForAttempt:BLRPinStateUp];
    [self.headerDelegate updateHeaderViews];
    [self.frameWindowDelegate updateFrameWindow];
}

- (IBAction)pinButtonAction
{
    [self.animationDelegate animateToPinScreen];
}

- (void)deselectNumberPadButtonsWithoutTag:(NSInteger)tag
{
    for(UIButton *numberPad in self.numberPadButtons)
    {
        if(numberPad.tag != tag)
        {
            [numberPad setSelected:NO];
        }
    }
}

- (void)setScoreForAttempt:(NSInteger)score
{
    [self.gameManager.selectedAttempt setNumberPadScoreForAttempt:(int)score];
}

- (void)setScoreForFrame
{
    [self.gameManager.selectedFrame computeTotalFrameScore];
}

- (void)selectNumberPadButtons:(BOOL)selected
{
    for(UIButton *numberPad in self.numberPadButtons)
    {
        [numberPad setSelected: selected];
    }
}

- (void)enableNumberPadButtons:(BOOL)enable
{
    for(UIButton *numberPad in self.numberPadButtons)
    {
        [numberPad setEnabled: enable];
    }
}

- (void)disableSecondAttemptPadButtons:(Frame *)currentFrame
{
    if(currentFrame.currentAttempt == BLRCurrentAttemptSecond)
    {
        int score = currentFrame.firstAttempt.scoreForAttempt;
        for(UIButton *numberPad in self.numberPadButtons)
        {
            if(numberPad.tag + score > BLR_ATTEMPT_MAX_SCORE)
            {
                numberPad.enabled = NO;
            }
        }
    }
    
}

- (void)updateInterface
{
    [self enableNumberPadButtons:YES];
    [self selectNumberPadButtons:NO];
    
    if(self.gameManager.selectedAttempt.scoreForAttempt > BLR_MIN_SCORE)
    {
        UIButton *expectedButton = (UIButton *)[self.view viewWithTag:self.gameManager.selectedAttempt.scoreForAttempt];
        [expectedButton setSelected:YES];
    }
    
    [self disableSecondAttemptPadButtons: self.gameManager.selectedFrame];
}

@end
