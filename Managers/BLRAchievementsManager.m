//
//  BLRAchievementsManager.m
//  Bowlr
//
//  Created by Daniel Stewart on 7/12/15.
//  Copyright (c) 2015 Daniel Stewart. All rights reserved.
//

#import "BLRAchievementsManager.h"

@implementation BLRAchievementsManager

+ (instancetype)sharedManager
{
    static dispatch_once_t once;
    static id sharedInstance;
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

// Check to see if Player achieved 3 Spares in a row
- (BOOL)checkForPrecisionAchievementForPlayer:(Player *)player
                                    withFrame:(Frame *)currentFrame
{
    Achievement *currentAchievement = [player.listOfAchievements objectAtIndex:0];
    
    // If the Achievement was already earned during this game, check to see if
    // any score changes might change the Achievement back to unearned
    if(currentAchievement.achievementEarnedInCurrentGame)
    {
        if((currentFrame.frameNumber > currentAchievement.frameNumberEarned - 3) && (currentFrame.frameNumber <= currentAchievement.frameNumberEarned))
        {
            // Check the Frames to see if Achievement is still valid
            int firstFrameIndex = currentAchievement.frameNumberEarned - 1;
            int secondFrameIndex = currentAchievement.frameNumberEarned - 2;
            int thirdFrameIndex = currentAchievement.frameNumberEarned - 3;
            
            Frame *firstFrame = [player.currentGame.allFrames objectAtIndex:firstFrameIndex];
            Frame *secondFrame = [player.currentGame.allFrames objectAtIndex:secondFrameIndex];
            Frame *thirdFrame = [player.currentGame.allFrames objectAtIndex:thirdFrameIndex];
            
            // For the 10th Frame, check to see if a Spare occurred on the 8th & 9th Frames,
            // and on the 2nd Attempt of the 10th Frame
            if(firstFrame.frameNumber == 10)
            {
                if(firstFrame.secondAttempt.result != BLRAttemptResultSpare || secondFrame.result != BLRFrameResultSpare || thirdFrame.result != BLRFrameResultSpare)
                {
                    // If a Spare did not occur on all 3 Frames, reset Achievement variables
                    currentAchievement.achievementEarnedInCurrentGame = NO;
                    currentAchievement.achievementWasEarned = NO;
                    currentAchievement.gameID = nil;
                    currentAchievement.frameNumberEarned = 0;
                    
                    // Initialize the date of the Achievement
                    currentAchievement.dateEarned = nil;
                    return NO;
                }
            }
            
            // If not the 10th Frame
            if(firstFrame.frameNumber != 10)
            {
                if(firstFrame.result != BLRAttemptResultSpare || secondFrame.result != BLRAttemptResultSpare || thirdFrame.result != BLRAttemptResultSpare)
                {
                    // If a Spare did not occur on all 3 Frames, reset Achievement variables
                    currentAchievement.achievementEarnedInCurrentGame = NO;
                    currentAchievement.achievementWasEarned = NO;
                    currentAchievement.gameID = nil;
                    currentAchievement.frameNumberEarned = 0;
                    
                    // Initialize the date of the Achievement
                    currentAchievement.dateEarned = nil;
                    return NO;
                }
            }
        }
    }
    
    // If the Achievement was not earned in a previous Game
    if(!currentAchievement.achievementWasEarned)
    {
        // If the current Frame is 3 or less, check Frames 1-3
        if(currentFrame.frameNumber <= 3)
        {
            // Check the Frames to see if Achievement was earned
            Frame *firstFrame = [player.currentGame.allFrames objectAtIndex:2];
            Frame *secondFrame = [player.currentGame.allFrames objectAtIndex:1];
            Frame *thirdFrame = [player.currentGame.allFrames objectAtIndex:0];
            
            if(firstFrame.result == BLRFrameResultSpare && secondFrame.result == BLRFrameResultSpare && thirdFrame.result == BLRFrameResultSpare)
            {
                currentAchievement.achievementEarnedInCurrentGame = YES;
                currentAchievement.achievementWasEarned = YES;
                currentAchievement.frameNumberEarned = currentFrame.frameNumber;
                
                currentAchievement.dateEarned = player.currentGame.date;
                NSNumber *gameID = [[NSNumber alloc]initWithInt:[player.currentGame.gameID intValue]];
                currentAchievement.gameID = gameID;
                return YES;
                
            }
            return NO;
        }
        
        // Get index of previous 2 Frames
        int firstFrameIndex = currentFrame.frameNumber - 2;
        int secondFrameIndex = currentFrame.frameNumber - 3;
        Frame *firstFrame = [player.currentGame.allFrames objectAtIndex:firstFrameIndex];
        Frame *secondFrame = [player.currentGame.allFrames objectAtIndex:secondFrameIndex];
        
        // If a spare occurred on the 8th & 9th Frame, and the 2nd Attempt of the 10th Frame
        if(currentFrame.frameNumber == 10)
        {
            if(firstFrame.result == BLRFrameResultSpare && secondFrame.result == BLRFrameResultSpare && currentFrame.secondAttempt.result == BLRAttemptResultSpare)
            {
                currentAchievement.achievementEarnedInCurrentGame = YES;
                currentAchievement.achievementWasEarned = YES;
                currentAchievement.frameNumberEarned = currentFrame.frameNumber;
                
                currentAchievement.dateEarned = player.currentGame.date;
                NSNumber *gameID = [[NSNumber alloc]initWithInt:[player.currentGame.gameID intValue]];
                currentAchievement.gameID = gameID;
                return YES;
            }
        }
        
        if(currentFrame.frameNumber != 10)
        {
            if(firstFrame.result == BLRFrameResultSpare && secondFrame.result == BLRFrameResultSpare && currentFrame.result == BLRFrameResultSpare)
            {
                currentAchievement.achievementEarnedInCurrentGame = YES;
                currentAchievement.achievementWasEarned = YES;
                currentAchievement.frameNumberEarned = currentFrame.frameNumber;
                
                currentAchievement.dateEarned = player.currentGame.date;
                NSNumber *gameID = [[NSNumber alloc]initWithInt:[player.currentGame.gameID intValue]];
                currentAchievement.gameID = gameID;
                return YES;
            }
        }
    }
    
    return NO;
}

// Check to see if Player achieved a Spare on every Frame
- (BOOL)checkForJuggernautAchievementForPlayer:(Player *)player withGame:(Game *)currentGame
{
    Achievement *currentAchievement = [player.listOfAchievements objectAtIndex:1];
    
    // If the Achievement was already earned during this game, check to see if
    // any score changes might change the Achievement back to unearned
    if(currentAchievement.achievementEarnedInCurrentGame)
    {
        Frame *tenthFrame = [currentGame.allFrames objectAtIndex:9];
        if(tenthFrame.secondAttempt.result != BLRAttemptResultSpare)
        {
            currentAchievement.achievementEarnedInCurrentGame = NO;
            currentAchievement.achievementWasEarned = NO;
            currentAchievement.frameNumberEarned = 0;
            currentAchievement.dateEarned = nil;
            currentAchievement.gameID = nil;
            return NO;
        }
        
        for(int i = 0; i < 9; i++)
        {
            Frame *frame = [currentGame.allFrames objectAtIndex:i];
            if(frame.result != BLRFrameResultSpare)
            {
                currentAchievement.achievementEarnedInCurrentGame = NO;
                currentAchievement.achievementWasEarned = NO;
                currentAchievement.frameNumberEarned = 0;
                currentAchievement.dateEarned = nil;
                currentAchievement.gameID = nil;
                return NO;
            }
        }
        return  NO;
    }
    if(!currentAchievement.achievementWasEarned)
    {
        Frame *frame10 = [currentGame.allFrames objectAtIndex:9];
        if(frame10.secondAttempt.result != BLRAttemptResultSpare)
        {
            return NO;
        }
        for(int i = 0; i < 9; i++)
        {
            Frame *frame = [currentGame.allFrames objectAtIndex:i];
            if(frame.result != BLRFrameResultSpare)
            {
                return NO;
            }
        }
        
        currentAchievement.achievementEarnedInCurrentGame = YES;
        currentAchievement.achievementWasEarned = YES;
        currentAchievement.frameNumberEarned = 10;
        currentAchievement.dateEarned = currentGame.date;
        NSNumber *gameID = [[NSNumber alloc] initWithInt: [currentGame.gameID intValue]];
        currentAchievement.gameID = gameID;
        return YES;
    }
    
    return YES;
}

// Check to see if Player achieved 3 Strikes in a row
- (BOOL)checkForTurkeyAchievementForPlayer:(Player *)player withFrame:(Frame *)currentFrame
{
    Achievement *currentAchievement = [player.listOfAchievements objectAtIndex:2];
    
    // If the Achievement was already earned during this game, check to see if
    // any score changes might change the Achievement back to unearned
    if(currentAchievement.achievementEarnedInCurrentGame)
    {
        // If the Achievement was earned on Frame 10, check all the cases of Frame 10 to see
        // if the Achievement is still valid
        if(currentAchievement.frameNumberEarned == 10)
        {
            Frame *firstFrame = [player.currentGame.allFrames objectAtIndex:currentAchievement.frameNumberEarned - 1];
            Frame *secondFrame = [player.currentGame.allFrames objectAtIndex:currentAchievement.frameNumberEarned - 2];
            Frame *thirdFrame = [player.currentGame.allFrames objectAtIndex:currentAchievement.frameNumberEarned - 3];
            
            if(firstFrame.firstAttempt.result != BLRAttemptResultStrike || firstFrame.secondAttempt.result != BLRAttemptResultStrike || firstFrame.thirdAttempt.result != BLRAttemptResultStrike)
            {
                if(firstFrame.firstAttempt.result != BLRAttemptResultStrike || firstFrame.secondAttempt.result != BLRAttemptResultStrike || secondFrame.result != BLRFrameResultStrike)
                {
                    if(firstFrame.firstAttempt.result != BLRAttemptResultStrike || secondFrame.result != BLRFrameResultStrike || thirdFrame.result != BLRFrameResultStrike)
                    {
                        currentAchievement.achievementEarnedInCurrentGame = NO;
                        currentAchievement.achievementWasEarned = NO;
                        currentAchievement.frameNumberEarned = 0;
                        currentAchievement.dateEarned = nil;
                        currentAchievement.gameID = nil;
                    }
                }
            }
        }
        
        // For all other Frames, check for 3 consecutive Strikes
        else
        {
            Frame *firstFrame = [player.currentGame.allFrames objectAtIndex:currentAchievement.frameNumberEarned - 1];
            Frame *secondFrame = [player.currentGame.allFrames objectAtIndex:currentAchievement.frameNumberEarned - 2];
            Frame *thirdFrame = [player.currentGame.allFrames objectAtIndex:currentAchievement.frameNumberEarned - 3];
            if(firstFrame.result != BLRAttemptResultStrike || secondFrame.result != BLRAttemptResultStrike || thirdFrame.result != BLRAttemptResultStrike)
            {
                currentAchievement.achievementEarnedInCurrentGame = NO;
                currentAchievement.achievementWasEarned = NO;
                currentAchievement.frameNumberEarned = 0;
                currentAchievement.dateEarned = nil;
                currentAchievement.gameID = nil;
            }
        }
        return NO;
    }
    
    // If the Achievement was not earned previously
    if(!currentAchievement.achievementWasEarned)
    {
        for(int i = 0; i < 8; i++)
        {
            Frame *firstFrame = [player.currentGame.allFrames objectAtIndex:i];
            Frame *secondFrame = [player.currentGame.allFrames objectAtIndex: i + 1];
            Frame *thirdFrame = [player.currentGame.allFrames objectAtIndex:i + 2];
            
            if(thirdFrame.frameNumber == 10)
            {
                if(thirdFrame.firstAttempt.result == BLRAttemptResultStrike && thirdFrame.secondAttempt.result == BLRAttemptResultStrike && thirdFrame.thirdAttempt.result == BLRAttemptResultStrike)
                {
                    currentAchievement.achievementEarnedInCurrentGame = YES;
                    currentAchievement.achievementWasEarned = YES;
                    currentAchievement.frameNumberEarned = 10;
                    
                    currentAchievement.dateEarned = player.currentGame.date;
                    NSNumber *gameID = [[NSNumber alloc]initWithInt:[player.currentGame.gameID intValue]];
                    currentAchievement.gameID = gameID;
                    return YES;
                }
                else if(thirdFrame.firstAttempt.result == BLRAttemptResultStrike && thirdFrame.secondAttempt.result == BLRAttemptResultStrike && secondFrame.result == BLRFrameResultStrike)
                {
                    currentAchievement.achievementEarnedInCurrentGame = YES;
                    currentAchievement.achievementWasEarned = YES;
                    currentAchievement.frameNumberEarned = 10;
                    
                    currentAchievement.dateEarned = player.currentGame.date;
                    NSNumber *gameID = [[NSNumber alloc]initWithInt:[player.currentGame.gameID intValue]];
                    currentAchievement.gameID = gameID;
                    return YES;
                }
                else if(thirdFrame.firstAttempt.result == BLRAttemptResultStrike && secondFrame.result == BLRFrameResultStrike && firstFrame.result == BLRFrameResultStrike)
                {
                    currentAchievement.achievementEarnedInCurrentGame = YES;
                    currentAchievement.achievementWasEarned = YES;
                    currentAchievement.frameNumberEarned = 10;
                    
                    currentAchievement.dateEarned = player.currentGame.date;
                    NSNumber *gameID = [[NSNumber alloc]initWithInt:[player.currentGame.gameID intValue]];
                    currentAchievement.gameID = gameID;
                    return YES;
                }
            }
            else
            {
                if(firstFrame.result == BLRFrameResultStrike && secondFrame.result == BLRFrameResultStrike && thirdFrame.result == BLRFrameResultStrike)
                {
                    currentAchievement.achievementEarnedInCurrentGame = YES;
                    currentAchievement.achievementWasEarned = YES;
                    currentAchievement.frameNumberEarned = thirdFrame.frameNumber;
                    
                    currentAchievement.dateEarned = player.currentGame.date;
                    NSNumber *gameID = [[NSNumber alloc]initWithInt:[player.currentGame.gameID intValue]];
                    currentAchievement.gameID = gameID;
                    return YES;
                }
            }
        }
    }
    return NO;
}

// Check to see if Player achieved 5 Strikes in a row
- (BOOL)checkForFatTurkeyAchievementForPlayer:(Player *)player
{
    Achievement *currentAchievement = [player.listOfAchievements objectAtIndex:3];
    
    // If the Achievement was already earned during this game, check to see if
    // any score changes might change the Achievement back to unearned
    if(currentAchievement.achievementEarnedInCurrentGame)
    {
        // If the Achievement was earned on Frame 10, check all the cases of Frame 10 to see
        // if the Achievement is still valid
        if(currentAchievement.frameNumberEarned == 10)
        {
            Frame *firstFrame = [player.currentGame.allFrames objectAtIndex:currentAchievement.frameNumberEarned - 1];
            Frame *secondFrame = [player.currentGame.allFrames objectAtIndex:currentAchievement.frameNumberEarned - 2];
            Frame *thirdFrame = [player.currentGame.allFrames objectAtIndex:currentAchievement.frameNumberEarned - 3];
            Frame *fourthFrame = [player.currentGame.allFrames objectAtIndex:currentAchievement.frameNumberEarned - 4];
            Frame *fifthFrame = [player.currentGame.allFrames objectAtIndex:currentAchievement.frameNumberEarned - 5];
            
            // Check for Strikes on all 3 Attempts of the 10th Frame and for Frames 6-9
            if(firstFrame.firstAttempt.result != BLRAttemptResultStrike || firstFrame.secondAttempt.result != BLRAttemptResultStrike || firstFrame.thirdAttempt.result != BLRAttemptResultStrike || secondFrame.result != BLRFrameResultStrike || thirdFrame.result != BLRFrameResultStrike)
            {
                if(firstFrame.firstAttempt.result != BLRAttemptResultStrike || firstFrame.secondAttempt.result != BLRAttemptResultStrike || secondFrame.result != BLRFrameResultStrike || thirdFrame.result != BLRFrameResultStrike || fourthFrame.result != BLRFrameResultStrike)
                {
                    if(firstFrame.firstAttempt.result != BLRAttemptResultStrike || secondFrame.result != BLRFrameResultStrike || thirdFrame.result != BLRFrameResultStrike || fourthFrame.result != BLRFrameResultStrike || fifthFrame.result != BLRFrameResultStrike)
                    {
                        currentAchievement.achievementEarnedInCurrentGame = NO;
                        currentAchievement.achievementWasEarned = NO;
                        currentAchievement.frameNumberEarned = 0;
                        currentAchievement.dateEarned = nil;
                        currentAchievement.gameID = nil;
                        return NO;
                    }
                }
            }
        }
        
        // For all other Frames, check for 5 consecutive Strikes
        else
        {
            Frame *firstFrame = [player.currentGame.allFrames objectAtIndex:currentAchievement.frameNumberEarned - 1];
            Frame *secondFrame = [player.currentGame.allFrames objectAtIndex:currentAchievement.frameNumberEarned - 2];
            Frame *thirdFrame = [player.currentGame.allFrames objectAtIndex:currentAchievement.frameNumberEarned - 3];
            Frame *fourthFrame = [player.currentGame.allFrames objectAtIndex:currentAchievement.frameNumberEarned - 4];
            Frame *fifthFrame = [player.currentGame.allFrames objectAtIndex:currentAchievement.frameNumberEarned - 5];
            if(firstFrame.result != BLRFrameResultStrike || secondFrame.result != BLRFrameResultStrike || thirdFrame.result != BLRFrameResultStrike || fourthFrame.result != BLRFrameResultStrike || fifthFrame.result != BLRFrameResultStrike)
            {
                currentAchievement.achievementEarnedInCurrentGame = NO;
                currentAchievement.achievementWasEarned = NO;
                currentAchievement.frameNumberEarned = 0;
                currentAchievement.dateEarned = nil;
                currentAchievement.gameID = nil;
                return NO;
            }
        }
        return NO;
    }
    
    // If the Achievement was not earned previously
    if(!currentAchievement.achievementWasEarned)
    {
        for(int i = 0; i < 6; i++)
        {
            Frame *firstFrame = [player.currentGame.allFrames objectAtIndex:i];
            Frame *secondFrame = [player.currentGame.allFrames objectAtIndex: i + 1];
            Frame *thirdFrame = [player.currentGame.allFrames objectAtIndex:i + 2];
            Frame *fourthFrame = [player.currentGame.allFrames objectAtIndex:i + 3];
            Frame *fifthFrame = [player.currentGame.allFrames objectAtIndex: i + 4];
            
            if(fifthFrame.frameNumber == 10)
            {
                if(fifthFrame.firstAttempt.result == BLRAttemptResultStrike && fifthFrame.secondAttempt.result == BLRAttemptResultStrike && fifthFrame.thirdAttempt.result == BLRAttemptResultStrike && fourthFrame.result == BLRFrameResultStrike && thirdFrame.result == BLRFrameResultStrike)
                {
                    currentAchievement.achievementEarnedInCurrentGame = YES;
                    currentAchievement.achievementWasEarned = YES;
                    currentAchievement.frameNumberEarned = 10;
                    
                    currentAchievement.dateEarned = player.currentGame.date;
                    NSNumber *gameID = [[NSNumber alloc]initWithInt:[player.currentGame.gameID intValue]];
                    currentAchievement.gameID = gameID;
                    return YES;
                }
                else if(fifthFrame.firstAttempt.result == BLRAttemptResultStrike && fifthFrame.secondAttempt.result == BLRAttemptResultStrike && fourthFrame.result == BLRFrameResultStrike && thirdFrame.result == BLRFrameResultStrike && secondFrame.result == BLRFrameResultStrike)
                {
                    currentAchievement.achievementEarnedInCurrentGame = YES;
                    currentAchievement.achievementWasEarned = YES;
                    currentAchievement.frameNumberEarned = 10;
                    
                    currentAchievement.dateEarned = player.currentGame.date;
                    NSNumber *gameID = [[NSNumber alloc]initWithInt:[player.currentGame.gameID intValue]];
                    currentAchievement.gameID = gameID;
                    return YES;
                }
                else if(fifthFrame.firstAttempt.result == BLRAttemptResultStrike && fourthFrame.result == BLRFrameResultStrike && thirdFrame.result == BLRFrameResultStrike && secondFrame.result == BLRFrameResultStrike && firstFrame.result == BLRFrameResultStrike)
                {
                    currentAchievement.achievementEarnedInCurrentGame = YES;
                    currentAchievement.achievementWasEarned = YES;
                    currentAchievement.frameNumberEarned = 10;
                    
                    currentAchievement.dateEarned = player.currentGame.date;
                    NSNumber *gameID = [[NSNumber alloc]initWithInt:[player.currentGame.gameID intValue]];
                    currentAchievement.gameID = gameID;
                    return YES;
                }
            }
            else
            {
                if(fifthFrame.result == BLRFrameResultStrike && fourthFrame.result == BLRFrameResultStrike && thirdFrame.result == BLRFrameResultStrike && secondFrame.result == BLRFrameResultStrike && firstFrame.result == BLRFrameResultStrike)
                {
                    currentAchievement.achievementEarnedInCurrentGame = YES;
                    currentAchievement.achievementWasEarned = YES;
                    currentAchievement.frameNumberEarned = fifthFrame.frameNumber;
                    
                    currentAchievement.dateEarned = player.currentGame.date;
                    NSNumber *gameID = [[NSNumber alloc]initWithInt:[player.currentGame.gameID intValue]];
                    currentAchievement.gameID = gameID;
                    return YES;
                }
            }
        }
    }
    
    return NO;
}

// Check to see if Player achieved 7 Strikes in a row
- (BOOL)checkForThanksgivingDinnerAchievementForPlayer:(Player *)player
{
    Achievement *currentAchievement = [player.listOfAchievements objectAtIndex:4];
    
    // If the Achievement was already earned during this game, check to see if
    // any score changes might change the Achievement back to unearned
    if(currentAchievement.achievementEarnedInCurrentGame)
    {
        // If the Achievement was earned on Frame 10, check all the cases of Frame 10 to see
        // if the Achievement is still valid
        if(currentAchievement.frameNumberEarned == 10)
        {
            Frame *firstFrame = [player.currentGame.allFrames objectAtIndex:currentAchievement.frameNumberEarned - 1];
            Frame *secondFrame = [player.currentGame.allFrames objectAtIndex:currentAchievement.frameNumberEarned - 2];
            Frame *thirdFrame = [player.currentGame.allFrames objectAtIndex:currentAchievement.frameNumberEarned - 3];
            Frame *fourthFrame = [player.currentGame.allFrames objectAtIndex:currentAchievement.frameNumberEarned - 4];
            Frame *fifthFrame = [player.currentGame.allFrames objectAtIndex:currentAchievement.frameNumberEarned - 5];
            Frame *sixthFrame = [player.currentGame.allFrames objectAtIndex:currentAchievement.frameNumberEarned - 6];
            Frame *seventhFrame = [player.currentGame.allFrames objectAtIndex:currentAchievement.frameNumberEarned - 7];
            
            // Check for Strikes on all 3 Attempts of the 10th Frame and for Frames 4-9
            if(firstFrame.firstAttempt.result != BLRAttemptResultStrike || firstFrame.secondAttempt.result != BLRAttemptResultStrike || firstFrame.thirdAttempt.result != BLRAttemptResultStrike || secondFrame.result != BLRFrameResultStrike || thirdFrame.result != BLRFrameResultStrike || fourthFrame.result != BLRFrameResultStrike || fifthFrame.result != BLRFrameResultStrike)
            {
                if(firstFrame.firstAttempt.result != BLRAttemptResultStrike || firstFrame.secondAttempt.result != BLRAttemptResultStrike || secondFrame.result != BLRFrameResultStrike || thirdFrame.result != BLRFrameResultStrike || fourthFrame.result != BLRFrameResultStrike || fifthFrame.result != BLRFrameResultStrike || sixthFrame.result != BLRFrameResultStrike)
                {
                    if(firstFrame.firstAttempt.result != BLRAttemptResultStrike || secondFrame.result != BLRFrameResultStrike || thirdFrame.result != BLRFrameResultStrike || fourthFrame.result != BLRFrameResultStrike || fifthFrame.result != BLRFrameResultStrike || sixthFrame.result != BLRFrameResultStrike || seventhFrame.result != BLRFrameResultStrike)
                    {
                        currentAchievement.achievementEarnedInCurrentGame = NO;
                        currentAchievement.achievementWasEarned = NO;
                        currentAchievement.frameNumberEarned = 0;
                        currentAchievement.dateEarned = nil;
                        currentAchievement.gameID = nil;
                        return NO;
                    }
                }
            }
        }
        
        // For all other Frames, check for 5 consecutive Strikes
        else
        {
            Frame *firstFrame = [player.currentGame.allFrames objectAtIndex:currentAchievement.frameNumberEarned - 1];
            Frame *secondFrame = [player.currentGame.allFrames objectAtIndex:currentAchievement.frameNumberEarned - 2];
            Frame *thirdFrame = [player.currentGame.allFrames objectAtIndex:currentAchievement.frameNumberEarned - 3];
            Frame *fourthFrame = [player.currentGame.allFrames objectAtIndex:currentAchievement.frameNumberEarned - 4];
            Frame *fifthFrame = [player.currentGame.allFrames objectAtIndex:currentAchievement.frameNumberEarned - 5];
            Frame *sixthFrame = [player.currentGame.allFrames objectAtIndex:currentAchievement.frameNumberEarned - 6];
            Frame *seventhFrame = [player.currentGame.allFrames objectAtIndex:currentAchievement.frameNumberEarned - 7];
            if(firstFrame.result != BLRFrameResultStrike || secondFrame.result != BLRFrameResultStrike || thirdFrame.result != BLRFrameResultStrike || fourthFrame.result != BLRFrameResultStrike || fifthFrame.result != BLRFrameResultStrike || sixthFrame.result != BLRFrameResultStrike || seventhFrame.result != BLRFrameResultStrike)
            {
                currentAchievement.achievementEarnedInCurrentGame = NO;
                currentAchievement.achievementWasEarned = NO;
                currentAchievement.frameNumberEarned = 0;
                currentAchievement.dateEarned = nil;
                currentAchievement.gameID = nil;
                return NO;
            }
        }
        return NO;
    }
    
    // If the Achievement was not earned previously
    if(!currentAchievement.achievementWasEarned)
    {
        for(int i = 0; i < 4; i++)
        {
            Frame *firstFrame = [player.currentGame.allFrames objectAtIndex:i];
            Frame *secondFrame = [player.currentGame.allFrames objectAtIndex: i + 1];
            Frame *thirdFrame = [player.currentGame.allFrames objectAtIndex:i + 2];
            Frame *fourthFrame = [player.currentGame.allFrames objectAtIndex:i + 3];
            Frame *fifthFrame = [player.currentGame.allFrames objectAtIndex: i + 4];
            Frame *sixthFrame = [player.currentGame.allFrames objectAtIndex: i + 5];
            Frame *seventhFrame = [player.currentGame.allFrames objectAtIndex: i + 6];
            
            if(seventhFrame.frameNumber == 10)
            {
                if(seventhFrame.firstAttempt.result == BLRAttemptResultStrike && seventhFrame.secondAttempt.result == BLRAttemptResultStrike && seventhFrame.thirdAttempt.result == BLRAttemptResultStrike && sixthFrame.result == BLRFrameResultStrike && fifthFrame.result == BLRFrameResultStrike && fourthFrame.result == BLRFrameResultStrike && thirdFrame.result == BLRFrameResultStrike)
                {
                    currentAchievement.achievementEarnedInCurrentGame = YES;
                    currentAchievement.achievementWasEarned = YES;
                    currentAchievement.frameNumberEarned = 10;
                    
                    currentAchievement.dateEarned = player.currentGame.date;
                    NSNumber *gameID = [[NSNumber alloc]initWithInt:[player.currentGame.gameID intValue]];
                    currentAchievement.gameID = gameID;
                    return YES;
                }
                else if(seventhFrame.firstAttempt.result == BLRAttemptResultStrike && seventhFrame.secondAttempt.result == BLRAttemptResultStrike && sixthFrame.result == BLRFrameResultStrike && fifthFrame.result == BLRFrameResultStrike && fourthFrame.result == BLRFrameResultStrike && thirdFrame.result == BLRFrameResultStrike && secondFrame.result == BLRFrameResultStrike)
                {
                    currentAchievement.achievementEarnedInCurrentGame = YES;
                    currentAchievement.achievementWasEarned = YES;
                    currentAchievement.frameNumberEarned = 10;
                    
                    currentAchievement.dateEarned = player.currentGame.date;
                    NSNumber *gameID = [[NSNumber alloc]initWithInt:[player.currentGame.gameID intValue]];
                    currentAchievement.gameID = gameID;
                    return YES;
                }
                else if(seventhFrame.firstAttempt.result == BLRAttemptResultStrike && sixthFrame.result == BLRFrameResultStrike && fifthFrame.result == BLRFrameResultStrike && fourthFrame.result == BLRFrameResultStrike && thirdFrame.result == BLRFrameResultStrike && secondFrame.result == BLRFrameResultStrike && firstFrame.result == BLRFrameResultStrike)
                {
                    currentAchievement.achievementEarnedInCurrentGame = YES;
                    currentAchievement.achievementWasEarned = YES;
                    currentAchievement.frameNumberEarned = 10;
                    
                    currentAchievement.dateEarned = player.currentGame.date;
                    NSNumber *gameID = [[NSNumber alloc]initWithInt:[player.currentGame.gameID intValue]];
                    currentAchievement.gameID = gameID;
                    return YES;
                }
            }
            else
            {
                if(seventhFrame.result == BLRFrameResultStrike && sixthFrame.result == BLRFrameResultStrike && fifthFrame.result == BLRFrameResultStrike && fourthFrame.result == BLRFrameResultStrike && thirdFrame.result == BLRFrameResultStrike && secondFrame.result == BLRFrameResultStrike && firstFrame.result == BLRFrameResultStrike)
                {
                    currentAchievement.achievementEarnedInCurrentGame = YES;
                    currentAchievement.achievementWasEarned = YES;
                    currentAchievement.frameNumberEarned = seventhFrame.frameNumber;
                    
                    currentAchievement.dateEarned = player.currentGame.date;
                    NSNumber *gameID = [[NSNumber alloc]initWithInt:[player.currentGame.gameID intValue]];
                    currentAchievement.gameID = gameID;
                    return YES;
                }
            }
        }
    }
    return NO;
}

// Check to see if the Player achieved a Strike on every frame
- (BOOL)checkForPerfectionAchievementForPlayer:(Player *)player
{
    Achievement *currentAchievement = [player.listOfAchievements objectAtIndex:5];
    if(currentAchievement.achievementEarnedInCurrentGame)
    {
        for(int i = 0; i < 9; i++)
        {
            Frame *frame = [player.currentGame.allFrames objectAtIndex:i];
            if(frame.result != BLRFrameResultStrike)
            {
                currentAchievement.achievementEarnedInCurrentGame = NO;
                currentAchievement.achievementWasEarned = NO;
                currentAchievement.frameNumberEarned = 0;
                currentAchievement.dateEarned = nil;
                currentAchievement.gameID = nil;
                return NO;
            }
        }
        Frame *frame10 = [player.currentGame.allFrames objectAtIndex:9];
        if(frame10.firstAttempt.result != BLRAttemptResultStrike || frame10.secondAttempt.result != BLRAttemptResultStrike || frame10.thirdAttempt.result != BLRAttemptResultStrike)
        {
            currentAchievement.achievementEarnedInCurrentGame = NO;
            currentAchievement.achievementWasEarned = NO;
            currentAchievement.frameNumberEarned = 0;
            currentAchievement.dateEarned = nil;
            currentAchievement.gameID = nil;
            return NO;
        }
        return NO;
    }
    if(!currentAchievement.achievementWasEarned)
    {
        Frame *frame10 = [player.currentGame.allFrames objectAtIndex:9];
        if(frame10.firstAttempt.result != BLRAttemptResultStrike || frame10.secondAttempt.result != BLRAttemptResultStrike || frame10.thirdAttempt.result != BLRAttemptResultStrike)
        {
            return NO;
        }
        for(int i = 0; i < 9; i++)
        {
            Frame *frame = [player.currentGame.allFrames objectAtIndex:i];
            if(frame.result != BLRFrameResultStrike)
            {
                return NO;
            }
        }
        
        currentAchievement.achievementEarnedInCurrentGame = YES;
        currentAchievement.achievementWasEarned = YES;
        currentAchievement.frameNumberEarned = 10;
        
        currentAchievement.dateEarned = player.currentGame.date;
        NSNumber *gameID = [[NSNumber alloc]initWithInt:[player.currentGame.gameID intValue]];
        currentAchievement.gameID = gameID;
        return YES;
    }
    return NO;
}

// Check to see if the Player recorded a Spare on the 10th Frame and missed the Strike on the 3rd Attempt
- (BOOL)checkForFailAchievementForPlayer:(Player *)player
{
    Achievement *currentAchievement = [player.listOfAchievements objectAtIndex:9];
    Frame *frame10 = [player.currentGame.allFrames objectAtIndex:9];
    if(currentAchievement.achievementEarnedInCurrentGame)
    {
        if(frame10.secondAttempt.result != BLRAttemptResultSpare || frame10.thirdAttempt.result == BLRAttemptResultStrike)
        {
            currentAchievement.achievementEarnedInCurrentGame = NO;
            currentAchievement.achievementWasEarned = NO;
            currentAchievement.frameNumberEarned = 0;
            currentAchievement.dateEarned = nil;
            currentAchievement.gameID = nil;
            return NO;
        }
        
        return NO;
    }
    if(!currentAchievement.achievementWasEarned)
    {
        if(frame10.secondAttempt.result == BLRAttemptResultSpare && frame10.thirdAttempt.result != BLRAttemptResultNoAttempt && frame10.thirdAttempt.result != BLRAttemptResultStrike)
        {
            currentAchievement.achievementEarnedInCurrentGame = YES;
            currentAchievement.achievementWasEarned = YES;
            currentAchievement.frameNumberEarned = 10;
            
            currentAchievement.dateEarned = player.currentGame.date;
            NSNumber *gameID = [[NSNumber alloc]initWithInt:[player.currentGame.gameID intValue]];
            currentAchievement.gameID = gameID;
            return YES;
        }
    }
    
    return NO;
}

// Check to see if the Player recorded a Strike on the first 2 Attempts of the 10th Frame and missed a Strike on the 3rd Attempt
- (BOOL)checkForEpicFailAchievementForPlayer:(Player *)player
{
    Achievement *currentAchievement = [player.listOfAchievements objectAtIndex:10];
    Frame *frame10 = [player.currentGame.allFrames objectAtIndex:9];
    if(currentAchievement.achievementEarnedInCurrentGame)
    {
        if(frame10.firstAttempt.result != BLRAttemptResultStrike || frame10.secondAttempt.result != BLRAttemptResultStrike || frame10.thirdAttempt.result == BLRAttemptResultStrike)
        {
            currentAchievement.achievementEarnedInCurrentGame = NO;
            currentAchievement.achievementWasEarned = NO;
            currentAchievement.frameNumberEarned = 0;
            currentAchievement.dateEarned = nil;
            currentAchievement.gameID = nil;
            return NO;
        }
        
        return NO;
    }
    
    if(!currentAchievement.achievementWasEarned)
    {
        if(frame10.firstAttempt.result == BLRAttemptResultStrike && frame10.secondAttempt.result == BLRAttemptResultStrike && frame10.thirdAttempt.result != BLRAttemptResultNoAttempt && frame10.thirdAttempt.result != BLRAttemptResultStrike)
        {
            currentAchievement.achievementEarnedInCurrentGame = YES;
            currentAchievement.achievementWasEarned = YES;
            currentAchievement.frameNumberEarned = 10;
            
            currentAchievement.dateEarned = player.currentGame.date;
            NSNumber *gameID = [[NSNumber alloc]initWithInt:[player.currentGame.gameID intValue]];
            currentAchievement.gameID = gameID;
            return YES;
        }
    }
    
    return NO;
}

// Check to see if the Player recorded a Spare on a 4-6 Split
- (BOOL)checkForImpressiveAchievementForPlayer:(Player *)player
                                     withFrame:(Frame *)currentFrame
{
    Achievement *currentAchievement = [player.listOfAchievements objectAtIndex:11];
    
    if(currentAchievement.achievementEarnedInCurrentGame && currentFrame.frameNumber == currentAchievement.frameNumberEarned)
    {
        if(currentFrame.firstAttempt.pin1 == BLRPinStateDown && currentFrame.firstAttempt.pin2 == BLRPinStateDown && currentFrame.firstAttempt.pin3 == BLRPinStateDown && currentFrame.firstAttempt.pin4 == BLRPinStateUp && currentFrame.firstAttempt.pin5 == BLRPinStateDown && currentFrame.firstAttempt.pin6 == BLRPinStateUp && currentFrame.firstAttempt.pin7 == BLRPinStateDown && currentFrame.firstAttempt.pin8 == BLRPinStateDown && currentFrame.firstAttempt.pin9 == BLRPinStateDown && currentFrame.firstAttempt.pin10 == BLRPinStateDown && (currentFrame.result == BLRFrameResultSpare || currentFrame.secondAttempt.result == BLRAttemptResultSpare))
        {
            return NO;
        }
        else
        {
            currentAchievement.achievementEarnedInCurrentGame = NO;
            currentAchievement.achievementWasEarned = NO;
            currentAchievement.frameNumberEarned = 0;
            currentAchievement.dateEarned = nil;
            currentAchievement.gameID = nil;
            return NO;
        }
    }
    
    if(!currentAchievement.achievementWasEarned)
    {
        if(currentFrame.firstAttempt.pin1 == BLRPinStateDown && currentFrame.firstAttempt.pin2 == BLRPinStateDown && currentFrame.firstAttempt.pin3 == BLRPinStateDown && currentFrame.firstAttempt.pin4 == BLRPinStateUp && currentFrame.firstAttempt.pin5 == BLRPinStateDown && currentFrame.firstAttempt.pin6 == BLRPinStateUp && currentFrame.firstAttempt.pin7 == BLRPinStateDown && currentFrame.firstAttempt.pin8 == BLRPinStateDown && currentFrame.firstAttempt.pin9 == BLRPinStateDown && currentFrame.firstAttempt.pin10 == BLRPinStateDown && (currentFrame.result == BLRFrameResultSpare || currentFrame.secondAttempt.result == BLRAttemptResultSpare))
        {
            currentAchievement.achievementEarnedInCurrentGame = YES;
            currentAchievement.achievementWasEarned = YES;
            currentAchievement.frameNumberEarned = currentFrame.frameNumber;
            
            currentAchievement.dateEarned = player.currentGame.date;
            NSNumber *gameID = [[NSNumber alloc]initWithInt:[player.currentGame.gameID intValue]];
            currentAchievement.gameID = gameID;
            return YES;
        }
    }
    
    return NO;
}

// Check to see if the Player recorded a Spare on a 7-10 Split
- (BOOL)checkForHowTheAchievementForPlayer:(Player *)player
                                withFrame:(Frame *)currentFrame
{
    Achievement *currentAchievement = [player.listOfAchievements objectAtIndex:12];
    
    if(currentAchievement.achievementEarnedInCurrentGame && currentFrame.frameNumber == currentAchievement.frameNumberEarned)
    {
        if(currentFrame.firstAttempt.pin1 == BLRPinStateDown && currentFrame.firstAttempt.pin2 == BLRPinStateDown && currentFrame.firstAttempt.pin3 == BLRPinStateDown && currentFrame.firstAttempt.pin4 == BLRPinStateDown && currentFrame.firstAttempt.pin5 == BLRPinStateDown && currentFrame.firstAttempt.pin6 == BLRPinStateDown && currentFrame.firstAttempt.pin7 == BLRPinStateUp && currentFrame.firstAttempt.pin8 == BLRPinStateDown && currentFrame.firstAttempt.pin9 == BLRPinStateDown && currentFrame.firstAttempt.pin10 == BLRPinStateUp && (currentFrame.result == BLRFrameResultSpare || currentFrame.secondAttempt.result == BLRAttemptResultSpare))
        {
            return NO;
        }
        else
        {
            currentAchievement.achievementEarnedInCurrentGame = NO;
            currentAchievement.achievementWasEarned = NO;
            currentAchievement.frameNumberEarned = NO;
            currentAchievement.dateEarned = nil;
            currentAchievement.gameID = nil;
            return NO;
        }
    }
    
    if(!currentAchievement.achievementWasEarned)
    {
        if(currentFrame.firstAttempt.pin1 == BLRPinStateDown && currentFrame.firstAttempt.pin2 == BLRPinStateDown && currentFrame.firstAttempt.pin3 == BLRPinStateDown && currentFrame.firstAttempt.pin4 == BLRPinStateDown && currentFrame.firstAttempt.pin5 == BLRPinStateDown && currentFrame.firstAttempt.pin6 == BLRPinStateDown && currentFrame.firstAttempt.pin7 == BLRPinStateUp && currentFrame.firstAttempt.pin8 == BLRPinStateDown && currentFrame.firstAttempt.pin9 == BLRPinStateDown && currentFrame.firstAttempt.pin10 == BLRPinStateUp && (currentFrame.result == BLRFrameResultSpare || currentFrame.secondAttempt.result == BLRAttemptResultSpare))
        {
            currentAchievement.achievementEarnedInCurrentGame = YES;
            currentAchievement.achievementWasEarned = YES;
            currentAchievement.frameNumberEarned = currentFrame.frameNumber;
            
            currentAchievement.dateEarned = player.currentGame.date;
            NSNumber *gameID = [[NSNumber alloc]initWithInt:[player.currentGame.gameID intValue]];
            currentAchievement.gameID = gameID;
            return YES;
        }
    }
    
    return NO;
}

// Check to see if the Player recorded a Spare on a 1-2-3-5 Split for Got Bling? - Achievement
- (BOOL)checkFor1235SpareAchievementForPlayer:(Player *)player
                                    withFrame:(Frame *)currentFrame
{
    Achievement *currentAchievement = [player.listOfAchievements objectAtIndex:13];
    if(currentAchievement.achievementEarnedInCurrentGame && currentFrame.frameNumber == currentAchievement.frameNumberEarned)
    {
        if((currentFrame.firstAttempt.pin1 == BLRPinStateUp && currentFrame.firstAttempt.pin2 == BLRPinStateUp && currentFrame.firstAttempt.pin3 == BLRPinStateUp && currentFrame.firstAttempt.pin4 == BLRPinStateDown && currentFrame.firstAttempt.pin5 == BLRPinStateUp && currentFrame.firstAttempt.pin6 == BLRPinStateDown && currentFrame.firstAttempt.pin7 == BLRPinStateDown && currentFrame.firstAttempt.pin8 == BLRPinStateDown && currentFrame.firstAttempt.pin9 == BLRPinStateDown && currentFrame.firstAttempt.pin10 == BLRPinStateDown && (currentFrame.result == BLRFrameResultSpare || currentFrame.secondAttempt.result == BLRAttemptResultSpare)) || (currentFrame.firstAttempt.pin1 == BLRPinStateDown && currentFrame.firstAttempt.pin2 == BLRPinStateUp && currentFrame.firstAttempt.pin3 == BLRPinStateDown && currentFrame.firstAttempt.pin4 == BLRPinStateUp && currentFrame.firstAttempt.pin5 == BLRPinStateUp && currentFrame.firstAttempt.pin6 == BLRPinStateDown && currentFrame.firstAttempt.pin7 == BLRPinStateDown && currentFrame.firstAttempt.pin8 == BLRPinStateUp && currentFrame.firstAttempt.pin9 == BLRPinStateDown && currentFrame.firstAttempt.pin10 == BLRPinStateDown && (currentFrame.result == BLRFrameResultSpare || currentFrame.secondAttempt.result == BLRAttemptResultSpare)) || (currentFrame.firstAttempt.pin1 == BLRPinStateDown && currentFrame.firstAttempt.pin2 == BLRPinStateDown && currentFrame.firstAttempt.pin3 == BLRPinStateUp && currentFrame.firstAttempt.pin4 == BLRPinStateDown && currentFrame.firstAttempt.pin5 == BLRPinStateUp && currentFrame.firstAttempt.pin6 == BLRPinStateUp && currentFrame.firstAttempt.pin7 == BLRPinStateDown && currentFrame.firstAttempt.pin8 == BLRPinStateDown && currentFrame.firstAttempt.pin9 == BLRPinStateUp && currentFrame.firstAttempt.pin10 == BLRPinStateDown && (currentFrame.result == BLRFrameResultSpare || currentFrame.secondAttempt.result == BLRAttemptResultSpare)))
        {
            return NO;
        }
        else
        {
            currentAchievement.achievementEarnedInCurrentGame = NO;
            currentAchievement.achievementWasEarned = NO;
            currentAchievement.frameNumberEarned = 0;
            currentAchievement.dateEarned = nil;
            currentAchievement.gameID = nil;
            return NO;
        }
        return NO;
    }
    
    if(!currentAchievement.achievementWasEarned)
    {
        if(currentFrame.firstAttempt.pin1 == BLRPinStateUp && currentFrame.firstAttempt.pin2 == BLRPinStateUp && currentFrame.firstAttempt.pin3 == BLRPinStateUp && currentFrame.firstAttempt.pin4 == BLRPinStateDown && currentFrame.firstAttempt.pin5 == BLRPinStateUp && currentFrame.firstAttempt.pin6 == BLRPinStateDown && currentFrame.firstAttempt.pin7 == BLRPinStateDown && currentFrame.firstAttempt.pin8 == BLRPinStateDown && currentFrame.firstAttempt.pin9 == BLRPinStateDown && currentFrame.firstAttempt.pin10 == BLRPinStateDown && (currentFrame.result == BLRFrameResultSpare || currentFrame.secondAttempt.result == BLRAttemptResultSpare))
        {
            currentAchievement.achievementEarnedInCurrentGame = YES;
            currentAchievement.achievementWasEarned = YES;
            currentAchievement.frameNumberEarned = currentFrame.frameNumber;
            
            currentAchievement.dateEarned = player.currentGame.date;
            NSNumber *gameID = [[NSNumber alloc]initWithInt:[player.currentGame.gameID intValue]];
            currentAchievement.gameID = gameID;
            return YES;
        }
    }
    
    return NO;
}

// Check to see if the Player recorded a Spare on a 2-4-5-8 Split for Got Bling? - Achievement
- (BOOL)checkFor2458SpareAchievementForPlayer:(Player *)player
                                    withFrame:(Frame *)currentFrame
{
    Achievement *currentAchievement = [player.listOfAchievements objectAtIndex:13];
    
    if(currentAchievement.achievementEarnedInCurrentGame && currentFrame.frameNumber == currentAchievement.frameNumberEarned)
    {
        if((currentFrame.firstAttempt.pin1 == BLRPinStateUp && currentFrame.firstAttempt.pin2 == BLRPinStateUp && currentFrame.firstAttempt.pin3 == BLRPinStateUp && currentFrame.firstAttempt.pin4 == BLRPinStateDown && currentFrame.firstAttempt.pin5 == BLRPinStateUp && currentFrame.firstAttempt.pin6 == BLRPinStateDown && currentFrame.firstAttempt.pin7 == BLRPinStateDown && currentFrame.firstAttempt.pin8 == BLRPinStateDown && currentFrame.firstAttempt.pin9 == BLRPinStateDown && currentFrame.firstAttempt.pin10 == BLRPinStateDown && (currentFrame.result == BLRFrameResultSpare || currentFrame.secondAttempt.result == BLRAttemptResultSpare)) || (currentFrame.firstAttempt.pin1 == BLRPinStateDown && currentFrame.firstAttempt.pin2 == BLRPinStateUp && currentFrame.firstAttempt.pin3 == BLRPinStateDown && currentFrame.firstAttempt.pin4 == BLRPinStateUp && currentFrame.firstAttempt.pin5 == BLRPinStateUp && currentFrame.firstAttempt.pin6 == BLRPinStateDown && currentFrame.firstAttempt.pin7 == BLRPinStateDown && currentFrame.firstAttempt.pin8 == BLRPinStateUp && currentFrame.firstAttempt.pin9 == BLRPinStateDown && currentFrame.firstAttempt.pin10 == BLRPinStateDown && (currentFrame.result == BLRFrameResultSpare || currentFrame.secondAttempt.result == BLRAttemptResultSpare)) || (currentFrame.firstAttempt.pin1 == BLRPinStateDown && currentFrame.firstAttempt.pin2 == BLRPinStateDown && currentFrame.firstAttempt.pin3 == BLRPinStateUp && currentFrame.firstAttempt.pin4 == BLRPinStateDown && currentFrame.firstAttempt.pin5 == BLRPinStateUp && currentFrame.firstAttempt.pin6 == BLRPinStateUp && currentFrame.firstAttempt.pin7 == BLRPinStateDown && currentFrame.firstAttempt.pin8 == BLRPinStateDown && currentFrame.firstAttempt.pin9 == BLRPinStateUp && currentFrame.firstAttempt.pin10 == BLRPinStateDown && (currentFrame.result == BLRFrameResultSpare || currentFrame.secondAttempt.result == BLRAttemptResultSpare)))
        {
            return NO;
        }
        else
        {
            currentAchievement.achievementEarnedInCurrentGame = NO;
            currentAchievement.achievementWasEarned = NO;
            currentAchievement.frameNumberEarned = 0;
            currentAchievement.dateEarned = nil;
            currentAchievement.gameID = nil;
            return NO;
        }
        return NO;
        
    }
    if(!currentAchievement.achievementWasEarned)
    {
        if(currentFrame.firstAttempt.pin1 == BLRPinStateDown && currentFrame.firstAttempt.pin2 == BLRPinStateUp && currentFrame.firstAttempt.pin3 == BLRPinStateDown && currentFrame.firstAttempt.pin4 == BLRPinStateUp && currentFrame.firstAttempt.pin5 == BLRPinStateUp && currentFrame.firstAttempt.pin6 == BLRPinStateDown && currentFrame.firstAttempt.pin7 == BLRPinStateDown && currentFrame.firstAttempt.pin8 == BLRPinStateUp && currentFrame.firstAttempt.pin9 == BLRPinStateDown && currentFrame.firstAttempt.pin10 == BLRPinStateDown && (currentFrame.result == BLRFrameResultSpare || currentFrame.secondAttempt.result == BLRAttemptResultSpare))
        {
            currentAchievement.achievementEarnedInCurrentGame = YES;
            currentAchievement.achievementWasEarned = YES;
            currentAchievement.frameNumberEarned = currentFrame.frameNumber;
            
            currentAchievement.dateEarned = player.currentGame.date;
            NSNumber *gameID = [[NSNumber alloc]initWithInt:[player.currentGame.gameID intValue]];
            currentAchievement.gameID = gameID;
            return YES;
        }
    }
    
    return NO;
}

// Check to see if the Player recorded a Spare on a 3-5-6-9 Split for Got Bling? - Achievement
- (BOOL)checkFor3569SpareAchievementForPlayer:(Player *)player
                                   withFrame:(Frame *)currentFrame
{
    Achievement *currentAchievement = [player.listOfAchievements objectAtIndex:13];
    if(currentAchievement.achievementEarnedInCurrentGame && currentFrame.frameNumber == currentAchievement.frameNumberEarned)
    {
        if((currentFrame.firstAttempt.pin1 == BLRPinStateUp && currentFrame.firstAttempt.pin2 == BLRPinStateUp && currentFrame.firstAttempt.pin3 == BLRPinStateUp && currentFrame.firstAttempt.pin4 == BLRPinStateDown && currentFrame.firstAttempt.pin5 == BLRPinStateUp && currentFrame.firstAttempt.pin6 == BLRPinStateDown && currentFrame.firstAttempt.pin7 == BLRPinStateDown && currentFrame.firstAttempt.pin8 == BLRPinStateDown && currentFrame.firstAttempt.pin9 == BLRPinStateDown && currentFrame.firstAttempt.pin10 == BLRPinStateDown && (currentFrame.result == BLRFrameResultSpare || currentFrame.secondAttempt.result == BLRAttemptResultSpare)) || (currentFrame.firstAttempt.pin1 == BLRPinStateDown && currentFrame.firstAttempt.pin2 == BLRPinStateUp && currentFrame.firstAttempt.pin3 == BLRPinStateDown && currentFrame.firstAttempt.pin4 == BLRPinStateUp && currentFrame.firstAttempt.pin5 == BLRPinStateUp && currentFrame.firstAttempt.pin6 == BLRPinStateDown && currentFrame.firstAttempt.pin7 == BLRPinStateDown && currentFrame.firstAttempt.pin8 == BLRPinStateUp && currentFrame.firstAttempt.pin9 == BLRPinStateDown && currentFrame.firstAttempt.pin10 == BLRPinStateDown && (currentFrame.result == BLRFrameResultSpare || currentFrame.secondAttempt.result == BLRAttemptResultSpare)) || (currentFrame.firstAttempt.pin1 == BLRPinStateDown && currentFrame.firstAttempt.pin2 == BLRPinStateDown && currentFrame.firstAttempt.pin3 == BLRPinStateUp && currentFrame.firstAttempt.pin4 == BLRPinStateDown && currentFrame.firstAttempt.pin5 == BLRPinStateUp && currentFrame.firstAttempt.pin6 == BLRPinStateUp && currentFrame.firstAttempt.pin7 == BLRPinStateDown && currentFrame.firstAttempt.pin8 == BLRPinStateDown && currentFrame.firstAttempt.pin9 == BLRPinStateUp && currentFrame.firstAttempt.pin10 == BLRPinStateDown && (currentFrame.result == BLRFrameResultSpare || currentFrame.secondAttempt.result == BLRAttemptResultSpare)))
        {
            return NO;
        }
        else
        {
            currentAchievement.achievementEarnedInCurrentGame = NO;
            currentAchievement.achievementWasEarned = NO;
            currentAchievement.frameNumberEarned = 0;
            currentAchievement.dateEarned = nil;
            currentAchievement.gameID = nil;
            return NO;
        }
        return NO;
    }
    if(!currentAchievement.achievementWasEarned)
    {
        if(currentFrame.firstAttempt.pin1 == BLRPinStateDown && currentFrame.firstAttempt.pin2 == BLRPinStateDown && currentFrame.firstAttempt.pin3 == BLRPinStateUp && currentFrame.firstAttempt.pin4 == BLRPinStateDown && currentFrame.firstAttempt.pin5 == BLRPinStateUp && currentFrame.firstAttempt.pin6 == BLRPinStateUp && currentFrame.firstAttempt.pin7 == BLRPinStateDown && currentFrame.firstAttempt.pin8 == BLRPinStateDown && currentFrame.firstAttempt.pin9 == BLRPinStateUp && currentFrame.firstAttempt.pin10 == BLRPinStateDown && (currentFrame.result == BLRFrameResultSpare || currentFrame.secondAttempt.result == BLRAttemptResultSpare))
        {
            currentAchievement.achievementEarnedInCurrentGame = YES;
            currentAchievement.achievementWasEarned = YES;
            currentAchievement.frameNumberEarned = currentFrame.frameNumber;
            
            currentAchievement.dateEarned = player.currentGame.date;
            NSNumber *gameID = [[NSNumber alloc]initWithInt:[player.currentGame.gameID intValue]];
            currentAchievement.gameID = gameID;
            return YES;
        }
    }
    
    return NO;
}

// Check to see if the Player recorded a Spare on a 1-2-4-7 Split for Dominos - Achievement
- (BOOL)checkFor1247SpareAchievementForPlayer:(Player *)player
                                    withFrame:(Frame *)currentFrame
{
    Achievement *currentAchievement = [player.listOfAchievements objectAtIndex:14];
    
    if(currentAchievement.achievementEarnedInCurrentGame && currentFrame.frameNumber == currentAchievement.frameNumberEarned)
    {
        if((currentFrame.firstAttempt.pin1 == BLRPinStateUp && currentFrame.firstAttempt.pin2 == BLRPinStateUp  && currentFrame.firstAttempt.pin3 == BLRPinStateDown  && currentFrame.firstAttempt.pin4 == BLRPinStateUp && currentFrame.firstAttempt.pin5 == BLRPinStateDown && currentFrame.firstAttempt.pin6 == BLRPinStateDown && currentFrame.firstAttempt.pin7 == BLRPinStateUp && currentFrame.firstAttempt.pin8 == BLRPinStateDown && currentFrame.firstAttempt.pin9 == BLRPinStateDown && currentFrame.firstAttempt.pin10 == BLRPinStateDown && (currentFrame.result == BLRFrameResultSpare || currentFrame.secondAttempt.result == BLRAttemptResultSpare)) || (currentFrame.firstAttempt.pin1 == BLRPinStateUp && currentFrame.firstAttempt.pin2 == BLRPinStateDown && currentFrame.firstAttempt.pin3 == BLRPinStateUp && currentFrame.firstAttempt.pin4 == BLRPinStateDown && currentFrame.firstAttempt.pin5 == BLRPinStateDown && currentFrame.firstAttempt.pin6 == BLRPinStateUp && currentFrame.firstAttempt.pin7 == BLRPinStateDown && currentFrame.firstAttempt.pin8 == BLRPinStateDown && currentFrame.firstAttempt.pin9 == BLRPinStateDown && currentFrame.firstAttempt.pin10 == BLRPinStateUp && (currentFrame.result == BLRFrameResultSpare || currentFrame.secondAttempt.result == BLRAttemptResultSpare)))
        {
            return NO;
        }
        else
        {
            currentAchievement.achievementEarnedInCurrentGame = NO;
            currentAchievement.achievementWasEarned = NO;
            currentAchievement.frameNumberEarned = 0;
            currentAchievement.dateEarned = nil;
            currentAchievement.gameID = nil;
            return NO;
        }
        
        return NO;
    }
    
    if(!currentAchievement.achievementWasEarned)
    {
        if(currentFrame.firstAttempt.pin1 == BLRPinStateUp && currentFrame.firstAttempt.pin2 == BLRPinStateUp && currentFrame.firstAttempt.pin3 == BLRPinStateDown && currentFrame.firstAttempt.pin4 == BLRPinStateUp && currentFrame.firstAttempt.pin5 == BLRPinStateDown && currentFrame.firstAttempt.pin6 == BLRPinStateDown && currentFrame.firstAttempt.pin7 == BLRPinStateUp && currentFrame.firstAttempt.pin8 == BLRPinStateDown && currentFrame.firstAttempt.pin9 == BLRPinStateDown && currentFrame.firstAttempt.pin10 == BLRPinStateDown && (currentFrame.result == BLRFrameResultSpare || currentFrame.secondAttempt.result == BLRAttemptResultSpare))
        {
            currentAchievement.achievementEarnedInCurrentGame = YES;
            currentAchievement.achievementWasEarned = YES;
            currentAchievement.frameNumberEarned = currentFrame.frameNumber;
            
            currentAchievement.dateEarned = player.currentGame.date;
            NSNumber *gameID = [[NSNumber alloc]initWithInt:[player.currentGame.gameID intValue]];
            currentAchievement.gameID = gameID;
            return YES;
        }
    }
    
    return NO;
}

// Check to see if the Player recorded a Spare on a 1-3-6-10 Split for Dominos - Achievement
- (BOOL)checkFor13610SpareAchievementForPlayer:(Player *)player
                                     withFrame:(Frame *)currentFrame
{
    Achievement *currentAchievement = [player.listOfAchievements objectAtIndex:14];
    
    if(currentAchievement.achievementEarnedInCurrentGame && currentFrame.frameNumber == currentAchievement.frameNumberEarned)
    {
        if((currentFrame.firstAttempt.pin1 == BLRPinStateUp && currentFrame.firstAttempt.pin2 == BLRPinStateDown && currentFrame.firstAttempt.pin3 == BLRPinStateUp && currentFrame.firstAttempt.pin4 == BLRPinStateDown && currentFrame.firstAttempt.pin5 == BLRPinStateDown && currentFrame.firstAttempt.pin6 == BLRPinStateUp && currentFrame.firstAttempt.pin7 == BLRPinStateDown && currentFrame.firstAttempt.pin8 == BLRPinStateDown && currentFrame.firstAttempt.pin9 == BLRPinStateDown && currentFrame.firstAttempt.pin10 == BLRPinStateUp && (currentFrame.result == BLRFrameResultSpare || currentFrame.secondAttempt.result == BLRAttemptResultSpare)) || (currentFrame.firstAttempt.pin1 == BLRPinStateUp && currentFrame.firstAttempt.pin2 == BLRPinStateUp && currentFrame.firstAttempt.pin3 == BLRPinStateDown && currentFrame.firstAttempt.pin4 == BLRPinStateUp && currentFrame.firstAttempt.pin5 == BLRPinStateDown && currentFrame.firstAttempt.pin6 == BLRPinStateDown && currentFrame.firstAttempt.pin7 == BLRPinStateUp && currentFrame.firstAttempt.pin8 == BLRPinStateDown && currentFrame.firstAttempt.pin9 == BLRPinStateDown && currentFrame.firstAttempt.pin10 == BLRPinStateDown && (currentFrame.result == BLRFrameResultSpare || currentFrame.secondAttempt.result == BLRAttemptResultSpare)))
        {
            return NO;
        }
        else
        {
            currentAchievement.achievementEarnedInCurrentGame = NO;
            currentAchievement.achievementWasEarned = NO;
            currentAchievement.frameNumberEarned = 0;
            currentAchievement.dateEarned = nil;
            currentAchievement.gameID = nil;
            return NO;
        }
        
        return NO;
    }
    if(!currentAchievement.achievementWasEarned)
    {
        if(currentFrame.firstAttempt.pin1 == BLRPinStateUp && currentFrame.firstAttempt.pin2 == BLRPinStateDown && currentFrame.firstAttempt.pin3 == BLRPinStateUp && currentFrame.firstAttempt.pin4 == BLRPinStateDown && currentFrame.firstAttempt.pin5 == BLRPinStateDown && currentFrame.firstAttempt.pin6 == BLRPinStateUp && currentFrame.firstAttempt.pin7 == BLRPinStateDown && currentFrame.firstAttempt.pin8 == BLRPinStateDown && currentFrame.firstAttempt.pin9 == BLRPinStateDown && currentFrame.firstAttempt.pin10 == BLRPinStateUp && (currentFrame.result == BLRFrameResultSpare || currentFrame.secondAttempt.result == BLRAttemptResultSpare))
        {
            currentAchievement.achievementEarnedInCurrentGame = YES;
            currentAchievement.achievementWasEarned = YES;
            currentAchievement.frameNumberEarned = currentFrame.frameNumber;
            
            currentAchievement.dateEarned = player.currentGame.date;
            NSNumber *gameID = [[NSNumber alloc]initWithInt:[player.currentGame.gameID intValue]];
            currentAchievement.gameID = gameID;
            return YES;
        }
    }
    
    return NO;
}

// Check to see if the Player recorded a Spare on a 1-5 Split for The Sleeper - Achievement
- (BOOL)checkFor15SpareAchievementForPlayer:(Player *)player
                                  withFrame:(Frame *)currentFrame
{
    Achievement *currentAchievement = [player.listOfAchievements objectAtIndex:15];
    
    if(currentAchievement.achievementEarnedInCurrentGame && currentFrame.frameNumber == currentAchievement.frameNumberEarned)
    {
        if((currentFrame.firstAttempt.pin1 == BLRPinStateUp && currentFrame.firstAttempt.pin2 == BLRPinStateDown && currentFrame.firstAttempt.pin3 == BLRPinStateDown && currentFrame.firstAttempt.pin4 == BLRPinStateDown && currentFrame.firstAttempt.pin5 == BLRPinStateUp && currentFrame.firstAttempt.pin6 == BLRPinStateDown && currentFrame.firstAttempt.pin7 == BLRPinStateDown && currentFrame.firstAttempt.pin8 == BLRPinStateDown && currentFrame.firstAttempt.pin9 == BLRPinStateDown && currentFrame.firstAttempt.pin10 == BLRPinStateDown && (currentFrame.result == BLRFrameResultSpare || currentFrame.secondAttempt.result == BLRAttemptResultSpare)) || (currentFrame.firstAttempt.pin1 == BLRPinStateDown && currentFrame.firstAttempt.pin2 == BLRPinStateUp && currentFrame.firstAttempt.pin3 == BLRPinStateDown && currentFrame.firstAttempt.pin4 == BLRPinStateDown && currentFrame.firstAttempt.pin5 == BLRPinStateDown && currentFrame.firstAttempt.pin6 == BLRPinStateDown && currentFrame.firstAttempt.pin7 == BLRPinStateDown && currentFrame.firstAttempt.pin8 == BLRPinStateUp && currentFrame.firstAttempt.pin9 == BLRPinStateDown && currentFrame.firstAttempt.pin10 == BLRPinStateDown && (currentFrame.result == BLRFrameResultSpare || currentFrame.secondAttempt.result == BLRAttemptResultSpare)) || (currentFrame.firstAttempt.pin1 == BLRPinStateDown && currentFrame.firstAttempt.pin2 == BLRPinStateDown && currentFrame.firstAttempt.pin3 == BLRPinStateUp && currentFrame.firstAttempt.pin4 == BLRPinStateDown && currentFrame.firstAttempt.pin5 == BLRPinStateDown && currentFrame.firstAttempt.pin6 == BLRPinStateDown && currentFrame.firstAttempt.pin7 == BLRPinStateDown && currentFrame.firstAttempt.pin8 == BLRPinStateDown && currentFrame.firstAttempt.pin9 == BLRPinStateUp && currentFrame.firstAttempt.pin10 == BLRPinStateDown && (currentFrame.result == BLRFrameResultSpare || currentFrame.secondAttempt.result == BLRAttemptResultSpare)))
        {
            return NO;
        }
        else
        {
            currentAchievement.achievementEarnedInCurrentGame = NO;
            currentAchievement.achievementWasEarned = NO;
            currentAchievement.frameNumberEarned = 0;
            currentAchievement.dateEarned = nil;
            currentAchievement.gameID = nil;
            return NO;
        }
        
        return NO;
    }
    
    if(!currentAchievement.achievementWasEarned)
    {
        if(currentFrame.firstAttempt.pin1 == BLRPinStateUp && currentFrame.firstAttempt.pin2 == BLRPinStateDown && currentFrame.firstAttempt.pin3 == BLRPinStateDown && currentFrame.firstAttempt.pin4 == BLRPinStateDown && currentFrame.firstAttempt.pin5 == BLRPinStateUp && currentFrame.firstAttempt.pin6 == BLRPinStateDown && currentFrame.firstAttempt.pin7 == BLRPinStateDown && currentFrame.firstAttempt.pin8 == BLRPinStateDown && currentFrame.firstAttempt.pin9 == BLRPinStateDown && currentFrame.firstAttempt.pin10 == BLRPinStateDown && (currentFrame.result == BLRFrameResultSpare || currentFrame.secondAttempt.result == BLRAttemptResultSpare))
        {
            currentAchievement.achievementEarnedInCurrentGame = YES;
            currentAchievement.achievementWasEarned = YES;
            currentAchievement.frameNumberEarned = currentFrame.frameNumber;
            
            currentAchievement.dateEarned = player.currentGame.date;
            NSNumber *gameID = [[NSNumber alloc]initWithInt:[player.currentGame.gameID intValue]];
            currentAchievement.gameID = gameID;
            return YES;
        }
    }
    
    return NO;
}

// Check to see if the Player recorded a Spare on a 2-8 Split for The Sleeper - Achievement
- (BOOL)checkFor28SpareAchievementForPlayer:(Player *)player
                                  withFrame:(Frame *)currentFrame
{
    Achievement *currentAchievement = [player.listOfAchievements objectAtIndex:15];
    
    if(currentAchievement.achievementEarnedInCurrentGame && currentFrame.frameNumber == currentAchievement.frameNumberEarned)
    {
        if((currentFrame.firstAttempt.pin1 == BLRPinStateUp && currentFrame.firstAttempt.pin2 == BLRPinStateDown && currentFrame.firstAttempt.pin3 == BLRPinStateDown && currentFrame.firstAttempt.pin4 == BLRPinStateDown && currentFrame.firstAttempt.pin5 == BLRPinStateUp && currentFrame.firstAttempt.pin6 == BLRPinStateDown && currentFrame.firstAttempt.pin7 == BLRPinStateDown && currentFrame.firstAttempt.pin8 == BLRPinStateDown && currentFrame.firstAttempt.pin9 == BLRPinStateDown && currentFrame.firstAttempt.pin10 == BLRPinStateDown && (currentFrame.result == BLRFrameResultSpare || currentFrame.secondAttempt.result == BLRAttemptResultSpare)) || (currentFrame.firstAttempt.pin1 == BLRPinStateDown && currentFrame.firstAttempt.pin2 == BLRPinStateUp && currentFrame.firstAttempt.pin3 == BLRPinStateDown && currentFrame.firstAttempt.pin4 == BLRPinStateDown && currentFrame.firstAttempt.pin5 == BLRPinStateDown && currentFrame.firstAttempt.pin6 == BLRPinStateDown && currentFrame.firstAttempt.pin7 == BLRPinStateDown && currentFrame.firstAttempt.pin8 == BLRPinStateUp && currentFrame.firstAttempt.pin9 == BLRPinStateDown && currentFrame.firstAttempt.pin10 == BLRPinStateDown && (currentFrame.result == BLRFrameResultSpare || currentFrame.secondAttempt.result == BLRAttemptResultSpare)) || (currentFrame.firstAttempt.pin1 == BLRPinStateDown && currentFrame.firstAttempt.pin2 == BLRPinStateDown && currentFrame.firstAttempt.pin3 == BLRPinStateUp && currentFrame.firstAttempt.pin4 == BLRPinStateDown && currentFrame.firstAttempt.pin5 == BLRPinStateDown && currentFrame.firstAttempt.pin6 == BLRPinStateDown && currentFrame.firstAttempt.pin7 == BLRPinStateDown && currentFrame.firstAttempt.pin8 == BLRPinStateDown && currentFrame.firstAttempt.pin9 == BLRPinStateUp && currentFrame.firstAttempt.pin10 == BLRPinStateDown && (currentFrame.result == BLRFrameResultSpare || currentFrame.secondAttempt.result == BLRAttemptResultSpare)))
        {
            return NO;
        }
        else
        {
            currentAchievement.achievementEarnedInCurrentGame = NO;
            currentAchievement.achievementWasEarned = NO;
            currentAchievement.frameNumberEarned = 0;
            currentAchievement.dateEarned = nil;
            currentAchievement.gameID = nil;
            return NO;
        }
        
        return NO;
    }
    
    if(!currentAchievement.achievementWasEarned)
    {
        if(currentFrame.firstAttempt.pin1 == BLRPinStateDown && currentFrame.firstAttempt.pin2 == BLRPinStateUp && currentFrame.firstAttempt.pin3 == BLRPinStateDown && currentFrame.firstAttempt.pin4 == BLRPinStateDown && currentFrame.firstAttempt.pin5 == BLRPinStateDown && currentFrame.firstAttempt.pin6 == BLRPinStateDown && currentFrame.firstAttempt.pin7 == BLRPinStateDown && currentFrame.firstAttempt.pin8 == BLRPinStateUp && currentFrame.firstAttempt.pin9 == BLRPinStateDown && currentFrame.firstAttempt.pin10 == BLRPinStateDown && (currentFrame.result == BLRFrameResultSpare || currentFrame.secondAttempt.result == BLRAttemptResultSpare))
        {
            currentAchievement.achievementEarnedInCurrentGame = YES;
            currentAchievement.achievementWasEarned = YES;
            currentAchievement.frameNumberEarned = currentFrame.frameNumber;
            
            currentAchievement.dateEarned = player.currentGame.date;
            NSNumber *gameID = [[NSNumber alloc]initWithInt:[player.currentGame.gameID intValue]];
            currentAchievement.gameID = gameID;
            return YES;
        }
    }
    
    return NO;
}

// Check to see if the Player recorded a Spare on a 3-9 Split for The Sleeper - Achievement
- (BOOL)checkFor39SpareAchievementForPlayer:(Player *)player
                                  withFrame:(Frame *)currentFrame
{
    Achievement *currentAchievement = [player.listOfAchievements objectAtIndex:15];
    
    if(currentAchievement.achievementEarnedInCurrentGame && currentFrame.frameNumber == currentAchievement.frameNumberEarned)
    {
        if((currentFrame.firstAttempt.pin1 == BLRPinStateUp && currentFrame.firstAttempt.pin2 == BLRPinStateDown && currentFrame.firstAttempt.pin3 == BLRPinStateDown && currentFrame.firstAttempt.pin4 == BLRPinStateDown && currentFrame.firstAttempt.pin5 == BLRPinStateUp && currentFrame.firstAttempt.pin6 == BLRPinStateDown && currentFrame.firstAttempt.pin7 == BLRPinStateDown && currentFrame.firstAttempt.pin8 == BLRPinStateDown && currentFrame.firstAttempt.pin9 == BLRPinStateDown && currentFrame.firstAttempt.pin10 == BLRPinStateDown && (currentFrame.result == BLRFrameResultSpare || currentFrame.secondAttempt.result == BLRAttemptResultSpare)) || (currentFrame.firstAttempt.pin1 == BLRPinStateDown && currentFrame.firstAttempt.pin2 == BLRPinStateUp && currentFrame.firstAttempt.pin3 == BLRPinStateDown && currentFrame.firstAttempt.pin4 == BLRPinStateDown && currentFrame.firstAttempt.pin5 == BLRPinStateDown && currentFrame.firstAttempt.pin6 == BLRPinStateDown && currentFrame.firstAttempt.pin7 == BLRPinStateDown && currentFrame.firstAttempt.pin8 == BLRPinStateUp && currentFrame.firstAttempt.pin9 == BLRPinStateDown && currentFrame.firstAttempt.pin10 == BLRPinStateDown && (currentFrame.result == BLRFrameResultSpare || currentFrame.secondAttempt.result == BLRAttemptResultSpare)) || (currentFrame.firstAttempt.pin1 == BLRPinStateDown && currentFrame.firstAttempt.pin2 == BLRPinStateDown && currentFrame.firstAttempt.pin3 == BLRPinStateUp && currentFrame.firstAttempt.pin4 == BLRPinStateDown && currentFrame.firstAttempt.pin5 == BLRPinStateDown && currentFrame.firstAttempt.pin6 == BLRPinStateDown && currentFrame.firstAttempt.pin7 == BLRPinStateDown && currentFrame.firstAttempt.pin8 == BLRPinStateDown && currentFrame.firstAttempt.pin9 == BLRPinStateUp && currentFrame.firstAttempt.pin10 == BLRPinStateDown && (currentFrame.result == BLRFrameResultSpare || currentFrame.secondAttempt.result == BLRAttemptResultSpare)))
        {
            return NO;
        }
        else
        {
            currentAchievement.achievementEarnedInCurrentGame = NO;
            currentAchievement.achievementWasEarned = NO;
            currentAchievement.frameNumberEarned = 0;
            currentAchievement.dateEarned = nil;
            currentAchievement.gameID = nil;
            return NO;
        }
        return NO;
    }
    
    if(!currentAchievement.achievementWasEarned)
    {
        if(currentFrame.firstAttempt.pin1 == BLRPinStateDown && currentFrame.firstAttempt.pin2 == BLRPinStateDown && currentFrame.firstAttempt.pin3 == BLRPinStateUp && currentFrame.firstAttempt.pin4 == BLRPinStateDown && currentFrame.firstAttempt.pin5 == BLRPinStateDown && currentFrame.firstAttempt.pin6 == BLRPinStateDown && currentFrame.firstAttempt.pin7 == BLRPinStateDown && currentFrame.firstAttempt.pin8 == BLRPinStateDown && currentFrame.firstAttempt.pin9 == BLRPinStateUp && currentFrame.firstAttempt.pin10 == BLRPinStateDown && (currentFrame.result == BLRFrameResultSpare || currentFrame.secondAttempt.result == BLRAttemptResultSpare))
        {
            currentAchievement.achievementEarnedInCurrentGame = YES;
            currentAchievement.achievementWasEarned = YES;
            currentAchievement.frameNumberEarned = currentFrame.frameNumber;
            
            currentAchievement.dateEarned = player.currentGame.date;
            NSNumber *gameID = [[NSNumber alloc]initWithInt:[player.currentGame.gameID intValue]];
            currentAchievement.gameID = gameID;
            return YES;
        }
    }
    
    return NO;
}

// Check to see if Player recorded a Strike on each Attempt of the 10th Frame
- (BOOL)checkForStrikeoutAchievementForPlayer:(Player *)player
{
    Achievement *currentAchievement = [player.listOfAchievements objectAtIndex:16];
    Frame *frame10 = [player.currentGame.allFrames objectAtIndex:9];
    
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
            
            currentAchievement.dateEarned = player.currentGame.date;
            NSNumber *gameID = [[NSNumber alloc]initWithInt:[player.currentGame.gameID intValue]];
            currentAchievement.gameID = gameID;
            return YES;
        }
    }
    
    return NO;
}

