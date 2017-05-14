//
//  BLRGameInterfaceViewController.h
//  Bowlr
//
//  Created by Daniel Stewart on 3/14/17.
//  Copyright © 2017 Daniel Stewart. All rights reserved.
//

#import "BLRGameViewController.h"
#import "BLRGameViewController.h"
#import "BLRHeaderUpdate.h"
#import "BLRFrameWindowUpdate.h"
#import "BLRGameScreenAnimation.h"

@interface BLRGameInterfaceViewController : BLRGameViewController

@property (weak, nonatomic) id<BLRGameScreenAnimation>animationDelegate;
@property (weak, nonatomic) id<BLRHeaderUpdate>headerDelegate;
@property (weak, nonatomic) id<BLRFrameWindowUpdate>frameWindowDelegate;

- (instancetype)initWithNibName:(NSString *)nibNameOrNil
                    gameManager:(BLRGameManager *)gameManager
                 stateProcessor:(BLRStateProcessor *)stateProcessor
                 headerDelegate:(id<BLRHeaderUpdate>)headerDelegate
                  frameDelegate:(id<BLRFrameWindowUpdate>)frameDelegate
              animationDelegate:(id<BLRGameScreenAnimation>)animation;

@end
