//
//  BLRPlayerHistoryRecord.m
//  Bowlr
//
//  Created by Daniel Stewart on 4/12/17.
//  Copyright © 2017 Daniel Stewart. All rights reserved.
//

#import "BLRPlayerHistoryRecord.h"

#define bListOfGames @"listOfGames"
#define bTotalPinfall @"totalPinfall"
#define bTotalScore @"totalScore"
#define bHighScore @"highScore"
#define bLowScore @"lowScore"
#define bTotalOpen @"totalOpen"
#define bTotalStrikes @"totalStrikes"
#define bTotalSpares @"totalSpares"
#define bTotalSplits @"totalSplits"
#define bTotalConverted @"totalConverted"
#define bTotalGutters @"totalGutters"
#define bTotalFouls @"totalFouls"
#define bTotalGames @"totalGames"
#define bTotalLosses @"totalLosses"
#define bTotalWins @"totalWins"
#define bTotalFirstPinfall @"totalFirstPinfall"
#define bTotalFirstSpeedAttempt @"totalFirstSpeedAttempt"
#define bTotalSecondSpeedAttempt @"totalSecondSpeedAttempt"
#define bTotalFirstBallspeed @"totalFirstBallSpeed"
#define bTotalSecondBallspeed @"totalSecondBallSpeed"

@implementation BLRPlayerHistoryRecord

- (instancetype)init
{
    self = [super init];
    if(self)
    {
        self.listOfGames = [NSMutableArray new];
        self.pinfall = [[NSNumber alloc] initWithFloat: 0];
        self.totalScore = [[NSNumber alloc] initWithInt: 0];
        self.highScore = [[NSNumber alloc] initWithInt: 0];
        self.lowScore = [[NSNumber alloc] initWithInt: 0];
        self.openFrames = [[NSNumber alloc] initWithInt: 0];
        self.strikes = [[NSNumber alloc] initWithInt: 0];
        self.spares = [[NSNumber alloc] initWithFloat: 0];
        self.splits = [[NSNumber alloc] initWithFloat: 0];
        self.splitConversions = [[NSNumber alloc] initWithFloat: 0];
        self.gutterBalls = [[NSNumber alloc] initWithFloat: 0];
        self.fouls = [[NSNumber alloc] initWithFloat: 0];
        self.losses = [[NSNumber alloc] initWithFloat: 0];
        self.wins = [[NSNumber alloc] initWithFloat: 0];
        self.firstBallPinfall = [[NSNumber alloc] initWithFloat: 0];
        self.firstSpeedAttempts = [[NSNumber alloc] initWithFloat: 0];
        self.secondSpeedAttempts = [[NSNumber alloc] initWithFloat: 0];
        self.firstBallSpeed = [[NSNumber alloc] initWithFloat: 0];
        self.secondBallSpeed = [[NSNumber alloc] initWithFloat: 0];
    }
    
    return self;
}

