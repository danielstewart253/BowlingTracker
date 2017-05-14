//
//  Achievement.m
//  Bowlr
//
//  Created by Daniel Stewart on 12/9/14.
//  Copyright (c) 2014 Daniel Stewart. All rights reserved.
//

#import "Achievement.h"

@implementation Achievement

- (id)initWithTitle:(NSString *)title
        description:(NSString *)description
{
    self = [super init];
    if(self)
    {
        self.dateEarned = nil;
        self.title = title;
        self.achievementDescription = nil;
        self.gameID = [[NSNumber alloc] initWithInt: 0];
        self.achievementEarnedInCurrentGame = NO;
        self.achievementWasEarned = NO;
        self.frameNumberEarned = 0;
    }
    
    return self;
}

- (id)initWithTitle:(NSString *)title
        description:(NSString *)description
         dateEarned:(NSString *)dateEarned
             gameID:(NSNumber *)gameID
  frameNumberEarned:(int)frameNumberEarned
achievementWasEarned:(BOOL)achievementWasEarned
achievementEarnedInCurrentGame:(BOOL)achievementEarnedInCurrentGame
{
    self = [super init];

    if(self)
    {
        self.title = title;
        self.achievementDescription = description;
        self.gameID = gameID;
        self.dateEarned = dateEarned;
        self.frameNumberEarned = frameNumberEarned;
        self.achievementWasEarned = achievementWasEarned;
        self.achievementEarnedInCurrentGame = achievementEarnedInCurrentGame;
    }
    
    return self;
}

// Saves the Achievement object
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.dateEarned forKey: @"dateEarned"];
    [aCoder encodeObject:self.title forKey: @"title"];
    [aCoder encodeObject:self.gameID forKey: @"achievementGameID"];
    [aCoder encodeBool:self.achievementEarnedInCurrentGame forKey: @"achievementInCurrentGame"];
    [aCoder encodeBool:self.achievementWasEarned forKey: @"achievementWasEarned"];
    [aCoder encodeObject: self.achievementDescription forKey: @"description"];
    [aCoder encodeInt:self.frameNumberEarned forKey: @"frameNumberEarned"];
}

// Loads the Achievement object
- (id)initWithCoder:(NSCoder *)aDecoder
{
    NSString *dateEarned = [aDecoder decodeObjectForKey: @"dateEarned"];
    NSString *title = [aDecoder decodeObjectForKey: @"title"];
    NSNumber *gameID = [aDecoder decodeObjectForKey: @"achievementGameID"];
    BOOL achievementEarnedInCurrentGame = [aDecoder decodeBoolForKey: @"achievementInCurrentGame"];
    BOOL achievementWasEarned = [aDecoder decodeBoolForKey: @"achievementWasEarned"];
    NSString *description = [aDecoder decodeObjectForKey: @"description"];
    int frameNumberEarned = [aDecoder decodeIntForKey: @"frameNumberEarned"];
    
    return [self initWithTitle: title
                   description: description
                    dateEarned: dateEarned
                        gameID: gameID
             frameNumberEarned: frameNumberEarned
          achievementWasEarned: achievementWasEarned
achievementEarnedInCurrentGame: achievementEarnedInCurrentGame];
}

@end
