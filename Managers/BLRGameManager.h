//
//  BLRGameManager.h
//  Bowlr
//
//  Created by Daniel Stewart on 12/19/14.
//  Copyright (c) 2014 Daniel Stewart. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Game.h"
#import "Player.h"
#import "Frame.h"

@interface BLRGameManager : NSObject

@property (strong, nonatomic) Player *selectedBowlr;
@property (strong, nonatomic) Frame *selectedFrame;
@property (strong, nonatomic) Attempt *selectedAttempt;
@property (strong, nonatomic) NSMutableArray *allBowlrs;

+ (instancetype)sharedManager;
- (void)setUpNewGame:(NSArray *)selectedPlayers alleyName:(NSString *)alley;
- (void)updateStatistics;
- (BOOL)isSelectedFrameNumber:(int)frameNumber;
- (BOOL)isNotSelectedFrameNumber:(int)frameNumber;
- (void)updatePinStateToStrike:(BOOL)setToStrike;
- (void)updatePinState:(BOOL)pinIsUp;
- (void)setToNextFrame;
- (void)setToPreviousFrame;
- (void)changePlayerName:(NSString *)playerName newName:(NSString *)newName;

@end