- (instancetype)initWithListOfGames:(NSMutableArray *)listOfGames
                            pinfall:(NSNumber *)pinfall
                              score:(NSNumber *)totalScore
                          highScore:(NSNumber *)highScore
                           lowScore:(NSNumber *)lowScore
                         openFrames:(NSNumber *)openFrames
                            strikes:(NSNumber *)strikes
                             spares:(NSNumber *)spares
                             splits:(NSNumber *)splits
                          converted:(NSNumber *)splitsConverted
                            gutters:(NSNumber *)gutterBalls
                              fouls:(NSNumber *)fouls
                             losses:(NSNumber *)losses
                               wins:(NSNumber *)wins
                       firstPinfall:(NSNumber *)firstPinfall
                 firstSpeedAttempts:(NSNumber *)firstSpeedAttempts
                secondSpeedAttempts:(NSNumber *)secondSpeedAttempts
                     firstBallSpeed:(NSNumber *)firstBallSpeed
                    secondBallSpeed:(NSNumber *)secondBallSpeed
{
    self = [super init];
    if(self)
    {
        self.listOfGames = listOfGames;
        self.pinfall = pinfall;
        self.totalScore = totalScore;
        self.highScore = highScore;
        self.lowScore = lowScore;
        self.openFrames = openFrames;
        self.strikes = strikes;
        self.spares = spares;
        self.splits = splits;
        self.splitConversions = splitsConverted;
        self.gutterBalls = gutterBalls;
        self.fouls = fouls;
        self.losses = losses;
        self.wins = wins;
        self.firstBallPinfall = firstPinfall;
        self.firstSpeedAttempts = firstSpeedAttempts;
        self.secondSpeedAttempts = secondSpeedAttempts;
        self.firstBallSpeed = firstBallSpeed;
        self.secondBallSpeed = secondBallSpeed;
    }
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject: self.listOfGames forKey: bListOfGames];
    [aCoder encodeObject: self.pinfall forKey: bTotalPinfall];
    [aCoder encodeObject: self.totalScore forKey: bTotalScore];
    [aCoder encodeObject: self.highScore forKey: bHighScore];
    [aCoder encodeObject: self.lowScore forKey: bLowScore];
    [aCoder encodeObject: self.openFrames forKey: bTotalOpen];
    [aCoder encodeObject: self.strikes forKey: bTotalStrikes];
    [aCoder encodeObject: self.spares forKey: bTotalSpares];
    [aCoder encodeObject: self.splits forKey: bTotalSplits];
    [aCoder encodeObject: self.splitConversions forKey: bTotalConverted];
    [aCoder encodeObject: self.gutterBalls forKey: bTotalGutters];
    [aCoder encodeObject: self.fouls forKey: bTotalFouls];
    [aCoder encodeObject: self.losses forKey: bTotalLosses];
    [aCoder encodeObject: self.wins forKey: bTotalWins];
    [aCoder encodeObject: self.firstBallPinfall forKey: bTotalFirstPinfall];
    [aCoder encodeObject: self.firstSpeedAttempts forKey: bTotalFirstSpeedAttempt];
    [aCoder encodeObject: self.secondSpeedAttempts forKey: bTotalSecondSpeedAttempt];
    [aCoder encodeObject: self.firstBallSpeed forKey: bTotalFirstBallspeed];
    [aCoder encodeObject: self.secondBallSpeed forKey: bTotalSecondBallspeed];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    return [self initWithListOfGames: [aDecoder decodeObjectForKey: bListOfGames]
                             pinfall: [aDecoder decodeObjectForKey: bTotalPinfall]
                               score: [aDecoder decodeObjectForKey: bTotalScore]
                           highScore: [aDecoder decodeObjectForKey: bHighScore]
                            lowScore: [aDecoder decodeObjectForKey: bLowScore]
                          openFrames: [aDecoder decodeObjectForKey: bTotalOpen]
                             strikes: [aDecoder decodeObjectForKey: bTotalStrikes]
                              spares: [aDecoder decodeObjectForKey: bTotalSpares]
                              splits: [aDecoder decodeObjectForKey: bTotalSplits]
                           converted: [aDecoder decodeObjectForKey: bTotalConverted]
                             gutters: [aDecoder decodeObjectForKey: bTotalGutters]
                               fouls: [aDecoder decodeObjectForKey: bTotalFouls]
                              losses: [aDecoder decodeObjectForKey: bTotalLosses]
                                wins: [aDecoder decodeObjectForKey: bTotalWins]
                        firstPinfall: [aDecoder decodeObjectForKey: bTotalFirstPinfall]
                  firstSpeedAttempts: [aDecoder decodeObjectForKey: bTotalFirstSpeedAttempt]
                 secondSpeedAttempts: [aDecoder decodeObjectForKey: bTotalSecondSpeedAttempt]
                      firstBallSpeed: [aDecoder decodeObjectForKey: bTotalFirstBallspeed]
                     secondBallSpeed: [aDecoder decodeObjectForKey: bTotalSecondBallspeed]];
}

@end
