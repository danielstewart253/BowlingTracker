//
//  BLRPlayerHistoryRecord.h
//  Bowlr
//
//  Created by Daniel Stewart on 4/12/17.
//  Copyright © 2017 Daniel Stewart. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BLRPlayerHistoryRecord : NSObject <NSCoding>

@property (strong, nonatomic) NSMutableArray *listOfGames;
@property (strong, nonatomic) NSNumber *pinfall;
@property (strong, nonatomic) NSNumber *totalScore;
@property (strong, nonatomic) NSNumber *highScore;
@property (strong, nonatomic) NSNumber *lowScore;
@property (strong, nonatomic) NSNumber *openFrames;
@property (strong, nonatomic) NSNumber *strikes;
@property (strong, nonatomic) NSNumber *spares;
@property (strong, nonatomic) NSNumber *splits;
@property (strong, nonatomic) NSNumber *splitConversions;
@property (strong, nonatomic) NSNumber *gutterBalls;
@property (strong, nonatomic) NSNumber *fouls;
@property (strong, nonatomic) NSNumber *losses;
@property (strong, nonatomic) NSNumber *wins;
@property (strong, nonatomic) NSNumber *firstBallPinfall;
@property (strong, nonatomic) NSNumber *firstSpeedAttempts;
@property (strong, nonatomic) NSNumber *secondSpeedAttempts;
@property (strong, nonatomic) NSNumber *firstBallSpeed;
@property (strong, nonatomic) NSNumber *secondBallSpeed;

@end
