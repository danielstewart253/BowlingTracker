//
//  BLRLogManager.m
//  Bowlr
//
//  Created by Daniel Stewart on 3/13/17.
//  Copyright © 2017 Daniel Stewart. All rights reserved.
//

#import "BLRLogManager.h"

@interface BLRLogManager ()

@property(strong, nonatomic) BLRGameManager *gameManager;

@end

@implementation BLRLogManager

- (instancetype)initWithGameManager:(BLRGameManager *)manager
{
    self = [super init];
    if(self)
    {
        self.gameManager = manager;
    }
    
    return self;
}

- (void)logCurrentFrame
{
    NSLog(@"---------------Frame %i-----------------", self.gameManager.selectedFrame.frameNumber);
    NSLog(@"Current Attempt %@", [self convertCurrentAttemptToString: self.gameManager.selectedFrame.currentAttempt]);
    NSLog(@"Result %@", [self convertFrameResultToString: self.gameManager.selectedFrame.result]);
    NSLog(@"Total Frame Score %i", self.gameManager.selectedFrame.scoreForFrame);
    NSLog(@"---------------Frame %i-----------------", self.gameManager.selectedFrame.frameNumber);
}

- (void)logCurrentAttempt
{
    NSLog(@"---------------Attempt-----------------");
    NSLog(@"Score For Attempt %i", self.gameManager.selectedAttempt.scoreForAttempt);
    NSLog(@"Result %@", [self convertAttemptResultToString: self.gameManager.selectedAttempt.result]);
    NSLog(@"Remaining Pins %i", self.gameManager.selectedAttempt.remainingPinsAfterAttempt);
    NSLog(@"---------------Attempt-----------------");
}

- (NSString *)convertFrameResultToString:(BLRFrameResult)frameResult
{
    switch (frameResult) {
        case BLRFrameResultStrike:
            return @"Strike";
            break;
        case BLRFrameResultSpare:
            return @"Spare";
            break;
        case BLRFrameResultNoAttempt:
            return @"No Attempt";
            break;
        case BLRFrameResultOpenFrame:
            return @"Open Frame";
            break;
        default:
            break;
    }
}

- (NSString *)convertCurrentAttemptToString:(BLRCurrentAttempt)currentAttempt
{
    switch (currentAttempt) {
        case BLRCurrentAttemptFirst:
            return @"First Attempt";
            break;
        case BLRCurrentAttemptSecond:
            return @"Second Attempt";
            break;
        case BLRCurrentAttemptThird:
            return @"Third Attempt";
            break;
        default:
            break;
    }
}

- (NSString *)convertAttemptResultToString:(BLRAttemptResult)attemptResult
{
    switch (attemptResult) {
        case BLRAttemptResultFoul:
            return @"Foul";
            break;
        case BLRAttemptResultStrike:
            return @"Strike";
            break;
        case BLRAttemptResultSpare:
            return @"Spare";
            break;
        case BLRAttemptResultMiss:
            return @"Miss";
            break;
        case BLRAttemptResultSplit:
            return @"Split";
            break;
        case BLRAttemptResultGutter:
            return @"Gutter";
            break;
        case BLRAttemptResultSplitConverted:
            return @"Split Converted";
            break;
        case BLRAttemptResultPointsRecorded:
            return @"Points Recorded";
            break;
        case BLRAttemptResultNoAttempt:
            return @"No Attempt";
            break;
        default:
            break;
    }
}

@end
