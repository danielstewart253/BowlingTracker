//
//  BLRPinViewController.m
//  Bowlr
//
//  Created by Daniel Stewart on 3/14/17.
//  Copyright © 2017 Daniel Stewart. All rights reserved.
//

#import "BLRPinViewController.h"
#import "Attempt+Utils.h"

@interface BLRPinViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *pinsImage;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *pinsCollection;

@property (weak, nonatomic) IBOutlet UIButton *pin1Button;
@property (weak, nonatomic) IBOutlet UIButton *pin2Button;
@property (weak, nonatomic) IBOutlet UIButton *pin3Button;
@property (weak, nonatomic) IBOutlet UIButton *pin4Button;
@property (weak, nonatomic) IBOutlet UIButton *pin5Button;
@property (weak, nonatomic) IBOutlet UIButton *pin6Button;
@property (weak, nonatomic) IBOutlet UIButton *pin7Button;
@property (weak, nonatomic) IBOutlet UIButton *pin8Button;
@property (weak, nonatomic) IBOutlet UIButton *pin9Button;
@property (weak, nonatomic) IBOutlet UIButton *pin10Button;
@property (weak, nonatomic) IBOutlet UIButton *numberPadButton;

@end

@implementation BLRPinViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver: self
                                             selector: @selector(updateInterface)
                                                 name: bUpdateGameInterface
                                               object: nil];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver: self];
}

- (IBAction)pinButtonAction:(UIButton *)sender
{
    sender.selected = !sender.selected;
    [self updatePinStateForAttempt: self.gameManager.selectedAttempt];
    
    [self setScoreForAttempt];
    [self setScoreForFrame];
    [self.attemptProcessor determineState: self.gameManager.selectedFrame];
    
    [self.headerDelegate updateHeaderViews];
    [self.frameWindowDelegate updateFrameWindow];
    
    BLRLogManager *manager = [[BLRLogManager alloc] initWithGameManager: self.gameManager];
    [manager logCurrentFrame];
    [manager logCurrentAttempt];
}

- (void)updatePinStateForAttempt:(Attempt *)selectedAttempt
{
    [selectedAttempt setPin1:self.pin1Button.selected ? BLRPinStateDown : BLRPinStateUp];
    [selectedAttempt setPin2:self.pin2Button.selected ? BLRPinStateDown : BLRPinStateUp];
    [selectedAttempt setPin3:self.pin3Button.selected ? BLRPinStateDown : BLRPinStateUp];
    [selectedAttempt setPin4:self.pin4Button.selected ? BLRPinStateDown : BLRPinStateUp];
    [selectedAttempt setPin5:self.pin5Button.selected ? BLRPinStateDown : BLRPinStateUp];
    [selectedAttempt setPin6:self.pin6Button.selected ? BLRPinStateDown : BLRPinStateUp];
    [selectedAttempt setPin7:self.pin7Button.selected ? BLRPinStateDown : BLRPinStateUp];
    [selectedAttempt setPin8:self.pin8Button.selected ? BLRPinStateDown : BLRPinStateUp];
    [selectedAttempt setPin9:self.pin9Button.selected ? BLRPinStateDown : BLRPinStateUp];
    [selectedAttempt setPin10:self.pin10Button.selected ? BLRPinStateDown : BLRPinStateUp];
}

- (void)updatePinButtonsForAttempt
{
    [self setPinButtonSelection: self.gameManager.selectedAttempt];
    [self setPinEnabledState: self.gameManager.selectedFrame];
}

- (void)setPinEnabledState:(Frame *)currentFrame
{
    switch (currentFrame.currentAttempt) {
        case BLRCurrentAttemptFirst:
            [self enableAllPins];
            break;
        case BLRCurrentAttemptSecond:
            [self disablePinsForSecondAttempt: currentFrame.firstAttempt];
            break;
        case BLRCurrentAttemptThird:
            break;
        default:
            break;
    }
}

- (void)enableAllPins
{
    for(UIButton *button in self.pinsCollection)
    {
        button.enabled = YES;
    }
}

