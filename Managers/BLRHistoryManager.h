//
//  BLRHistoryManager.h
//  Bowlr
//
//  Created by Daniel Stewart on 4/23/17.
//  Copyright © 2017 Daniel Stewart. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BLRHistoryManager : NSObject

+ (instancetype)sharedManager;
- (NSMutableArray *)retrieveSelectedPlayers:(NSArray *)selectedPlayers;
- (void)savePinTutorialSettings:(BOOL)tutorialViewed;
- (BOOL)loadPinTutorialSettings;
- (void)savePadTutorialSettings:(BOOL)tutorialViewed;
- (BOOL)loadPadTutorialSettings;
- (void)saveGameIDNumber:(NSInteger)gameNumber;
- (NSInteger)loadGameIDNumber;
- (NSMutableArray *)returnAllBowlrNames;
- (void)addHistoryBowlr:(Player *)player;
- (void)removeHistoryBowlrWithName:(NSString *)playerName;
- (void)updatePlayerName:(NSString *)name withNewName:(NSString *)newName;
- (NSMutableArray *)returnAllAlleys;
- (NSUInteger)indexForOrderedAlleyArray:(NSString *)alleyName;
- (void)addAlleyName:(NSString *)name;
- (void)removeAlleyName:(NSString *)alleyName;
- (BOOL)alleyExists:(NSString *)alleyName;
- (BOOL)playerExists:(NSString *)playerName;
- (void)saveBowlrData;
- (void)saveAlleyData;
- (void)loadBowlrData;

@end
