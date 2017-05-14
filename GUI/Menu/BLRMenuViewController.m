//
//  BLRMenuViewController.m
//  Bowlr
//
//  Created by Daniel Stewart on 7/19/15.
//  Copyright (c) 2015 Daniel Stewart. All rights reserved.
//

#import "BLRMenuViewController.h"
#import "BLRHistoryMenuViewController.h"
#import "BLRMoreMenuViewController.h"
#import "BLRMenuTableViewCell.h"

@interface BLRMenuViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *backgroundImage;
@property (weak, nonatomic) IBOutlet UIButton *startButton;
@property (weak, nonatomic) IBOutlet UIButton *historyButton;
@property (weak, nonatomic) IBOutlet UIButton *moreButton;
@property (weak, nonatomic) IBOutlet UITableView *menuTable;

@end

@implementation BLRMenuViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.historyButton.enabled = [self isHistoryButtonEnabled];
    self.moreButton.enabled = [self isMoreButtonEnabled];
}

- (BLRMenuTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier = @"MenuCell";
    
    BLRMenuTableViewCell *cell = (BLRMenuTableViewCell *)[tableView dequeueReusableCellWithIdentifier: cellIdentifier];
    if(!cell)
    {
        cell = [[BLRMenuTableViewCell alloc] initWithStyle: UITableViewCellStyleDefault
                                           reuseIdentifier: cellIdentifier
                                                 indexPath: indexPath];
    }
    
    cell.textLabel.text = [self titleForCellAtIndexPath: indexPath];
    
    return cell;
}

- (NSString *)titleForCellAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}

- (BOOL)isHistoryButtonEnabled
{
    return YES;
}

- (BOOL)isMoreButtonEnabled
{
    return YES;
}

- (IBAction)startButtonAction:(id)sender
{
    [self.navigationController popToRootViewControllerAnimated: NO];
}

- (IBAction)historyButtonAction:(id)sender
{
    BLRHistoryMenuViewController *historyVC = [[BLRHistoryMenuViewController alloc] initWithNibName: bMenuVC bundle:nil];
    [self.navigationController pushViewController: historyVC animated: NO];
}

- (IBAction)moreButtonAction:(id)sender
{
    BLRMoreMenuViewController *moreVC = [[BLRMoreMenuViewController alloc] initWithNibName: bMenuVC bundle:nil];
    [self.navigationController pushViewController: moreVC animated:NO];
}

@end