// Pins can't be knocked down on the 2nd Attempt if they were knocked down on the 1st Attempt
- (void)disablePinsForSecondAttempt:(Attempt *)firstAttempt
{
    self.pin1Button.enabled = firstAttempt.pin1 == BLRPinStateUp ? YES : NO;
    self.pin2Button.enabled = firstAttempt.pin2 == BLRPinStateUp ? YES : NO;
    self.pin3Button.enabled = firstAttempt.pin3 == BLRPinStateUp ? YES : NO;
    self.pin4Button.enabled = firstAttempt.pin4 == BLRPinStateUp ? YES : NO;
    self.pin5Button.enabled = firstAttempt.pin5 == BLRPinStateUp ? YES : NO;
    self.pin6Button.enabled = firstAttempt.pin6 == BLRPinStateUp ? YES : NO;
    self.pin7Button.enabled = firstAttempt.pin7 == BLRPinStateUp ? YES : NO;
    self.pin8Button.enabled = firstAttempt.pin8 == BLRPinStateUp ? YES : NO;
    self.pin9Button.enabled = firstAttempt.pin9 == BLRPinStateUp ? YES : NO;
    self.pin10Button.enabled = firstAttempt.pin10 == BLRPinStateUp ? YES : NO;
}

- (void)setPinButtonSelection:(Attempt *)selectedAttempt
{
    self.pin1Button.selected = selectedAttempt.pin1 == BLRPinStateDown ? YES : NO;
    self.pin2Button.selected = selectedAttempt.pin2 == BLRPinStateDown ? YES : NO;
    self.pin3Button.selected = selectedAttempt.pin3 == BLRPinStateDown ? YES : NO;
    self.pin4Button.selected = selectedAttempt.pin4 == BLRPinStateDown ? YES : NO;
    self.pin5Button.selected = selectedAttempt.pin5 == BLRPinStateDown ? YES : NO;
    self.pin6Button.selected = selectedAttempt.pin6 == BLRPinStateDown ? YES : NO;
    self.pin7Button.selected = selectedAttempt.pin7 == BLRPinStateDown ? YES : NO;
    self.pin8Button.selected = selectedAttempt.pin8 == BLRPinStateDown ? YES : NO;
    self.pin9Button.selected = selectedAttempt.pin9 == BLRPinStateDown ? YES : NO;
    self.pin10Button.selected = selectedAttempt.pin10 == BLRPinStateDown ? YES : NO;
}

- (void)shouldUpdatePinsForSpare:(BOOL)spareOccurred
{
    [self shouldUpdatePinStateForAttempt: self.gameManager.selectedAttempt update:spareOccurred];
}

- (void)shouldUpdatePinStateForAttempt:(Attempt *)selectedAttempt
                                update:(BOOL)spareOccurred
{
    if(spareOccurred)
    {
        selectedAttempt.pin1 = self.pin1Button.enabled ? BLRPinStateDown : BLRPinStateUp;
        selectedAttempt.pin2 = self.pin2Button.enabled ? BLRPinStateDown : BLRPinStateUp;
        selectedAttempt.pin3 = self.pin3Button.enabled ? BLRPinStateDown : BLRPinStateUp;
        selectedAttempt.pin4 = self.pin4Button.enabled ? BLRPinStateDown : BLRPinStateUp;
        selectedAttempt.pin5 = self.pin5Button.enabled ? BLRPinStateDown : BLRPinStateUp;
        selectedAttempt.pin6 = self.pin6Button.enabled ? BLRPinStateDown : BLRPinStateUp;
        selectedAttempt.pin7 = self.pin7Button.enabled ? BLRPinStateDown : BLRPinStateUp;
        selectedAttempt.pin8 = self.pin8Button.enabled ? BLRPinStateDown : BLRPinStateUp;
        selectedAttempt.pin9 = self.pin9Button.enabled ? BLRPinStateDown : BLRPinStateUp;
        selectedAttempt.pin10 = self.pin10Button.enabled ? BLRPinStateDown : BLRPinStateUp;
    }
    else
    {
        [selectedAttempt setAllPinsStateForAttempt:BLRPinStateUp];
    }
}

- (void)pinButtonsEnabled:(BOOL)enable
{
    for(UIButton *button in self.pinsCollection)
    {
        [button setEnabled:enable];
    }
}

- (void)setScoreForAttempt
{
    [self.gameManager.selectedAttempt countPinsForScore];
}

- (void)setScoreForFrame
{
    [self.gameManager.selectedFrame computeTotalFrameScore];
}

- (IBAction)numberPadButtonAction
{
    [[NSNotificationCenter defaultCenter] postNotificationName: bUpdateGameInterface
                                                        object: nil];
    [self.animationDelegate animateToNumberPadScreen];
}

- (void)updateInterface
{
    [self updatePinButtonsForAttempt];
}

@end