// Check to see if Player has completed all Achievements
- (BOOL)checkForEliteAchievementForPlayer:(Player *)player
{
    Achievement *currentAchievement = [player.listOfAchievements objectAtIndex:17];
    
    if(currentAchievement.achievementEarnedInCurrentGame)
    {
        for(int i = 0; i < [player.listOfAchievements count] - 1; i++)
        {
            Achievement *achievement = [player.listOfAchievements objectAtIndex:i];
            if(!achievement.achievementWasEarned)
            {
                currentAchievement.achievementEarnedInCurrentGame = NO;
                currentAchievement.achievementWasEarned = NO;
                currentAchievement.dateEarned = nil;
                currentAchievement.gameID = nil;
            }
        }
    }
    
    if(!currentAchievement.achievementWasEarned)
    {
        for(int i = 0; i < [player.listOfAchievements count] - 1; i++)
        {
            Achievement *currentAchievement = [player.listOfAchievements objectAtIndex:i];
            if(!currentAchievement.achievementWasEarned)
            {
                return NO;
            }
        }
    }
    currentAchievement.achievementEarnedInCurrentGame = YES;
    currentAchievement.achievementWasEarned = YES;
    
    currentAchievement.dateEarned = player.currentGame.date;
    NSNumber *gameID = [[NSNumber alloc]initWithInt:[player.currentGame.gameID intValue]];
    currentAchievement.gameID = gameID;
    
    return YES;
}

