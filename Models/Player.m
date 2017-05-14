//
//  Player.m
//  Bowlr
//
//  Created by Daniel Stewart on 4/11/17.
//  Copyright © 2017 Daniel Stewart. All rights reserved.
//

#import "Player.h"

#define bPlayerName @"playerName"
#define bCurrentGame @"currentGame"
#define bPreviousGame @"previousGame"
#define bGameHistory @"gameHistory"
#define bAchievementsList @"listOfAchievements"
#define bPreviousAchievements @"previousAchievements"

@implementation Player

- (instancetype)initWithName:(NSString *)name
{
    self = [self init];
    if(self)
    {
        self.name = name;
    }
    
    return self;
}

- (instancetype)init
{
    self = [super init];
    if(self)
    {
        self.gameHistory = [[BLRPlayerHistoryRecord alloc] init];
        self.listOfAchievements = [NSMutableArray new];
        self.previousAchievements = [NSMutableArray new];
    
        self.name = nil;
        self.currentGame = nil;
        self.previousGame = nil;
        
        //Initialize each Achievement by title and description
        [self.listOfAchievements addObject: [[Achievement alloc] initWithTitle: bPrecision
                                                                   description: @"Pick up 3 Consecutive Spares"]];
        [self.listOfAchievements addObject: [[Achievement alloc] initWithTitle: bJuggernaut
                                                                   description: @"Spare Every Frame"]];
        [self.listOfAchievements addObject: [[Achievement alloc] initWithTitle: bTurkey
                                                                   description: @"Get 3 Straight Strikes"]];
        [self.listOfAchievements addObject: [[Achievement alloc] initWithTitle: bFatTurkey
                                                                   description: @"Get 5 Straight Strikes"]];
        [self.listOfAchievements addObject: [[Achievement alloc] initWithTitle: bThanksgivingDinner
                                                                   description: @"Get 7 Straight Strikes"]];
        [self.listOfAchievements addObject: [[Achievement alloc] initWithTitle: bPerfection
                                                                   description: @"Bowl a Perfect Game"]];
        [self.listOfAchievements addObject: [[Achievement alloc] initWithTitle: bIntimidation
                                                                   description: @"Beat all Players by at Least 50 Pins"]];
        [self.listOfAchievements addObject: [[Achievement alloc] initWithTitle: bHumiliation
                                                                   description: @"Beat all Players by at Least 100 Pins"]];
        [self.listOfAchievements addObject: [[Achievement alloc] initWithTitle: bBackFromDead
                                                                   description: @"Come Back from a Defecit of 50 Pins Or More To Win"]];
        [self.listOfAchievements addObject: [[Achievement alloc] initWithTitle: bFail
                                                                   description: @"Sparing the 10th Frame but Missing the Strike"]];
        [self.listOfAchievements addObject: [[Achievement alloc] initWithTitle: bEpicFail
                                                                   description: @"Start the 10th Frame w/2 Strikes and Missing the Turkey"]];
        [self.listOfAchievements addObject: [[Achievement alloc] initWithTitle: bImpressive
                                                                   description: @"Pick up a 4-6 Split"]];
        [self.listOfAchievements addObject: [[Achievement alloc] initWithTitle: bHowThe
                                                                   description: @"Pick up a 7-10 Split"]];
        [self.listOfAchievements addObject: [[Achievement alloc] initWithTitle: bGotBling
                                                                   description: @"Pick up a 1-2-3-5, 2-4-5-8, or 3-5-6-9 Spare"]];
        [self.listOfAchievements addObject: [[Achievement alloc] initWithTitle: bDominos
                                                                   description: @"Pick up a 1-2-4-7 or a 1-3-6-10 Spare"]];
        [self.listOfAchievements addObject: [[Achievement alloc] initWithTitle: bSleeper
                                                                   description: @"Pick up a 1-5, 2-8, or a 3-9 Spare"]];
        [self.listOfAchievements addObject: [[Achievement alloc] initWithTitle: bStrikeout
                                                                   description: @"Get 3 Strikes on the 10th Frame"]];
        [self.listOfAchievements addObject: [[Achievement alloc] initWithTitle: bElite
                                                                   description: @"Complete all Challenges"]];
    }
    
    return self;
}

- (instancetype)initWithName:(NSString *)name
                 currentGame:(Game *)currentGame
                previousGame:(Game*)previousGame
                 gameHistory:(BLRPlayerHistoryRecord *)gameHistory
          listOfAchievements:(NSMutableArray *)listOfAchievements
        previousAchievements:(NSMutableArray *)previousAchievements
{
    self = [super init];
    if(self)
    {
        self.name = name;
        self.currentGame = currentGame;
        self.previousGame = previousGame;
        self.gameHistory = gameHistory;
        self.listOfAchievements = listOfAchievements;
        self.previousAchievements = previousAchievements;
    }
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject: self.name forKey: bPlayerName];
    [aCoder encodeObject: self.currentGame forKey: bCurrentGame];
    [aCoder encodeObject: self.previousGame forKey: bPreviousGame];
    [aCoder encodeObject: self.gameHistory forKey: bGameHistory];
    [aCoder encodeObject: self.listOfAchievements forKey: bAchievementsList];
    [aCoder encodeObject: self.previousAchievements forKey: bPreviousAchievements];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    return [self initWithName: [aDecoder decodeObjectForKey: bPlayerName]
                  currentGame: [aDecoder decodeObjectForKey: bCurrentGame]
                 previousGame: [aDecoder decodeObjectForKey: bPreviousGame]
                  gameHistory: [aDecoder decodeObjectForKey: bGameHistory]
           listOfAchievements: [aDecoder decodeObjectForKey: bAchievementsList]
         previousAchievements: [aDecoder decodeObjectForKey: bPreviousAchievements]];
}

// Check to see if Player recorded a Strike on each Attempt of the 10th Frame
- (BOOL)checkForStrikeoutAchievement
{
    Achievement *currentAchievement = [self.listOfAchievements objectAtIndex:16];
    Frame *frame10 = [self.currentGame.allFrames objectAtIndex:9];
    
    if(currentAchievement.achievementEarnedInCurrentGame)
    {
        if(frame10.firstAttempt.result != BLRAttemptResultStrike || frame10.secondAttempt.result != BLRAttemptResultStrike || frame10.thirdAttempt.result != BLRAttemptResultStrike)
        {
            currentAchievement.achievementEarnedInCurrentGame = NO;
            currentAchievement.achievementWasEarned = NO;
            currentAchievement.frameNumberEarned = 0;
            currentAchievement.dateEarned = nil;
            currentAchievement.gameID = nil;
        }
        return NO;
    }
    if(!currentAchievement.achievementWasEarned)
    {
        if(frame10.firstAttempt.result == BLRAttemptResultStrike && frame10.secondAttempt.result == BLRAttemptResultStrike && frame10.thirdAttempt.result == BLRAttemptResultStrike)
        {
            currentAchievement.achievementEarnedInCurrentGame = YES;
            currentAchievement.achievementWasEarned = YES;
            currentAchievement.frameNumberEarned = 10;
            
            currentAchievement.dateEarned = self.currentGame.date;
            NSNumber *gameID = [[NSNumber alloc]initWithInt:[self.currentGame.gameID intValue]];
            currentAchievement.gameID = gameID;
            return YES;
        }
    }
    
    return NO;
}

@end
