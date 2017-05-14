//
//  Game+Utils.h
//  Bowlr
//
//  Created by Daniel Stewart on 8/8/15.
//  Copyright (c) 2015 Daniel Stewart. All rights reserved.
//

#import "Game.h"

@interface Game (Utils)

- (void)computeCurrentGameScoreThroughFrame1;
- (void)computeCurrentGameScoreThroughFrame2;
- (void)computeCurrentGameScoreThroughFrame3;
- (void)computeCurrentGameScoreThroughFrame4;
- (void)computeCurrentGameScoreThroughFrame5;
- (void)computeCurrentGameScoreThroughFrame6;
- (void)computeCurrentGameScoreThroughFrame7;
- (void)computeCurrentGameScoreThroughFrame8;
- (void)computeCurrentGameScoreThroughFrame9;
- (void)computeCurrentGameScoreThroughFrame10;
- (int)calculateGameScoreThroughFrame:(int)frameNumber;
- (int)calculateScoreForGame;
- (int)calculateScoreThroughFrame1;
- (int)calculateScoreThroughFrame2;
- (int)calculateScoreThroughFrame3;
- (int)calculateScoreThroughFrame4;
- (int)calculateScoreThroughFrame5;
- (int)calculateScoreThroughFrame6;
- (int)calculateScoreThroughFrame7;
- (int)calculateScoreThroughFrame8;
- (int)calculateScoreThroughFrame9;
- (int)calculateScoreThroughFrame10;
- (int)countStrikes;
- (int)countSpares;
- (int)countOpenFrames;

@end
