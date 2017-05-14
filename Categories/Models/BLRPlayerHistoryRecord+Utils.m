//
//  BLRPlayerHistoryRecord+Utils.m
//  Bowlr
//
//  Created by Daniel Stewart on 4/22/17.
//  Copyright © 2017 Daniel Stewart. All rights reserved.
//

#import "BLRPlayerHistoryRecord+Utils.h"

@implementation BLRPlayerHistoryRecord (Utils)

- (void)updateStatistics:(Game *)newGame
{
    [self setTotalPinfall: newGame];
    [self setTotalFirstBallPinfall: newGame];
    [self setScore: newGame];
    [self setTotalOpenFrames: newGame];
    [self setTotalStrikes: newGame];
    [self setTotalFouls: newGame];
    [self setTotalSpares: newGame];
    [self setTotalSplits: newGame];
    [self setTotalSplitsConverted: newGame];
    [self setTotalGutterBalls: newGame];
    [self setTotalFirstBallSpeed: newGame];
    [self setTotalFirstSpeedAttempts: newGame];
    [self setTotalSecondBallSpeed: newGame];
    [self setTotalSecondSpeedAttempts: newGame];
}

- (void)setTotalPinfall:(Game *)currentGame
{
    float pinfall = 0;
    for(Frame *frame in currentGame.allFrames)
    {
        pinfall = pinfall + [frame computeRemainingPinsAfterFrame];
    }
    
    self.pinfall = [[NSNumber alloc] initWithFloat: [self.pinfall floatValue] + pinfall];
}

- (float)returnAveragePinfall
{
    if([self.listOfGames isEmpty])
    {
        return 0;
    }
    
    return [self.pinfall floatValue] / [self.listOfGames count];
}

- (void)setScore:(Game *)currentGame
{
    self.totalScore = [[NSNumber alloc] initWithFloat: [self.totalScore floatValue] + currentGame.totalScore];
}

- (float)returnAverageScore
{
    if([self.listOfGames isEmpty])
    {
        return 0;
    }
    else
    {
        return [self.totalScore floatValue] / [self.listOfGames count];
    }
}

- (void)setTotalOpenFrames:(Game *)currentGame
{
    int totalOpenFrames = 0;
    for(int i = 0; i < [currentGame.allFrames count] - 1; i++)
    {
        Frame *currentFrame = [currentGame.allFrames objectAtIndex: i];
        if(currentFrame.result != BLRFrameResultStrike && currentFrame.result == BLRFrameResultSpare)
        {
            totalOpenFrames++;
        }
    }
    
    Frame *tenthFrame = [currentGame.allFrames objectAtIndex: 9];
    if(tenthFrame.firstAttempt.result != BLRAttemptResultStrike && tenthFrame.secondAttempt.result != BLRAttemptResultSpare)
    {
        totalOpenFrames++;
    }
    
    self.openFrames = [[NSNumber alloc] initWithFloat: [self.openFrames floatValue] + totalOpenFrames];
}

- (float)returnAverageOpenFrames
{
    if([self.listOfGames isEmpty])
    {
        return 0;
    }
    
    return [self.openFrames floatValue] / [self.listOfGames count];
}

- (void)setTotalStrikes:(Game *)currentGame
{
    int totalStrikes = 0;
    for(int i = 0; i < [currentGame.allFrames count] - 1; i++)
    {
        Frame *currentFrame = [currentGame.allFrames objectAtIndex: i];
        if(currentFrame.result == BLRFrameResultStrike)
        {
            totalStrikes++;
        }
    }
    
    Frame *tenthFrame = [currentGame.allFrames lastObject];
    
    if(tenthFrame.firstAttempt.result == BLRAttemptResultStrike)
    {
        totalStrikes++;
    }
    if(tenthFrame.secondAttempt.result == BLRAttemptResultStrike)
    {
        totalStrikes++;
    }
    if(tenthFrame.thirdAttempt.result == BLRAttemptResultStrike)
    {
        totalStrikes++;
    }
    
    self.strikes = [[NSNumber alloc] initWithFloat: [self.strikes floatValue] + totalStrikes];
}