// Check to see if Player came back from a defecit of at least 50 points to win the game
- (BOOL)checkForBackFromTheDeadAchievement:(Player *)winner allBowlrs:(NSArray *)allBowlrs
{
    if(!winner)
    {
        return NO;
    }
    
    Achievement *currentAchievement = [winner.listOfAchievements objectAtIndex:8];
    
    if(!currentAchievement.achievementWasEarned)
    {
        for(int i = 0; i < [allBowlrs count]; i++)
        {
            Player *currentPlayer = [allBowlrs objectAtIndex:i];
            int totalDifference = 0;
            int differenceForFrame = 0;
            
            for(int j = 0; j < 10; j ++)
            {
                Frame *currentPlayerFrame = [currentPlayer.currentGame.allFrames objectAtIndex:j];
                Frame *winnerFrame = [winner.currentGame.allFrames objectAtIndex:j];
                differenceForFrame = currentPlayerFrame.scoreForFrame - winnerFrame.scoreForFrame;
                totalDifference = totalDifference + differenceForFrame;
                
                if(totalDifference > 49)
                {
                    currentAchievement.achievementEarnedInCurrentGame = YES;
                    currentAchievement.achievementWasEarned = YES;
                    currentAchievement.frameNumberEarned = 10;
                    
                    //Initialize the date of the Achievement
                    NSDate *dateOfGame = [NSDate date];
                    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
                    dateFormatter.dateFormat = @"MM/dd/yy";
                    currentAchievement.dateEarned = [dateFormatter stringFromDate:dateOfGame];
                
                    return YES;
                }
            }
        }
    }
   
    return NO;
}

