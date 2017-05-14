//
//  BLRStateProcessor.m
//  Bowlr
//
//  Created by Daniel Stewart on 3/7/17.
//  Copyright © 2017 Daniel Stewart. All rights reserved.
//

#import "BLRStateProcessor.h"

@implementation BLRStateProcessor

- (void)determineState:(Frame *)currentFrame
{
    switch(currentFrame.currentAttempt)
    {
        case BLRCurrentAttemptFirst:
            [self determineFirstAttemptResult: currentFrame.firstAttempt];
            break;
        case BLRCurrentAttemptSecond:
            [self determineSecondAttemptResult: currentFrame.secondAttempt
                                  firstAttempt: currentFrame.firstAttempt];
            break;
        case BLRCurrentAttemptThird:
            break;
        default:
            break;
    }
    
    [self determineFrameState:currentFrame];
}

- (void)determineFrameState:(Frame *)currentFrame
{
    if([currentFrame hasStrikeOccurred])
    {
        currentFrame.result = BLRFrameResultStrike;
    }
    else if([currentFrame hasSparedOccurred])
    {
        currentFrame.result = BLRFrameResultSpare;
    }
    else if([currentFrame hasAttemptOccurred])
    {
        currentFrame.result = BLRFrameResultNoAttempt;
    }
    else
    {
        currentFrame.result = BLRFrameResultOpenFrame;
    }
}

- (void)determineFirstAttemptResult:(Attempt *)attempt
{    
    if(attempt.scoreForAttempt == 10)
    {
        attempt.result = BLRAttemptResultStrike;
    }
    
    else if(attempt.scoreForAttempt > 0)
    {
        attempt.result = BLRAttemptResultPointsRecorded;
    }
    else
    {
        attempt.result = BLRAttemptResultNoAttempt;
    }
}

- (void)determineSecondAttemptResult:(Attempt *)secondAttempt
                        firstAttempt:(Attempt *)firstAttempt
{
    if(firstAttempt.scoreForAttempt + secondAttempt.scoreForAttempt == 10)
    {
        secondAttempt.result = BLRAttemptResultSpare;
    }
    
    else if(secondAttempt.scoreForAttempt > 0)
    {
        secondAttempt.result = BLRAttemptResultPointsRecorded;
    }
    else
    {
        secondAttempt.result = BLRAttemptResultNoAttempt;
    }
}

- (void)setStrikeStateForAttempt:(Attempt *)currentAttempt
{
    currentAttempt.result = currentAttempt.result == BLRAttemptResultStrike ? BLRAttemptResultNoAttempt : BLRAttemptResultStrike;
}

@end
