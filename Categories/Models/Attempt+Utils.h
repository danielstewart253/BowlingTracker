//
//  Attempt+Utils.h
//  Bowlr
//
//  Created by Daniel Stewart on 1/1/15.
//  Copyright (c) 2015 Daniel Stewart. All rights reserved.
//

#import "Attempt.h"

@interface Attempt (Utils)

- (void)shouldSetScoreToStrike:(BOOL)setStrike;
- (void)shouldSetScoreToSpare:(BOOL)setSpare
            firstAttemptScore:(int)firstAttemptScore;
- (void)setNumberPadScoreForAttempt:(int)score;
- (void)countPinsForScore;
- (void)setAllPinsStateForAttempt:(BLRPinState)pinState;

@end
