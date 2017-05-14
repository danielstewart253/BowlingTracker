//
//  AchievementsViewController.m
//  Bowlr
//
//  Created by Daniel Stewart on 12/17/14.
//  Copyright (c) 2014 Daniel Stewart. All rights reserved.
//

#import "AchievementsViewController.h"

@interface AchievementsViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *backgroundImage;
@property (weak, nonatomic) IBOutlet UIButton *resumeGameButton;
@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (weak, nonatomic) IBOutlet UITableView *achievementTable;

@property (strong, nonatomic) NSArray *listOfBowlrs;
@property (strong, nonatomic) Player *selectedBowlr;
@property (strong, nonatomic) NSIndexPath *selectedRow;
@property (strong, nonatomic) NSMutableArray *listOfAchievements;

@end

@implementation AchievementsViewController

#define BLR_CELL_HEIGHT_STANDARD 45
#define BLR_CELL_HEIGHT_EXPANDED 63

- (instancetype)initWithNibName:(NSString *)nibNameOrNil
                         bundle:(NSBundle *)nibBundleOrNil
                   listOfBowlrs:(NSMutableArray *)listOfBowlrs
{
    self = [super initWithNibName: nibNameOrNil bundle:nibBundleOrNil];
    if(self)
    {
        self.listOfBowlrs = listOfBowlrs;
        self.selectedBowlr = [listOfBowlrs objectAtIndex: 0];
        self.listOfAchievements = self.selectedBowlr.listOfAchievements;
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear: animated];
    
    self.backButton.hidden = [self shouldHideMenuButton];
    self.resumeGameButton.hidden = [self shouldHideResumeButton];
}

- (BOOL)shouldHideMenuButton
{
    return NO;
}

- (BOOL)shouldHideResumeButton
{
    return NO;
}

#pragma - mark UITableView Setup

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier = @"Achievement";

    AchievementsTableCell *achievementsCell = (AchievementsTableCell *)[tableView dequeueReusableCellWithIdentifier: cellIdentifier];

    if(!achievementsCell)
    {
        [tableView registerNib: [UINib nibWithNibName: bAchievementsCell
                                               bundle: nil] forCellReuseIdentifier: cellIdentifier];
        achievementsCell = (AchievementsTableCell *)[tableView dequeueReusableCellWithIdentifier: cellIdentifier];
    }

    [achievementsCell populateCellWithAchievement: [self.listOfAchievements objectAtIndex: indexPath.row]
                                      atIndexPath: indexPath];
    
    [achievementsCell setCellSelectionState: indexPath.row == self.selectedRow.row];

    return achievementsCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(self.selectedRow && indexPath.row == self.selectedRow.row)
    {
        AchievementsTableCell *cell = (AchievementsTableCell *)[tableView cellForRowAtIndexPath: indexPath];
        [tableView beginUpdates];
        self.selectedRow = nil;
        cell.selected = NO;
        [cell animateToDeselectedState];
        [tableView deselectRowAtIndexPath: indexPath animated: NO];
        [tableView endUpdates];
        return;
    }
    
    AchievementsTableCell *previousCell = (AchievementsTableCell *)[tableView cellForRowAtIndexPath: self.selectedRow];
    [previousCell animateToDeselectedState];
    [tableView deselectRowAtIndexPath: self.selectedRow animated: NO];
    [tableView beginUpdates];
    
    AchievementsTableCell *currentCell = (AchievementsTableCell *)[tableView cellForRowAtIndexPath: indexPath];
    currentCell.selected = YES;
    
    if((self.selectedRow && indexPath.row != self.selectedRow.row) || self.selectedRow == nil)
    {
        [currentCell animateToSelectedState];
    }
    
    self.selectedRow = indexPath;
    [tableView endUpdates];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return (self.selectedRow && indexPath.row == self.selectedRow.row) ? BLR_CELL_HEIGHT_EXPANDED : BLR_CELL_HEIGHT_STANDARD;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.listOfAchievements count];
}

#pragma - mark Screen Transitions
- (IBAction)backButtonAction
{
    [self.navigationController popViewControllerAnimated: YES];
}

- (IBAction)resumeGameButtonAction
{
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    UINavigationController *rootVC = [delegate getRootNavigationController];
    
    [rootVC popViewControllerAnimated: NO];
    [UIView transitionWithView: rootVC.view
                      duration: 0.6
                       options: UIViewAnimationOptionTransitionFlipFromLeft
                    animations: nil
                    completion: nil];
}

@end

