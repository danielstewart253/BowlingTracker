//
//  Game.m
//  Bowlr
//
//  Created by Daniel Stewart on 12/9/14.
//  Copyright (c) 2014 Daniel Stewart. All rights reserved.
//

#import "Game.h"

#define bAllBowlrs @"allBowlrs"
#define bAllFrames @"allFrames"
#define bGameDate @"gameDate"
#define bGameAlley @"gameAlley"
#define bGameID @"gameID"
#define bCurrentScore @"currentScore"
#define bTotalScore @"totalScore"
#define bGameResult @"gameResult"

@implementation Game

- (id)init
{
    self = [super init];
    if(self)
    {
        self.gameID = [[NSNumber alloc] initWithInt: 0];
        self.currentScore = 0;
        self.totalScore = 0;
        self.date = nil;
        self.alley = nil;
        self.result = BLRGameResultSoloGame;
        self.allBowlrs = [[NSMutableArray alloc] init];
        
        self.allFrames = [NSMutableArray new];
        for(int i = 1; i < 11; i++)
        {
            Frame *newFrame = [[Frame alloc]init];
            newFrame.frameNumber = i;
            
            [self.allFrames addObject:newFrame];
        }
        
        for(int i = 0; i < [self.allFrames count]; i++)
        {
            if(i + 1 < [self.allFrames count])
            {
                Frame *firstFrame = [self.allFrames objectAtIndex: i];
                firstFrame.nextFrame = [self.allFrames objectAtIndex: i + 1];
            }
        }
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.dateFormat = @"M/dd/yyyy";
        self.date = [dateFormatter stringFromDate: [NSDate date]];
    }
    
    return self;
}

- (id)initWithBowlrs:(NSMutableArray *)allBowlrs
           allFrames:(NSMutableArray *)allFrames
                date:(NSString *)date
               alley:(NSString *)alley
              gameID:(NSNumber *)gameID
        currentScore:(int)currentScore
          totalScore:(int)totalScore
              result:(BLRGameResult)result
{
    self = [super init];
    
    if(self)
    {
        self.allBowlrs = allBowlrs;
        self.allFrames = allFrames;
        self.date = date;
        self.alley = alley;
        self.gameID = gameID;
        self.currentScore = currentScore;
        self.totalScore = totalScore;
        self.result = result;
    }
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject: self.allBowlrs forKey: bAllBowlrs];
    [aCoder encodeObject: self.allFrames forKey: bAllFrames];
    [aCoder encodeObject: self.date forKey: bGameDate];
    [aCoder encodeObject: self.alley forKey: bGameAlley];
    [aCoder encodeObject: self.gameID forKey: bGameID];
    [aCoder encodeInt: self.currentScore forKey: bCurrentScore];
    [aCoder encodeInt: self.totalScore forKey: bTotalScore];
    [aCoder encodeInteger: self.result forKey: bGameResult];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    return [self initWithBowlrs: [aDecoder decodeObjectForKey: bAllBowlrs]
                      allFrames: [aDecoder decodeObjectForKey: bAllFrames]
                           date: [aDecoder decodeObjectForKey: bGameDate]
                          alley: [aDecoder decodeObjectForKey: bGameAlley]
                         gameID: [aDecoder decodeObjectForKey: bGameID]
                   currentScore: [aDecoder decodeIntForKey: bCurrentScore]
                     totalScore: [aDecoder decodeIntForKey: bTotalScore]
                         result: [aDecoder decodeIntForKey: bGameResult]];
}

@end