// Check to see if Player beat all other Players by at least 100 points
- (BOOL)checkForHumiliationAchievement:(Player *)winner allBowlrs:(NSArray *)allBowlrs
{
    Achievement *currentAchievement = [winner.listOfAchievements objectAtIndex:7];
    if(!currentAchievement.achievementWasEarned)
    {
        int winningScore = winner.currentGame.totalScore;
        for(int i = 0; i < [allBowlrs count]; i++)
        {
            Player *currentPlayer = [allBowlrs objectAtIndex:i];
            if(![winner.name isEqualToString:currentPlayer.name])
            {
                int score = currentPlayer.currentGame.totalScore;
                int difference = winningScore - score;
                
                if(difference < 100)
                {
                    return NO;
                }
            }
        }
        
        currentAchievement.achievementWasEarned = YES;
        currentAchievement.achievementEarnedInCurrentGame = YES;
        currentAchievement.frameNumberEarned = 10;
        
        NSNumber *gameID = [[NSNumber alloc]initWithInt:[winner.currentGame.gameID intValue]];
        currentAchievement.gameID = gameID;
        
        //Initialize the date of the Achievement
        NSDate *dateOfGame = [NSDate date];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
        dateFormatter.dateFormat = @"MM/dd/yy";
        currentAchievement.dateEarned = [dateFormatter stringFromDate:dateOfGame];
        return YES;
    }

    return NO;
}

