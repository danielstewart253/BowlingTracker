//
//  BLRGameSummaryLineItemViewController.h
//  Bowlr
//
//  Created by Daniel Stewart on 4/9/17.
//  Copyright © 2017 Daniel Stewart. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BLRGameSummaryLineItemViewController : UIViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil
                         bundle:(NSBundle *)nibBundleOrNil
                         player:(Player *)player;
- (void)populateWithPlayerStats;
- (void)populateWithTitles;

@end