- (float)returnAverageStrikes
{
    if([self.listOfGames isEmpty])
    {
        return 0;
    }
    
    return [self.strikes floatValue] / [self.listOfGames count];
}

- (void)setTotalSpares:(Game *)currentGame
{
    int totalSpares = 0;
    for(int i = 0; i < [currentGame.allFrames count] - 1; i++)
    {
        Frame *currentFrame = [currentGame.allFrames objectAtIndex:i];
        
        if(currentFrame.result == BLRFrameResultSpare)
        {
            totalSpares++;
        }
    }
    Frame *tenthFrame = [currentGame.allFrames objectAtIndex:9];
    
    if(tenthFrame.secondAttempt.result == BLRAttemptResultSpare || tenthFrame.thirdAttempt.result == BLRAttemptResultSpare)
    {
        totalSpares++;
    }
    
    self.spares = [[NSNumber alloc] initWithFloat: [self.spares floatValue] + totalSpares];
}

- (float)returnAverageSpares
{
    if([self.listOfGames isEmpty])
    {
        return 0;
    }
    
    return [self.spares floatValue] / [self.listOfGames count];
}

- (void)setTotalSplits:(Game *)currentGame
{
    int totalSplits = 0;
    for(int i = 0; i < [currentGame.allFrames count] - 1; i++)
    {
        Frame *currentFrame = [currentGame.allFrames objectAtIndex:i];
        if(currentFrame.firstAttempt.result == BLRAttemptResultSplit)
        {
            totalSplits++;
        }
    }
    
    Frame *tenthFrame = [currentGame.allFrames lastObject];
    if(tenthFrame.firstAttempt.result == BLRAttemptResultSplit)
    {
        totalSplits++;
    }
    if(tenthFrame.secondAttempt.result == BLRAttemptResultSplit)
    {
        totalSplits++;
    }
    if(tenthFrame.thirdAttempt.result == BLRAttemptResultSplit)
    {
        totalSplits++;
    }
    
    self.splits = [[NSNumber alloc] initWithFloat: [self.splits floatValue] + totalSplits];
}

- (float)returnAverageSplits
{
    if([self.listOfGames isEmpty])
    {
        return 0;
    }
    
    return [self.splits floatValue] / [self.listOfGames count];
}

- (void)setTotalSplitsConverted:(Game *)currentGame
{
    int splitsConverted = 0;
    for(Frame *frame in currentGame.allFrames)
    {
        if(frame.firstAttempt.result == BLRAttemptResultSplit && frame.result == BLRFrameResultSpare)
        {
            splitsConverted++;
        }
    }
    
    self.splitConversions = [[NSNumber alloc] initWithFloat: [self.splitConversions floatValue] + splitsConverted];
}

- (float)returnAverageSplitsConverted
{
    if([self.listOfGames isEmpty])
    {
        return 0;
    }
    
    return [self.splitConversions floatValue] / [self.listOfGames count];
}

- (void)setTotalGutterBalls:(Game *)currentGame
{
    int gutterBalls = 0;
    for(Frame *frame in currentGame.allFrames)
    {
        if(frame.firstAttempt.result == BLRAttemptResultGutter)
        {
            gutterBalls++;
        }
        if(frame.secondAttempt.result == BLRAttemptResultGutter)
        {
            gutterBalls++;
        }
        if(frame.thirdAttempt.result == BLRAttemptResultGutter)
        {
            gutterBalls++;
        }
    }
    
    self.gutterBalls = [[NSNumber alloc] initWithFloat: [self.gutterBalls floatValue] + gutterBalls];
}

