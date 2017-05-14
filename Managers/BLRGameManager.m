//
//  BLRGameManager.m
//  Bowlr
//
//  Created by Daniel Stewart on 12/19/14.
//  Copyright (c) 2014 Daniel Stewart. All rights reserved.
//

#import "BLRGameManager.h"

@implementation BLRGameManager

+ (instancetype)sharedManager
{
    static dispatch_once_t once;
    static id sharedInstance;
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (instancetype)init
{
    self = [super init];
    if(self)
    {
        self.allBowlrs = [NSMutableArray new];
    }
    
    return self;
}

- (void)setUpNewGame:(NSArray *)selectedPlayers alleyName:(NSString *)alley
{
    // Create a new Game for each Player
    for(Player *player in selectedPlayers)
    {
        player.currentGame = [[Game alloc] init];
        player.currentGame.alley = alley;
        [self.allBowlrs addObject: player];
    }
    
    Player *firstPlayer = [self.allBowlrs firstObject];
    self.selectedBowlr = firstPlayer;
    self.selectedFrame = [firstPlayer.currentGame.allFrames firstObject];
    self.selectedAttempt = self.selectedFrame.firstAttempt;
}

- (void)updateStatistics
{
    for(Player *player in self.allBowlrs)
    {
        [player.gameHistory updateStatistics: player.currentGame];
    }
}

- (BOOL)isSelectedFrameNumber:(int)frameNumber
{
    return self.selectedFrame.frameNumber == frameNumber;
}

- (BOOL)isNotSelectedFrameNumber:(int)frameNumber
{
    return self.selectedFrame.frameNumber != frameNumber;
}

- (void)updatePinStateToStrike:(BOOL)setToStrike
{
    BLRPinState pinState = setToStrike ? BLRPinStateDown : BLRPinStateUp;
    [self.selectedAttempt setAllPinsStateForAttempt: pinState];
}

- (void)updatePinState:(BOOL)pinIsUp
{
    BLRPinState pinState = pinIsUp ? BLRPinStateUp : BLRPinStateDown;
    [self.selectedAttempt setAllPinsStateForAttempt:pinState];
}

- (void)setToNextFrame
{
    if(self.selectedFrame.frameNumber == 10)
    {
        return;
    }
    
    self.selectedFrame = [self.selectedBowlr.currentGame.allFrames objectAtIndex: self.selectedFrame.frameNumber];
    
    // Always set to first attempt when switching Frames
    self.selectedAttempt = self.selectedFrame.firstAttempt;
    self.selectedFrame.currentAttempt = BLRCurrentAttemptFirst;
}

- (void)setToPreviousFrame
{
    if(self.selectedFrame.frameNumber == 1)
    {
        return;
    }
    
    self.selectedFrame = [self.selectedBowlr.currentGame.allFrames objectAtIndex: self.selectedFrame.frameNumber - 2];
    
    self.selectedAttempt = self.selectedFrame.firstAttempt;
    self.selectedFrame.currentAttempt = BLRCurrentAttemptFirst;
}

- (void)changePlayerName:(NSString *)playerName newName:(NSString *)newName
{
    for(int i = 0; i < [self.allBowlrs count]; i++)
    {
        Player *currentPlayer = [self.allBowlrs objectAtIndex:i];
        if([currentPlayer.name isEqualToString: playerName])
        {
            currentPlayer.name = newName;
            break;
        }
    }
}

@end
