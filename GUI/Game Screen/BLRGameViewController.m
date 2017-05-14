//
//  BLRGameViewController.m
//  Bowlr
//
//  Created by Daniel Stewart on 3/9/17.
//  Copyright © 2017 Daniel Stewart. All rights reserved.
//

#import "BLRGameViewController.h"

@interface BLRGameViewController ()

@end

@implementation BLRGameViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil
                         bundle:(NSBundle *)nibBundleOrNil
                    gameManager:(BLRGameManager *)gameManager
                 stateProcessor:(BLRStateProcessor *)stateProcessor
{
    self = [super initWithNibName: nibNameOrNil bundle: nil];
    if(self)
    {
        self.gameManager = gameManager;
        self.attemptProcessor = stateProcessor;
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

@end
