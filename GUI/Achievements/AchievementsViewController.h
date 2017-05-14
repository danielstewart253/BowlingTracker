//
//  AchievementsViewController.h
//  Bowlr
//
//  Created by Daniel Stewart on 12/17/14.
//  Copyright (c) 2014 Daniel Stewart. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Achievement.h"
#import "AchievementsTableCell.h"

@interface AchievementsViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

- (instancetype)initWithNibName:(NSString *)nibNameOrNil
                         bundle:(NSBundle *)nibBundleOrNil
                   listOfBowlrs:(NSMutableArray *)listOfBowlrs;

- (BOOL)shouldHideMenuButton;
- (BOOL)shouldHideResumeButton;

@end
