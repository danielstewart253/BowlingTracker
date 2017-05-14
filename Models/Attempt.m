//
//  Attempt.m
//  Bowlr
//
//  Created by Daniel Stewart on 12/9/14.
//  Copyright (c) 2014 Daniel Stewart. All rights reserved.
//

#import "Attempt.h"

@implementation Attempt

- (id)init
{
    self = [super init];
    if(self)
    {
        self.scoreForAttempt = 0;
        self.ballSpeedForAttempt = 0;
        self.firstComponentBallSpeed = 0;
        self.secondComponentBallSpeed = 0;
        self.remainingPinsAfterAttempt = 10;
        self.result = BLRAttemptResultNoAttempt;
        self.pin1 = BLRPinStateUp;
        self.pin2 = BLRPinStateUp;
        self.pin3 = BLRPinStateUp;
        self.pin4 = BLRPinStateUp;
        self.pin5 = BLRPinStateUp;
        self.pin6 = BLRPinStateUp;
        self.pin7 = BLRPinStateUp;
        self.pin8 = BLRPinStateUp;
        self.pin9 = BLRPinStateUp;
        self.pin10 = BLRPinStateUp;
    }
    
    return self;
}

- (id)initWithScoreForAttempt:(int)scoreForAttempt
          ballSpeedForAttempt:(double)ballSpeedForAttempt
      firstComponentBallSpeed:(double)firstComponentBallSpeed
     secondComponentBallSpeed:(double)secondComponentBallSpeed
    remainingPinsAfterAttempt:(int)remainingPinsAfterAttempt
                attemptResult:(BLRAttemptResult)attemptResult
                    pin1State:(BLRPinState)pin1State
                    pin2State:(BLRPinState)pin2State
                    pin3State:(BLRPinState)pin3State
                    pin4State:(BLRPinState)pin4State
                    pin5State:(BLRPinState)pin5State
                    pin6State:(BLRPinState)pin6State
                    pin7State:(BLRPinState)pin7State
                    pin8State:(BLRPinState)pin8State
                    pin9State:(BLRPinState)pin9State
                   pin10State:(BLRPinState)pin10State
{
    self = [super init];
    if(self)
    {
        self.scoreForAttempt = scoreForAttempt;
        self.ballSpeedForAttempt = ballSpeedForAttempt;
        self.firstComponentBallSpeed = firstComponentBallSpeed;
        self.secondComponentBallSpeed = secondComponentBallSpeed;
        self.remainingPinsAfterAttempt = remainingPinsAfterAttempt;
        self.result = attemptResult;
        
        self.pin1 = pin1State;
        self.pin2 = pin2State;
        self.pin3 = pin3State;
        self.pin4 = pin4State;
        self.pin5 = pin5State;
        self.pin6 = pin6State;
        self.pin7 = pin7State;
        self.pin8 = pin8State;
        self.pin9 = pin9State;
        self.pin10 = pin10State;
    }
    
    return self;
}

// Saves the Attempt object
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeInt: self.scoreForAttempt forKey: @"scoreForAttempt"];
    [aCoder encodeDouble: self.ballSpeedForAttempt forKey: @"ballSpeedForAttempt"];
    [aCoder encodeDouble: self.firstComponentBallSpeed forKey: @"firstComponentBallSpeed"];
    [aCoder encodeDouble: self.secondComponentBallSpeed forKey: @"secondComponentBallSpeed"];
    [aCoder encodeInt: self.remainingPinsAfterAttempt forKey: @"remainingPinsAfterAttempt"];
    [aCoder encodeInt: self.result forKey: @"attemptResult"];
    
    [aCoder encodeInt: self.pin1 forKey: @"pin1State"];
    [aCoder encodeInt: self.pin2 forKey: @"pin2State"];
    [aCoder encodeInt: self.pin3 forKey: @"pin3State"];
    [aCoder encodeInt: self.pin4 forKey: @"pin4State"];
    [aCoder encodeInt: self.pin5 forKey: @"pin5State"];
    [aCoder encodeInt: self.pin6 forKey: @"pin6State"];
    [aCoder encodeInt: self.pin7 forKey: @"pin7State"];
    [aCoder encodeInt: self.pin8 forKey: @"pin8State"];
    [aCoder encodeInt: self.pin9 forKey: @"pin9State"];
    [aCoder encodeInt: self.pin10 forKey: @"pin10State"];
}

// Loads the Attempt object
- (id)initWithCoder:(NSCoder *)aDecoder
{
    int scoreForAttempt = [aDecoder decodeIntForKey: @"scoreForAttempt"];
    double ballSpeedForAttempt = [aDecoder decodeDoubleForKey: @"ballSpeedForAttempt"];
    double firstComponentBallSpeed = [aDecoder decodeDoubleForKey: @"firstComponentBallSpeed"];
    double secondComponentBallSpeed = [aDecoder decodeDoubleForKey: @"secondComponentBallSpeed"];
    
    int remainingPinsAfterAttempt = [aDecoder decodeIntForKey: @"remainingPinsAfterAttempt"];
    BLRAttemptResult attemptResult = [aDecoder decodeIntegerForKey: @"attemptResult"];
    
    BLRPinState pin1 = [aDecoder decodeBoolForKey: @"pin1State"];
    BLRPinState pin2 = [aDecoder decodeBoolForKey: @"pin2State"];
    BLRPinState pin3 = [aDecoder decodeBoolForKey: @"pin3State"];
    BLRPinState pin4 = [aDecoder decodeBoolForKey: @"pin4State"];
    BLRPinState pin5 = [aDecoder decodeBoolForKey: @"pin5State"];
    BLRPinState pin6 = [aDecoder decodeBoolForKey: @"pin6State"];
    BLRPinState pin7 = [aDecoder decodeBoolForKey: @"pin7State"];
    BLRPinState pin8 = [aDecoder decodeBoolForKey: @"pin8State"];
    BLRPinState pin9 = [aDecoder decodeBoolForKey: @"pin9State"];
    BLRPinState pin10 = [aDecoder decodeBoolForKey: @"pin10State"];
    
    return [self initWithScoreForAttempt: scoreForAttempt
                     ballSpeedForAttempt: ballSpeedForAttempt
                 firstComponentBallSpeed: firstComponentBallSpeed
                secondComponentBallSpeed: secondComponentBallSpeed
               remainingPinsAfterAttempt: remainingPinsAfterAttempt
                           attemptResult: attemptResult
                               pin1State: pin1
                               pin2State: pin2
                               pin3State: pin3
                               pin4State: pin4
                               pin5State: pin5
                               pin6State: pin6
                               pin7State: pin7
                               pin8State: pin8
                               pin9State: pin9
                              pin10State: pin10];
}

@end