- (float)returnAverageGutterBalls
{
    if([self.listOfGames isEmpty])
    {
        return 0;
    }
    
    return [self.gutterBalls floatValue] / [self.listOfGames count];
}

- (void)setTotalFouls:(Game *)currentGame
{
    int totalFouls = 0;
    for(Frame *frame in currentGame.allFrames)
    {
        if(frame.firstAttempt.result == BLRAttemptResultFoul)
        {
            totalFouls++;
        }
        if(frame.secondAttempt.result == BLRAttemptResultFoul)
        {
            totalFouls++;
        }
        if(frame.thirdAttempt.result == BLRAttemptResultFoul)
        {
            totalFouls++;
        }
    }
    
    self.fouls = [[NSNumber alloc] initWithFloat: [self.fouls floatValue] + totalFouls];
}

- (float)returnAverageFouls
{
    if([self.listOfGames isEmpty])
    {
        return 0;
    }
    
    return [self.fouls floatValue] / [self.listOfGames count];
}

- (void)setTotalFirstBallPinfall:(Game *)currentGame
{
    float firstAttemptPinfall = 0;
    
    for(Frame *frame in currentGame.allFrames)
    {
        firstAttemptPinfall = firstAttemptPinfall + 10 - frame.firstAttempt.remainingPinsAfterAttempt;
    }
    
    self.firstBallPinfall = [[NSNumber alloc] initWithFloat: [self.firstBallPinfall floatValue] + firstAttemptPinfall];
}

- (float)returnAverageFirstBallPinfall
{
    if([self.listOfGames isEmpty])
    {
        return 0;
    }
    
    return [self.firstBallPinfall floatValue] / (10 * [self.listOfGames count]);
}

- (void)setTotalFirstSpeedAttempts:(Game *)currentGame
{
    int attempts = 0;
    
    for(Frame *frame in currentGame.allFrames)
    {
        if(frame.firstAttempt.ballSpeedForAttempt != 0)
        {
            attempts++;
        }
    }
    
    self.firstSpeedAttempts = [[NSNumber alloc] initWithFloat: [self.firstSpeedAttempts floatValue] + attempts];
}

- (void)setTotalFirstBallSpeed:(Game *)currentGame
{
    float totalFirstSpeed = 0.0;
    
    for(Frame *frame in currentGame.allFrames)
    {
        totalFirstSpeed = totalFirstSpeed + frame.firstAttempt.ballSpeedForAttempt;
    }
    
    self.firstBallSpeed = [[NSNumber alloc] initWithFloat: [self.firstBallSpeed floatValue] + totalFirstSpeed];
}

- (float)returnAverageFirstBallSpeed
{
    if([self.listOfGames isEmpty])
    {
        return 0;
    }
    
    return [self.firstBallSpeed floatValue] / [self.firstSpeedAttempts floatValue];
}

- (void)setTotalSecondSpeedAttempts:(Game *)currentGame
{
    int attempts = 0;
    
    for(Frame *frame in currentGame.allFrames)
    {
        if(frame.secondAttempt.ballSpeedForAttempt != 0)
        {
            attempts++;
        }
    }
    
    self.secondSpeedAttempts = [[NSNumber alloc] initWithFloat: [self.secondSpeedAttempts floatValue] + attempts];
}

- (void)setTotalSecondBallSpeed:(Game *)currentGame
{
    float totalSecondSpeed = 0.0;
    
    for(Frame *frame in currentGame.allFrames)
    {
        totalSecondSpeed = totalSecondSpeed + frame.secondAttempt.ballSpeedForAttempt;
    }
    
    self.secondBallSpeed = [[NSNumber alloc] initWithFloat: [self.secondBallSpeed floatValue] + totalSecondSpeed];
}

- (float)returnAverageSecondBallSpeed
{
    if([self.listOfGames isEmpty])
    {
        return 0;
    }
    
    return [self.secondBallSpeed floatValue] / [self.secondSpeedAttempts floatValue];
}

@end
