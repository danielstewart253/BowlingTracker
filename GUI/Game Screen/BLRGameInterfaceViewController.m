//
//  BLRGameInterfaceViewController.m
//  Bowlr
//
//  Created by Daniel Stewart on 3/14/17.
//  Copyright © 2017 Daniel Stewart. All rights reserved.
//

#import "BLRGameInterfaceViewController.h"

@interface BLRGameInterfaceViewController ()

@end

@implementation BLRGameInterfaceViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil
                    gameManager:(BLRGameManager *)gameManager
                 stateProcessor:(BLRStateProcessor *)stateProcessor
                 headerDelegate:(id<BLRHeaderUpdate>)headerDelegate
                  frameDelegate:(id<BLRFrameWindowUpdate>)frameDelegate
              animationDelegate:(id<BLRGameScreenAnimation>)animation
{
    self = [super initWithNibName: nibNameOrNil
                           bundle: nil
                      gameManager: gameManager
                   stateProcessor: stateProcessor];
    if(self)
    {
        self.attemptProcessor = stateProcessor;
        self.headerDelegate = headerDelegate;
        self.frameWindowDelegate = frameDelegate;
        self.animationDelegate = animation;
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

@end
