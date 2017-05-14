//
//  Frame+Utils.h
//  Bowlr
//
//  Created by Daniel Stewart on 1/24/15.
//  Copyright (c) 2015 Daniel Stewart. All rights reserved.
//

#import "Frame.h"

@interface Frame (Utils)

- (void)resetFutureAttempts;
- (int)computeTotalFrameScore;
- (int)computeRemainingPinsAfterFrame;
- (void)resetPinsForFirstAttempt;
- (void)knockDownPinsForFirstAttempt;
- (BOOL)hasAttemptOccurred;
- (BOOL)hasSparedOccurred;
- (BOOL)hasStrikeOccurred;

@end
