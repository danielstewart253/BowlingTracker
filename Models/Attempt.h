//
//  Attempt.h
//  Bowlr
//
//  Created by Daniel Stewart on 12/9/14.
//  Copyright (c) 2014 Daniel Stewart. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Attempt : NSObject <NSCoding>

@property (readwrite, nonatomic) int scoreForAttempt;
@property (readwrite, nonatomic) double ballSpeedForAttempt;
@property (readwrite, nonatomic) double firstComponentBallSpeed;
@property (readwrite, nonatomic) double secondComponentBallSpeed;
@property (readwrite, nonatomic) int remainingPinsAfterAttempt;

@property (readwrite, nonatomic) BLRAttemptResult result;

@property (readwrite, nonatomic) BLRPinState pin1;
@property (readwrite, nonatomic) BLRPinState pin2;
@property (readwrite, nonatomic) BLRPinState pin3;
@property (readwrite, nonatomic) BLRPinState pin4;
@property (readwrite, nonatomic) BLRPinState pin5;
@property (readwrite, nonatomic) BLRPinState pin6;
@property (readwrite, nonatomic) BLRPinState pin7;
@property (readwrite, nonatomic) BLRPinState pin8;
@property (readwrite, nonatomic) BLRPinState pin9;
@property (readwrite, nonatomic) BLRPinState pin10;

@end
