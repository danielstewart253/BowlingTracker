//
//  Attempt+Utils.m
//  Bowlr
//
//  Created by Daniel Stewart on 1/1/15.
//  Copyright (c) 2015 Daniel Stewart. All rights reserved.
//

#import "Attempt+Utils.h"

@implementation Attempt (Utils)

- (void)shouldSetScoreToStrike:(BOOL)setStrike
{
    self.scoreForAttempt = setStrike ? BLR_STRIKE_SCORE : BLR_NO_ATTEMPT_SCORE;
}

- (void)shouldSetScoreToSpare:(BOOL)setSpare
            firstAttemptScore:(int)firstAttemptScore
{
    int spareScore = BLR_ATTEMPT_MAX_SCORE - firstAttemptScore;
    self.scoreForAttempt = setSpare ? spareScore : BLR_NO_ATTEMPT_SCORE;
}

- (void)setNumberPadScoreForAttempt:(int)score
{
    self.scoreForAttempt = (self.scoreForAttempt == score) ? 0 : score;
}

- (void)countPinsForScore
{
    int score = 0;
    
    score = self.pin1 == BLRPinStateDown ? score + 1 : score;
    score = self.pin2 == BLRPinStateDown ? score + 1 : score;
    score = self.pin3 == BLRPinStateDown ? score + 1 : score;
    score = self.pin4 == BLRPinStateDown ? score + 1 : score;
    score = self.pin5 == BLRPinStateDown ? score + 1 : score;
    score = self.pin6 == BLRPinStateDown ? score + 1 : score;
    score = self.pin7 == BLRPinStateDown ? score + 1 : score;
    score = self.pin8 == BLRPinStateDown ? score + 1 : score;
    score = self.pin9 == BLRPinStateDown ? score + 1 : score;
    score = self.pin10 == BLRPinStateDown ? score + 1 : score;
    
    self.scoreForAttempt = score;
}

- (void)setAllPinsStateForAttempt:(BLRPinState)pinState
{
    self.pin1 = pinState;
    self.pin2 = pinState;
    self.pin3 = pinState;
    self.pin4 = pinState;
    self.pin5 = pinState;
    self.pin6 = pinState;
    self.pin7 = pinState;
    self.pin8 = pinState;
    self.pin9 = pinState;
    self.pin10 = pinState;
}

@end
