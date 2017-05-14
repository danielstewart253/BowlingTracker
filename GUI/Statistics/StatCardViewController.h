//
//  StatCardViewController.h
//  Bowlr
//
//  Created by Daniel Stewart on 12/9/14.
//  Copyright (c) 2014 Daniel Stewart. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "Game.h"

@interface StatCardViewController : UIViewController {
        
    //The currently selected Player to display their statistics
    Player *selectedPlayer;
}

//Array holds all Bowlrs ever created and saved to disk
@property (nonatomic, strong) NSMutableArray *historyOfAllBowlrs;

@end
