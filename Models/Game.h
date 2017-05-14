//
//  Game.h
//  Bowlr
//
//  Created by Daniel Stewart on 12/9/14.
//  Copyright (c) 2014 Daniel Stewart. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Frame+Utils.h"

@interface Game : NSObject <NSCoding>

@property (strong, nonatomic) NSString *alley;
@property (strong, nonatomic) NSString *date;
@property (strong, nonatomic) NSMutableArray *allFrames;
@property (strong, nonatomic) NSMutableArray *allBowlrs;
@property (strong, nonatomic) NSNumber *gameID;
@property (readwrite, nonatomic) int totalScore;
@property (readwrite, nonatomic) int currentScore;
@property (readwrite, nonatomic) BLRGameResult result;

- (id)initWithBowlrs:(NSMutableArray *)allBowlrs
           allFrames:(NSMutableArray *)allFrames
                date:(NSString *)date
               alley:(NSString *)alley
              gameID:(NSNumber *)gameID
        currentScore:(int)currentScore
          totalScore:(int)totalScore
              result:(BLRGameResult)result;

@end
