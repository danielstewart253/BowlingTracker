//
//  BLRHistoryMenuViewController.m
//  Bowlr
//
//  Created by Daniel Stewart on 4/24/17.
//  Copyright © 2017 Daniel Stewart. All rights reserved.
//

#import "BLRHistoryMenuViewController.h"
#import "StatCardViewController.h"
#import "MenuAchievementsViewController.h"

@implementation BLRHistoryMenuViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (BOOL)isHistoryButtonEnabled
{
    return NO;
}

- (BOOL)isMoreButtonEnabled
{
    return YES;
}

#pragma - mark UITableview Setup
- (NSString *)titleForCellAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 0)
    {
        return bGamesMenuItem;
    }
    else if(indexPath.row == 1)
    {
        return bStatsMenuItem;
    }
    else if(indexPath.row == 2)
    {
        return bAchievementsMenuItem;
    }
    
    return nil;
}

// Selection of any cell will open web browser to the specified website
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath: indexPath animated: NO];
    
    if(indexPath.row == 1)
    {
        StatCardViewController *statCard = [[StatCardViewController alloc] initWithNibName:bStatCardVC bundle: nil];
        
        [self.navigationController pushViewController:statCard animated:YES];
    }
    else if(indexPath.row == 2)
    {
        MenuAchievementsViewController *achievements = [[MenuAchievementsViewController alloc] init];
        
        [self.navigationController pushViewController:achievements animated:YES];
    }
}

// Returns the number of rows for each section
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

@end
