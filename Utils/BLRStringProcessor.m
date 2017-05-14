//
//  BLRStringProcessor.m
//  Bowlr
//
//  Created by Daniel Stewart on 3/20/17.
//  Copyright © 2017 Daniel Stewart. All rights reserved.
//

#import "BLRStringProcessor.h"

@implementation BLRStringProcessor

+ (NSString *)stringForAttemptResult:(Attempt *)attempt
{
    switch (attempt.result) {
        case BLRAttemptResultFoul:
            return @"F";
            break;
        case BLRAttemptResultGutter:
            return @"-";
            break;
        case BLRAttemptResultMiss:
            return @"-";
            break;
        case BLRAttemptResultStrike:
            return @"X";
            break;
        case BLRAttemptResultSpare:
            return @"/";
            break;
        case BLRAttemptResultNoAttempt:
            return @"";
            break;
        case BLRAttemptResultPointsRecorded:
            return [NSString stringWithFormat: @"%i", attempt.scoreForAttempt];
            break;
        default:
            return nil;
            break;
    }
}

+ (NSString *)stringForFrameScore:(Frame *)frame
{
    return (frame.result == BLRFrameResultNoAttempt) ? @"" : [NSString stringWithFormat: @"%i", frame.scoreForFrame];
}

@end