// Check to see if Player beat all other Players by at least 50 points
- (BOOL)checkForIntimidationAchievement:(Player *)winner allBowlrs:(NSArray *)allBowlrs
{
    Achievement *currentAchievement = [winner.listOfAchievements objectAtIndex:6];
    if(!currentAchievement.achievementWasEarned)
    {
        int winningScore = winner.currentGame.totalScore;
        for(int i = 0; i < [allBowlrs count]; i++)
        {
            Player *currentPlayer = [allBowlrs objectAtIndex:i];
            if(![winner.name isEqualToString:currentPlayer.name])
            {
                int score = currentPlayer.currentGame.totalScore;
                int difference = winningScore - score;
                
                if(difference < 50)
                {
                    return NO;
                }
            }
        }
        
        currentAchievement.achievementWasEarned = YES;
        currentAchievement.achievementEarnedInCurrentGame = YES;
        currentAchievement.frameNumberEarned = 10;
        
        NSNumber *gameID = [[NSNumber alloc]initWithInt:[winner.currentGame.gameID intValue]];
        currentAchievement.gameID = gameID;
        
        //Initialize the date of the Achievement
        NSDate *dateOfGame = [NSDate date];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
        dateFormatter.dateFormat = @"MM/dd/yy";
        currentAchievement.dateEarned = [dateFormatter stringFromDate:dateOfGame];
        
        return YES;
    }
  
    return NO;
}

