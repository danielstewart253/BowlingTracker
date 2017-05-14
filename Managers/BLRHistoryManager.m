//
//  BLRHistoryManager.m
//  Bowlr
//
//  Created by Daniel Stewart on 4/23/17.
//  Copyright © 2017 Daniel Stewart. All rights reserved.
//

#import "BLRHistoryManager.h"

#define bGameDataFilePath @"gameData"
#define bAlleyKey @"alleyData"
#define bAlleyDataFilePath @"alleyData"
#define bGameNumber @"gameNumber"
#define pinTutorialKey @"pinTutorial"
#define padTutorialKey @"padTutorial"
#define bPlayerHistoryKey @"bowlrHistory"

@interface BLRHistoryManager ()

@property (strong, nonatomic) NSMutableDictionary *allBowlers;
@property (strong, nonatomic) NSMutableArray *historyOfAllBowlrs;
@property (strong, nonatomic) NSMutableArray *allAlleys;

@end

@implementation BLRHistoryManager

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
        [self loadBowlrData];
        [self loadAlleyData];
    }
    
    return self;
}

- (NSMutableArray *)retrieveSelectedPlayers:(NSArray *)selectedPlayers
{
    NSMutableArray *players = [NSMutableArray new];
    for(NSString *playerName in selectedPlayers)
    {
        Player *player = [self.allBowlers objectForKey: playerName];
        [players addObject: player];
    }
    
    return players;
}

- (NSMutableDictionary *)allBowlers
{
    if(!_allBowlers)
    {
        _allBowlers = [NSMutableDictionary new];
        [self loadBowlrData];
        
        if(!_allBowlers)
        {
            _allBowlers = [NSMutableDictionary new];
        }
    }
    
    return _allBowlers;
}

- (NSMutableArray *)returnAllBowlrNames
{
    return [NSMutableArray arrayWithArray: [self.allBowlers allKeys]];
}

- (NSMutableArray *)historyOfAllBowlrs
{
    if(!_historyOfAllBowlrs)
    {
        _historyOfAllBowlrs = [NSMutableArray new];
        [self loadBowlrData];
        
        if(!_historyOfAllBowlrs)
        {
            _historyOfAllBowlrs = [NSMutableArray new];
        }
    }
    
    return _historyOfAllBowlrs;
}

- (NSMutableArray *)allAlleys
{
    if(!_allAlleys)
    {
        _allAlleys = [NSMutableArray new];
        [self loadAlleyData];
        
        if(!_allAlleys)
        {
            _allAlleys = [NSMutableArray new];
        }
        
        [_allAlleys sortUsingSelector: @selector(compare:)];
    }
    
    return _allAlleys;
}

- (void)savePinTutorialSettings:(BOOL)tutorialViewed
{
    [[NSUserDefaults standardUserDefaults] setBool: tutorialViewed
                                            forKey: pinTutorialKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (BOOL)loadPinTutorialSettings
{
    return [[NSUserDefaults standardUserDefaults] boolForKey: pinTutorialKey];
}

- (void)savePadTutorialSettings:(BOOL)tutorialViewed
{
    [[NSUserDefaults standardUserDefaults] setBool: tutorialViewed
                                            forKey: padTutorialKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (BOOL)loadPadTutorialSettings
{
    return [[NSUserDefaults standardUserDefaults] boolForKey: padTutorialKey];
}

- (void)saveGameIDNumber:(NSInteger)gameNumber
{
    [[NSUserDefaults standardUserDefaults] setInteger: gameNumber
                                               forKey: bGameNumber];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSInteger)loadGameIDNumber
{
    return [[NSUserDefaults standardUserDefaults] integerForKey: bGameNumber];
}

- (void)addHistoryBowlr:(Player *)player
{
    [self.allBowlers setObject: player forKey: player.name];
}

- (void)removeHistoryBowlrWithName:(NSString *)playerName
{
    [self.allBowlers removeObjectForKey: playerName];
}

- (void)updatePlayerName:(NSString *)name withNewName:(NSString *)newName
{
    Player *player = [self.allBowlers objectForKey: name];
    player.name = newName;
    [self.allBowlers removeObjectForKey: name];
    
    [self.allBowlers setObject: player forKey: newName];
}

- (NSMutableArray *)returnAllAlleys
{
    return self.allAlleys;
}

// Returns the index for where the alley name would be place alphabetically
- (NSUInteger)indexForOrderedAlleyArray:(NSString *)alleyName
{
    NSUInteger index = 0;
    for(NSString *alley in self.allAlleys)
    {
        NSComparisonResult result = [alleyName compare: alley];
        if(result == NSOrderedAscending)
        {
            return index;
        }
        index++;
    }
    
    return [self.allAlleys count];
}

- (void)addAlleyName:(NSString *)name
{
    [self.allAlleys addObject: name];
}

- (void)removeAlleyName:(NSString *)alleyName
{
    [self.allAlleys removeObject: alleyName];
}

- (BOOL)alleyExists:(NSString *)alleyName
{
    return [self.allAlleys containsObject: alleyName];
}

- (BOOL)playerExists:(NSString *)playerName
{
    return ([self.allBowlers objectForKey: playerName] != nil);
}

#pragma mark - Save/Load Data

- (void)saveBowlrData
{
    NSMutableDictionary *savePlayers = [NSMutableDictionary new];
    NSArray *keys = [self.allBowlers allKeys];
    
    for(NSString *name in keys)
    {
        [savePlayers setObject: [NSKeyedArchiver archivedDataWithRootObject: [self.allBowlers objectForKey: name]]
                        forKey: name];
    }
    
    [[NSUserDefaults standardUserDefaults] setObject: savePlayers
                                              forKey: bPlayerHistoryKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)loadBowlrData
{
    self.allBowlers = [NSMutableDictionary dictionaryWithDictionary: [[NSUserDefaults standardUserDefaults] objectForKey: bPlayerHistoryKey]];
    for(NSString *key in [self.allBowlers allKeys])
    {
        NSData *data = [self.allBowlers objectForKey: key];
        Player *player = [NSKeyedUnarchiver unarchiveObjectWithData: data];
        [self.allBowlers removeObjectForKey: key];
        [self.allBowlers setObject: player forKey: key];
    }
}

- (void)saveAlleyData
{
    [[NSUserDefaults standardUserDefaults] setObject: self.allAlleys
                                              forKey: bAlleyKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)loadAlleyData
{
    self.allAlleys = [NSMutableArray arrayWithArray: [[NSUserDefaults standardUserDefaults] objectForKey: bAlleyKey]];
}

@end
