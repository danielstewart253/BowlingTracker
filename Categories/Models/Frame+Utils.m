//
//  Frame+Utils.m
//  Bowlr
//
//  Created by Daniel Stewart on 1/24/15.
//  Copyright (c) 2015 Daniel Stewart. All rights reserved.
//

#import "Frame+Utils.h"

@implementation Frame (Utils)

- (void)resetFutureAttempts
{
    if(self.currentAttempt == BLRCurrentAttemptFirst)
    {
        [self resetSecondAttempt];
        [self resetThirdAttempt];
    }
    else if(self.currentAttempt == BLRCurrentAttemptSecond)
    {
        [self resetThirdAttempt];
    }
}

- (void)resetSecondAttempt
{
    self.secondAttempt = [[Attempt alloc] init];
}

- (void)resetThirdAttempt
{
    self.thirdAttempt = [[Attempt alloc] init];
}

- (int)computeTotalFrameScore
{
    if (self.frameNumber == 10)
    {
        self.scoreForFrame = self.firstAttempt.scoreForAttempt
        + self.secondAttempt.scoreForAttempt + self.thirdAttempt.scoreForAttempt;
        
        return self.scoreForFrame;
    }
    else
    {
        self.scoreForFrame = self.firstAttempt.scoreForAttempt
        + self.secondAttempt.scoreForAttempt;
        
        return self.scoreForFrame;
    }
}

- (int)computeRemainingPinsAfterFrame
{
    if((self.frameNumber == bFrameNumberTen) && (self.firstAttempt.result == BLRAttemptResultStrike || self.secondAttempt.result == BLRAttemptResultSpare))
    {
        return 10 - self.firstAttempt.remainingPinsAfterAttempt + self.secondAttempt.remainingPinsAfterAttempt + 10 - self.thirdAttempt.remainingPinsAfterAttempt;;
    }
    
    return 10 - self.firstAttempt.remainingPinsAfterAttempt + self.secondAttempt.remainingPinsAfterAttempt;
}
// Set all pins to up for the first Attempt
- (void)resetPinsForFirstAttempt
{
    self.firstAttempt.pin1 = BLRPinStateUp;
    self.firstAttempt.pin2 = BLRPinStateUp;
    self.firstAttempt.pin3 = BLRPinStateUp;
    self.firstAttempt.pin4 = BLRPinStateUp;
    self.firstAttempt.pin5 = BLRPinStateUp;
    self.firstAttempt.pin6 = BLRPinStateUp;
    self.firstAttempt.pin7 = BLRPinStateUp;
    self.firstAttempt.pin8 = BLRPinStateUp;
    self.firstAttempt.pin9 = BLRPinStateUp;
    self.firstAttempt.pin10 = BLRPinStateUp;
}

// Set all pins to down for the first Attempt
- (void)knockDownPinsForFirstAttempt
{
    self.firstAttempt.pin1 = BLRPinStateDown;
    self.firstAttempt.pin2 = BLRPinStateDown;
    self.firstAttempt.pin3 = BLRPinStateDown;
    self.firstAttempt.pin4 = BLRPinStateDown;
    self.firstAttempt.pin5 = BLRPinStateDown;
    self.firstAttempt.pin6 = BLRPinStateDown;
    self.firstAttempt.pin7 = BLRPinStateDown;
    self.firstAttempt.pin8 = BLRPinStateDown;
    self.firstAttempt.pin9 = BLRPinStateDown;
    self.firstAttempt.pin10 = BLRPinStateDown;
}

- (BOOL)hasAttemptOccurred
{
    return self.firstAttempt.result == BLRAttemptResultNoAttempt && self.secondAttempt.result == BLRAttemptResultNoAttempt && self.thirdAttempt.result == BLRAttemptResultNoAttempt;
}

- (BOOL)hasSparedOccurred
{
    return self.secondAttempt.result == BLRAttemptResultSpare || self.thirdAttempt.result == BLRAttemptResultSpare;
}

- (BOOL)hasStrikeOccurred
{
    return self.firstAttempt.result == BLRAttemptResultStrike || self.thirdAttempt.result == BLRAttemptResultStrike;
}

@end
