//
//  Player.h
//  Bowlr
//
//  Created by Daniel Stewart on 4/11/17.
//  Copyright © 2017 Daniel Stewart. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BLRPlayerHistoryRecord.h"
#import "Game.h"
#import "Achievement.h"

@interface Player : NSObject <NSCoding>

@property(strong, nonatomic) NSString *name;
@property(strong, nonatomic) Game *currentGame;
@property(strong, nonatomic) Game *previousGame;
@property(strong, nonatomic) BLRPlayerHistoryRecord *gameHistory;
@property(strong, nonatomic) NSMutableArray *listOfAchievements;
@property(strong, nonatomic) NSMutableArray *previousAchievements;

- (instancetype)initWithName:(NSString *)name;
- (instancetype)initWithCoder:(NSCoder *)aDecoder;

- (void)encodeWithCoder:(NSCoder *)aCoder;

- (instancetype)initWithName:(NSString *)name
                 currentGame:(Game *)currentGame
                previousGame:(Game*)previousGame
                 gameHistory:(BLRPlayerHistoryRecord *)gameHistory
          listOfAchievements:(NSMutableArray *)listOfAchievements
        previousAchievements:(NSMutableArray *)previousAchievements;

@end
