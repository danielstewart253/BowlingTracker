//
//  BLRPlayerHistoryRecord+Utils.h
//  Bowlr
//
//  Created by Daniel Stewart on 4/22/17.
//  Copyright © 2017 Daniel Stewart. All rights reserved.
//

#import "BLRPlayerHistoryRecord.h"

@interface BLRPlayerHistoryRecord (Utils)

- (void)updateStatistics:(Game *)newGame;
- (void)setTotalPinfall:(Game *)currentGame;
- (float)returnAveragePinfall;
- (void)setScore:(Game *)currentGame;
- (float)returnAverageScore;
- (void)setTotalOpenFrames:(Game *)currentGame;
- (float)returnAverageOpenFrames;
- (void)setTotalStrikes:(Game *)currentGame;
- (float)returnAverageStrikes;
- (void)setTotalSpares:(Game *)currentGame;
- (float)returnAverageSpares;
- (void)setTotalSplits:(Game *)currentGame;
- (float)returnAverageSplits;
- (void)setTotalSplitsConverted:(Game *)currentGame;
- (float)returnAverageSplitsConverted;
- (void)setTotalGutterBalls:(Game *)currentGame;
- (float)returnAverageGutterBalls;
- (void)setTotalFouls:(Game *)currentGame;
- (float)returnAverageFouls;
- (void)setTotalFirstBallPinfall:(Game *)currentGame;
- (float)returnAverageFirstBallPinfall;
- (void)setTotalFirstSpeedAttempts:(Game *)currentGame;
- (void)setTotalFirstBallSpeed:(Game *)currentGame;
- (float)returnAverageFirstBallSpeed;
- (void)setTotalSecondSpeedAttempts:(Game *)currentGame;
- (void)setTotalSecondBallSpeed:(Game *)currentGame;
- (float)returnAverageSecondBallSpeed;

@end