// Reset Back From The Dead, Intimidation, & Humiliation Achievements
- (void)resetEndOfGameAchievements:(NSArray *)allBowlrs
{
    for(int i = 0; i < [allBowlrs count]; i++)
    {
        Player *currentPlayer = [allBowlrs objectAtIndex:i];
        Achievement *backFromTheDead = [currentPlayer.listOfAchievements objectAtIndex:8];
        if(backFromTheDead.achievementEarnedInCurrentGame)
        {
            backFromTheDead.achievementEarnedInCurrentGame = NO;
            backFromTheDead.achievementWasEarned = NO;
            backFromTheDead.dateEarned = nil;
            backFromTheDead.gameID = nil;
            backFromTheDead.frameNumberEarned = 0;
        }
        
        Achievement *humiliation = [currentPlayer.listOfAchievements objectAtIndex:7];
        if(humiliation.achievementEarnedInCurrentGame)
        {
            humiliation.achievementEarnedInCurrentGame = NO;
            humiliation.achievementWasEarned = NO;
            humiliation.dateEarned = nil;
            humiliation.gameID = nil;
            humiliation.frameNumberEarned = 0;
        }
        
        Achievement *intimidation = [currentPlayer.listOfAchievements objectAtIndex:6];
        if(intimidation.achievementEarnedInCurrentGame)
        {
            intimidation.achievementEarnedInCurrentGame = NO;
            intimidation.achievementWasEarned = NO;
            intimidation.dateEarned = nil;
            intimidation.gameID = nil;
            intimidation.frameNumberEarned = 0;
        }
    }
}

@end
