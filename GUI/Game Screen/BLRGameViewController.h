//
//  BLRGameViewController.h
//  Bowlr
//
//  Created by Daniel Stewart on 3/9/17.
//  Copyright © 2017 Daniel Stewart. All rights reserved.
//

#import "BLRViewController.h"
#import "BLRStateProcessor.h"

@interface BLRGameViewController : BLRViewController

@property (strong, nonatomic) BLRGameManager *gameManager;
@property (strong, nonatomic) BLRStateProcessor *attemptProcessor;

- (instancetype)initWithNibName:(NSString *)nibNameOrNil
                         bundle:(NSBundle *)nibBundleOrNil
                    gameManager:(BLRGameManager *)gameManager
                 stateProcessor:(BLRStateProcessor *)stateProcessor;

@end
