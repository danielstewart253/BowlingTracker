//
//  BLRMainGameViewController.h
//  Bowlr
//
//  Created by Daniel Stewart on 3/14/17.
//  Copyright © 2017 Daniel Stewart. All rights reserved.
//

#import "BLRLandscapeOptionViewController.h"
#import "BLRGameScreenAnimation.h"
#import "BLRAchievementsManager.h"

@interface BLRMainGameViewController : BLRLandscapeOptionViewController <CAAnimationDelegate, BLRGameScreenAnimation>

@property (strong, nonatomic) BLRAchievementsManager *achievementsManager;

- (instancetype)initWithNibName:(NSString *)nibNameOrNil
                         bundle:(NSBundle *)nibBundleOrNil
                    gameManager:(BLRGameManager *)gameManager
            achievementsManager:(BLRAchievementsManager *)achievementsManager
                 stateProcessor:(BLRStateProcessor *)stateProcessor;

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil __unavailable;

@end
