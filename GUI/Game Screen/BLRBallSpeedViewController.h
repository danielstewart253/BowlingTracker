//
//  BLRBallSpeedViewController.h
//  Bowlr
//
//  Created by Daniel Stewart on 3/14/17.
//  Copyright © 2017 Daniel Stewart. All rights reserved.
//

#import "BLRGameViewController.h"

@protocol BallSpeedSetterDelegate <NSObject>

- (void)setBallSpeedForButtonTitle;

@end

@interface BLRBallSpeedViewController : BLRGameViewController <UIScrollViewDelegate>

@property (weak, nonatomic) id<BallSpeedSetterDelegate>ballSpeedDelegate;

- (instancetype)initWithNibName:(NSString *)nibNameOrNil
                         bundle:(NSBundle *)nibBundleOrNil
                    gameManager:(BLRGameManager *)gameManager
                 stateProcessor:(BLRStateProcessor *)stateProcessor
              ballSpeedDelegate:(id<BallSpeedSetterDelegate>)ballSpeedDelegate;

@end
