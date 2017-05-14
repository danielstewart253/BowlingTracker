//
//  BLRAchievementsManager.h
//  Bowlr
//
//  Created by Daniel Stewart on 7/12/15.
//  Copyright (c) 2015 Daniel Stewart. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BLRAchievementsManager : NSObject

+ (instancetype)sharedManager;

- (BOOL)checkForPrecisionAchievementForPlayer:(Player *)player
                                    withFrame:(Frame *)currentFrame;

- (BOOL)checkForJuggernautAchievementForPlayer:(Player *)player
                                      withGame:(Game *)currentGame;

- (BOOL)checkForTurkeyAchievementForPlayer:(Player *)player
                                 withFrame:(Frame *)currentFrame;

- (BOOL)checkForFatTurkeyAchievementForPlayer:(Player *)player;
- (BOOL)checkForThanksgivingDinnerAchievementForPlayer:(Player *)player;
- (BOOL)checkForPerfectionAchievementForPlayer:(Player *)player;
- (BOOL)checkForFailAchievementForPlayer:(Player *)player;
- (BOOL)checkForEpicFailAchievementForPlayer:(Player *)player;
- (BOOL)checkForImpressiveAchievementForPlayer:(Player *)player
                                     withFrame:(Frame *)currentFrame;

- (BOOL)checkForHowTheAchievementForPlayer:(Player *)player
                                 withFrame:(Frame *)currentFrame;

- (BOOL)checkFor1235SpareAchievementForPlayer:(Player *)player
                                    withFrame:(Frame *)currentFrame;

- (BOOL)checkFor2458SpareAchievementForPlayer:(Player *)player
                                    withFrame:(Frame *)currentFrame;

- (BOOL)checkFor3569SpareAchievementForPlayer:(Player *)player
                                    withFrame:(Frame *)currentFrame;

- (BOOL)checkFor1247SpareAchievementForPlayer:(Player *)player
                                    withFrame:(Frame *)currentFrame;

- (BOOL)checkFor13610SpareAchievementForPlayer:(Player *)player
                                     withFrame:(Frame *)currentFrame;

- (BOOL)checkFor15SpareAchievementForPlayer:(Player *)player
                                  withFrame:(Frame *)currentFrame;

- (BOOL)checkFor28SpareAchievementForPlayer:(Player *)player
                                  withFrame:(Frame *)currentFrame;

- (BOOL)checkFor39SpareAchievementForPlayer:(Player *)player
                                  withFrame:(Frame *)currentFrame;

- (BOOL)checkForStrikeoutAchievementForPlayer:(Player *)player;
- (BOOL)checkForEliteAchievementForPlayer:(Player *)player;

- (BOOL)checkForBackFromTheDeadAchievement:(Player *)winner allBowlrs:(NSArray *)allBowlrs;
- (BOOL)checkForHumiliationAchievement:(Player *)winner allBowlrs:(NSArray *)allBowlrs;
- (BOOL)checkForIntimidationAchievement:(Player *)winner allBowlrs:(NSArray *)allBowlrs;
- (void)resetEndOfGameAchievements:(NSArray *)allBowlrs;

@end
