//
//  BLRLandingViewController.m
//  Bowlr
//
//  Created by Daniel Stewart on 4/25/17.
//  Copyright © 2017 Daniel Stewart. All rights reserved.
//

#import "BLRLandingViewController.h"
#import "BLRHistoryMenuViewController.h"
#import "BLRMoreMenuViewController.h"
#import "BLRMainGameViewController.h"
#import "BLRMenuTableCell.h"
#import "BLRTextFieldCell.h"
#import "BLRAlleyCell.h"
#import "BLRPlayerCell.h"
#import "BLRSelectedPlayerCell.h"
#import "BLRPlayButtonView.h"
#import "BLRMenuHeaderView.h"

@interface BLRLandingViewController ()

@property (weak, nonatomic) IBOutlet MenuEditTableView *menuTableView;
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImage;
@property (weak, nonatomic) IBOutlet UIButton *startButton;
@property (weak, nonatomic) IBOutlet UIButton *historyButton;
@property (weak, nonatomic) IBOutlet UIButton *moreButton;
@property (weak, nonatomic) IBOutlet BLRButton *startGameButton;

@property (strong, nonatomic) BLRGameManager *gameManager;
@property (strong, nonatomic) BLRHistoryManager *historyManager;
@property (strong, nonatomic) NSMutableArray *bowlerNames;
@property (strong, nonatomic) NSMutableArray *selectedBowlrs;
@property (strong, nonatomic) NSMutableArray *alleyNames;
@property (strong, nonatomic) BLRMenuTextField *alleyTextField;
@property (strong, nonatomic) BLRMenuTextField *playerTextField;
@property (strong, nonatomic) NSString *selectedAlley;
@property (strong, nonatomic) NSIndexPath *lastIndexPathForAlleyCells;
@property (strong, nonatomic) NSIndexPath *indexPathForTextField;
@property (strong, nonatomic) NSIndexPath *indexPathToDelete;


@end

#define BLRHEADERHEIGHT 25.0f
#define BLRCELLHEIGHT 40.0f
#define BLRMAX_PLAYERS 8
#define BLRSECTIONCOUNT 5

@implementation BLRLandingViewController

static NSUInteger bAlleySection = 0;
static NSUInteger bAlleyTextFieldSection = 1;
static NSUInteger bSelectedPlayerSection = 2;
static NSUInteger bPlayerSection = 3;
static NSUInteger bPlayerTextFieldSection = 4;

- (instancetype)initWithGameManager:(BLRGameManager *)gameManager
                     historyManager:(BLRHistoryManager *)historyManager
{
    self = [super initWithNibName: bLandingVC
                           bundle: nil];
    if(self)
    {
        self.gameManager = gameManager;
        self.historyManager = historyManager;
        self.bowlerNames = [historyManager returnAllBowlrNames];
        self.selectedBowlrs = [NSMutableArray new];
        self.alleyNames = [historyManager returnAllAlleys];
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.startGameButton setStandardView: [[BLRPlayButtonView alloc] initWithFrame: self.startGameButton.frame
                                                                              color: [UIColor BLRMenuButtonStandard]]
                          highlightedView: [[BLRPlayButtonView alloc] initWithFrame: self.startGameButton.frame
                                                                              color: [UIColor BLRMenuButtonHighlighted]]];
}

#pragma - mark TableView Methods
/**
 *  Section #1: All alleys
 *  Section #2: TextField for adding alleys
 *  Section #3: Selected Players
 *  Section #4: All other Players
 *  Section #5: TextField for adding a Player
 **/
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return BLRSECTIONCOUNT;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return [self.alleyNames count];
            break;
        case 1:
            return 1;
            break;
        case 2:
            return [self.selectedBowlrs count];
            break;
        case 3:
            return [self.bowlerNames count];
            break;
        case 4:
            return 1;
        default:
            return 0;
            break;
    }
}

- (NSString *)identifierForIndexPath:(NSIndexPath *)currentPath
{
    switch (currentPath.section) {
        case 0:
            return bAlleyCell;
            break;
        case 1:
            return bTextFieldCell;
            break;
        case 2:
            return bSelectedPlayerCell;
            break;
        case 3:
            return bPlayerCell;
            break;
        case 4:
            return bTextFieldCell;
            break;
        default:
            return nil;
            break;
    }
}

- (NSMutableArray *)dataSourceForIndexPath:(NSIndexPath *)currentPath
{
    switch (currentPath.section) {
        case 0:
            return self.alleyNames;
            break;
        case 2:
            return self.selectedBowlrs;
            break;
        case 3:
            return self.bowlerNames;
            break;
        default:
            return nil;
            break;
    }
}

- (CGFloat)tableView:(MenuEditTableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return BLRCELLHEIGHT;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return (section == bAlleySection || section == bSelectedPlayerSection) ? BLRHEADERHEIGHT : 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if(section == bAlleySection || section == bSelectedPlayerSection)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed: bMenuHeader owner: self options: nil];
        BLRMenuHeaderView *headerView = (BLRMenuHeaderView *)[nib objectAtIndex: 0];
        [headerView setText: (section == bAlleySection) ? bAlleys : bBowlrs];
        return headerView;
    }
    
    return [[UIView alloc] initWithFrame: CGRectZero];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == bAlleyTextFieldSection || indexPath.section == bPlayerTextFieldSection)
    {
        return NO;
    }
    
    return YES;
}

- (UITableViewCell *)tableView:(MenuEditTableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifier = [self identifierForIndexPath: indexPath];
    if(indexPath.section == bAlleyTextFieldSection || indexPath.section == bPlayerTextFieldSection)
    {
        BLRTextFieldCell *textFieldCell = (BLRTextFieldCell *)[tableView dequeueReusableCellWithIdentifier: identifier];
        if(!textFieldCell)
        {
            [tableView registerNib: [UINib nibWithNibName: identifier bundle: nil] forCellReuseIdentifier: identifier];
            textFieldCell = (BLRTextFieldCell *)[tableView dequeueReusableCellWithIdentifier: identifier];
        }
        textFieldCell.textField.delegate = self;
        [textFieldCell.textField displayPlaceHolderForText: (indexPath.section == bAlleyTextFieldSection) ? bAddAlley : bAddBowlr
                                                 withColor: [UIColor BLRMenuViewCellPlaceHolderTextColor]];
        
        if(indexPath.section == bAlleyTextFieldSection)
        {
            textFieldCell.contentView.backgroundColor = [self cellBackgroundColorForIndexPath: [NSIndexPath indexPathForRow: [self.alleyNames count]
                                                                                                                  inSection: bAlleyTextFieldSection]];
            self.alleyTextField = textFieldCell.textField;
        }
        else
        {
            textFieldCell.contentView.backgroundColor = [self cellBackgroundColorForIndexPath: [NSIndexPath indexPathForRow: [self.bowlerNames count]
                                                                                                                  inSection: bPlayerTextFieldSection]];
            self.playerTextField = textFieldCell.textField;
        }
        
        return textFieldCell;
    }
    
    NSMutableArray *dataSource = [self dataSourceForIndexPath: indexPath];
    BLRMenuTableCell *cell = [tableView dequeueReusableCellWithIdentifier: identifier];
    if(!cell)
    {
        [tableView registerNib: [UINib nibWithNibName: identifier bundle: nil] forCellReuseIdentifier: identifier];
        cell = [tableView dequeueReusableCellWithIdentifier: identifier];
    }
    
    [cell.textField displayPlaceHolderForText: [dataSource objectAtIndex: indexPath.row]
                                    withColor: [UIColor BLRMenuViewCellPlaceHolderTextColor]];
    cell.label.text = [dataSource objectAtIndex: indexPath.row];
    cell.textField.text = [dataSource objectAtIndex: indexPath.row];
    cell.textField.delegate = self;
    [cell cellBackgroundColor: [self cellBackgroundColorForIndexPath: indexPath]];
    
    // Single selection for alley cells
    cell.selected = (indexPath.section == bAlleySection) && ([self.selectedAlley isEqualToString: [dataSource objectAtIndex: indexPath.row]]);
    
    return cell;
}

- (UIColor *)cellBackgroundColorForIndexPath:(NSIndexPath *)indexPath
{
    return (indexPath.row % 2 == 0) ? [UIColor BLRMenuViewCellMidColor] : [UIColor BLRMenuViewCellHighColor];
}

// Only cells that can be moved are cells of selected Bowlrs
- (BOOL)moveTableView:(MenuEditTableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == bSelectedPlayerSection)
    {
        if(indexPath.row < [self.selectedBowlrs count])
        {
            if(!self.menuTableView.isEditing)
            {
                return YES;
            }
        }
    }
    
    return  NO;
}

- (void)moveTableView:(MenuEditTableView *)tableView
 moveRowFromIndexPath:(NSIndexPath *)fromIndexPath
          toIndexPath:(NSIndexPath *)toIndexPath
{
    // If the row to move to is beyond the number of selected Bowlrs, move the row to the last row of selected Bowlrs
    if(toIndexPath.row > [self.selectedBowlrs count] - 1)
    {
        [self.selectedBowlrs removeObjectAtIndex: fromIndexPath.row];
        [self.selectedBowlrs addObject: [self.selectedBowlrs objectAtIndex: fromIndexPath.row]];
    }
    else if(toIndexPath.row <= [self.selectedBowlrs count] - 1)
    {
        [self.selectedBowlrs removeObjectAtIndex: fromIndexPath.row];
        [self.selectedBowlrs insertObject: [self.selectedBowlrs objectAtIndex: fromIndexPath.row] atIndex: toIndexPath.row];
    }
    
    [self.menuTableView reloadData];
}

- (NSIndexPath *)moveTableView:(MenuEditTableView *)tableView targetIndexPathForMoveFromRowAtIndexPath:(NSIndexPath *)sourceIndexPath toProposedIndexPath:(NSIndexPath *)proposedDestinationIndexPath
{
    if(sourceIndexPath.row > [self.bowlerNames count])
    {
        sourceIndexPath = [NSIndexPath indexPathForRow: [self.bowlerNames count] inSection: bSelectedPlayerSection];
    }
    if(proposedDestinationIndexPath.row > [self.bowlerNames count])
    {
        proposedDestinationIndexPath = [NSIndexPath indexPathForRow: [self.bowlerNames count] inSection: bSelectedPlayerSection];
    }
    
    if ([sourceIndexPath section] != [proposedDestinationIndexPath section])
    {
        proposedDestinationIndexPath = sourceIndexPath;
    }
    
    if(proposedDestinationIndexPath.row > [self.bowlerNames count] - 1)
    {
        proposedDestinationIndexPath = [NSIndexPath indexPathForRow: [self.bowlerNames count] - 1 inSection: bSelectedPlayerSection];
    }
    
    return proposedDestinationIndexPath;
}

- (NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewRowAction *editAction = [UITableViewRowAction rowActionWithStyle: UITableViewRowActionStyleNormal title: @"Edit" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath)
    {
        if(indexPath.section == bAlleySection)
        {
            [self.alleyTextField becomeFirstResponder];
        }
        if(indexPath.section == bPlayerSection)
        {
            [self.playerTextField becomeFirstResponder];
        }
    }];
    editAction.backgroundColor = [UIColor clearColor];
    
    UITableViewRowAction *deleteAction = [UITableViewRowAction rowActionWithStyle: UITableViewRowActionStyleNormal title: @" "  handler:^(UITableViewRowAction *action, NSIndexPath *indexPath)
    {
        [self deleteCell: indexPath];
    }];
    deleteAction.backgroundColor = [UIColor clearColor];
    return @[editAction, deleteAction];
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == bAlleySection)
    {
        self.selectedAlley = nil;
        self.lastIndexPathForAlleyCells = nil;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == bAlleyTextFieldSection || indexPath.section == bPlayerTextFieldSection)
    {
        return;
    }
    
    BLRMenuTableCell *selectedCell = [tableView cellForRowAtIndexPath: indexPath];
    
    // Single selection in the Alley section
    if(indexPath.section == bAlleySection)
    {
        if([self.selectedAlley isEqualToString: selectedCell.label.text])
        {
            self.selectedAlley = nil;
            self.lastIndexPathForAlleyCells = nil;
        }
        else
        {
            [tableView deselectRowAtIndexPath: self.lastIndexPathForAlleyCells animated: NO];
            self.lastIndexPathForAlleyCells = indexPath;
            self.selectedAlley = selectedCell.label.text;
        }
        
        return;
    }
    
    if(indexPath.section == bPlayerSection)
    {
        [tableView deselectRowAtIndexPath: indexPath animated: NO];
        if([self.selectedBowlrs count] == BLRMAX_PLAYERS)
        {
            [self alertDimViewAnimation];
            [self notifyAlertViewSetUpWithTitle: bMaxBowlrsTitle
                                        message: bMaxBowlrsMessage
                                         action: @selector(alertViewDismissAnimation)];
            [self alertViewPopUpAnimation: self.customAlert];
            return;
        }
        
        [self.selectedBowlrs addObject: selectedCell.label.text];
        [self.bowlerNames removeObject: selectedCell.label.text];
        [self.menuTableView beginUpdates];
        [self.menuTableView deleteRowsAtIndexPaths: [NSArray arrayWithObject: indexPath]
                                  withRowAnimation: UITableViewRowAnimationFade];
        
        [self.menuTableView insertRowsAtIndexPaths: [NSArray arrayWithObject: [NSIndexPath indexPathForRow: [self.selectedBowlrs count] - 1
                                                                                                 inSection: bSelectedPlayerSection]]
                                  withRowAnimation: UITableViewRowAnimationFade];
        [self.menuTableView endUpdates];
        
        return;
    }
    
    // Deselection
    if(indexPath.section == bSelectedPlayerSection)
    {
        [tableView deselectRowAtIndexPath: indexPath animated: NO];
        [self.selectedBowlrs removeObject: selectedCell.label.text];
        NSUInteger index = [self.bowlerNames indexForAscendingStrings: selectedCell.label.text];
        [self.bowlerNames insertObject: selectedCell.label.text atIndex: index];
        [self.menuTableView beginUpdates];

        [self.menuTableView deleteRowsAtIndexPaths: [NSArray arrayWithObject: indexPath]
                                  withRowAnimation: UITableViewRowAnimationFade];
        
        [self.menuTableView insertRowsAtIndexPaths: [NSArray arrayWithObject: [NSIndexPath indexPathForRow: index
                                                                                                 inSection: bPlayerSection]]
                                  withRowAnimation: UITableViewRowAnimationFade];
        [self.menuTableView endUpdates];

        return;
    }
}

- (void)deleteCell:(NSIndexPath *)indexPath
{
    [self alertDimViewAnimation];
    
    if(indexPath.section == bAlleySection)
    {
        [self optionsAlertViewSetUpWithTitle: bDeleteAlleyTitle
                                     message: bDeleteAlleyMessage
                                      action: @selector(alertViewDeleteAlleyAction)
                          primaryButtonTitle: bDeleteButtonTitle
                             secondaryAction: @selector(alertViewDismissAnimation)];
    }
    else if(indexPath.section == bPlayerSection || indexPath.section == bSelectedPlayerSection)
    {
        [self optionsAlertViewSetUpWithTitle: bDeleteBowlrTitle
                                     message: bDeleteBowlrMessage
                                      action: @selector(alertViewDeleteBowlrAction)
                          primaryButtonTitle: bDeleteButtonTitle
                             secondaryAction: @selector(alertViewDismissAnimation)];
    }
    
    self.indexPathToDelete = indexPath;
}

#pragma - mark TextField Actions

- (BOOL)textFieldShouldReturn:(BLRMenuTextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void)textFieldDidBeginEditing:(BLRMenuTextField *)textField
{
    if(textField == self.alleyTextField || textField == self.playerTextField)
    {
        textField.placeholder = @"";
        return;
    }
}

- (void)textFieldDidEndEditing:(BLRMenuTextField *)textField
{
    if(textField.text != nil && [textField.text length] > 0)
    {
        if(textField == self.alleyTextField)
        {
            [self alleyTextFieldReturned: textField];
            [self.alleyTextField resignFirstResponder];
        }
        else if(textField == self.playerTextField)
        {
            [self playerTextFieldReturned: textField];
            [self.playerTextField resignFirstResponder];
        }
        else
        {
            [self handleTextField:(textField)];
        }
    }
    
    [textField displayPlaceHolderForText: bAddBowlr
                               withColor: [UIColor BLRMenuViewCellPlaceHolderTextColor]];
    self.indexPathForTextField = nil;
    [self.menuTableView endEditing: YES];
}

- (void)alleyTextFieldReturned:(BLRMenuTextField *)textField
{
    if(![self checkForDuplicateAlley: textField.text] && textField.text != nil)
    {
        [self.alleyNames insertObject: textField.text
                              atIndex: [self.historyManager indexForOrderedAlleyArray: textField.text]];
        [self.menuTableView reloadSections: [[NSIndexSet alloc] initWithIndex: bAlleySection]
                          withRowAnimation: UITableViewRowAnimationFade];
        [self.historyManager saveAlleyData];
    }
}

- (void)playerTextFieldReturned:(BLRMenuTextField *)textField
{
    if(![self checkForDuplicatePlayer: textField.text] && textField.text != nil)
    {
        Player *newPlayer = [[Player alloc] initWithName: textField.text];
        [self.historyManager addHistoryBowlr: newPlayer];
        [self.bowlerNames insertObject: textField.text
                               atIndex: [self.bowlerNames indexForAscendingStrings: textField.text]];
        [self.menuTableView reloadSection: bPlayerSection];
        [self.historyManager saveBowlrData];
    }
}

- (void)handleTextField:(UITextField *)textField
{
    if(!self.indexPathForTextField)
    {
        return;
    }
    
    BLRMenuTableCell *cell = [self.menuTableView cellForRowAtIndexPath: self.indexPathForTextField];
    if(self.indexPathForTextField.section == bAlleySection)
    {
        if(![cell.textField.text isEqualToString: cell.label.text] && ![self checkForDuplicateAlley: cell.textField.text])
        {
            if(cell.textField.text.length != 0)
            {
                [self.alleyNames removeObjectAtIndex: self.indexPathForTextField.row];
                [self.alleyNames insertObject: cell.textField.text
                                      atIndex: [self.alleyNames indexForAscendingStrings: cell.textField.text]];
                [self.menuTableView reloadSection: bAlleySection];
                [self.historyManager saveAlleyData];
            }
        }
    }
    
    if(self.indexPathForTextField.section == bPlayerSection)
    {
        if(![cell.textField.text isEqualToString: cell.label.text] && ![self checkForDuplicatePlayer: cell.textField.text])
        {
            if(cell.textField.text.length != 0)
            {
                NSString *bowlerName = [self.bowlerNames objectAtIndex: self.indexPathForTextField.row];
                [self.bowlerNames removeObjectAtIndex: self.indexPathForTextField.row];
                [self.bowlerNames insertObject: cell.textField.text
                                       atIndex: [self.alleyNames indexForAscendingStrings: cell.textField.text]];
                [self.menuTableView reloadSection: bPlayerSection];
                [self.historyManager updatePlayerName: bowlerName withNewName: cell.textField.text];
                [self.historyManager saveBowlrData];
            }
        }
    }
    
    self.indexPathForTextField = nil;
}

- (BOOL)checkForDuplicateAlley:(NSString *)alleyName
{
    if([self.historyManager alleyExists: alleyName])
    {
        [self alertDimViewAnimation];
        [self notifyAlertViewSetUpWithTitle: bDuplicateBowlrTitle
                                    message: bDuplicateBowlrMessage
                                     action: @selector(alertViewDismissAnimation)];
        [self alertViewPopUpAnimation: self.customAlert];
        return YES;
    }
    
    return NO;
}

- (BOOL)checkForDuplicatePlayer:(NSString *)playerName
{
    if([self.bowlerNames containsObject: playerName])
    {
        [self alertDimViewAnimation];
        [self notifyAlertViewSetUpWithTitle: bDuplicateBowlrTitle
                                    message: bDuplicateBowlrMessage
                                     action: @selector(alertViewDismissAnimation)];
        [self alertViewPopUpAnimation: self.customAlert];
        return YES;
    }
    
    return NO;
}

- (BOOL)checkForSelectedPlayers
{
    if([self.selectedBowlrs isEmpty])
    {
        [self alertDimViewAnimation];
        [self notifyAlertViewSetUpWithTitle: bSelectBowlrTitle
                                    message: bSelectBowlrMessage
                                     action: @selector(alertViewDismissAnimation)];
        [self alertViewPopUpAnimation: self.customAlert];
        return NO;
    }
    
    return YES;
}

#pragma - mark Alert Views

- (void)alertViewDeleteAlleyAction
{
    BLRAlleyCell *alleyCell = (BLRAlleyCell *)[self.menuTableView cellForRowAtIndexPath: self.indexPathToDelete];
    self.selectedAlley = ([self.selectedAlley isEqualToString: alleyCell.label.text]) ? nil : self.selectedAlley;
    [self.alleyNames removeObject: alleyCell.label.text];
    [self.historyManager removeAlleyName: alleyCell.label.text];
    [self.menuTableView deleteRow: self.indexPathToDelete];
    
    [self.historyManager saveAlleyData];
    [self alertViewDismissAnimation];
}

- (void)alertViewDeleteBowlrAction
{
    BLRMenuTableCell *playerCell = [self.menuTableView cellForRowAtIndexPath: self.indexPathToDelete];
    
    [self.bowlerNames removeObject: playerCell.label.text];
    [self.selectedBowlrs removeObject: playerCell.label.text];
    [self.historyManager removeHistoryBowlrWithName: playerCell.label.text];
    [self.menuTableView deleteRow: self.indexPathToDelete];

    [self.historyManager saveBowlrData];
    [self alertViewDismissAnimation];
}

#pragma - mark Screen Transitions

- (IBAction)startGameButtonAction
{
    [self startToPinScreen];
}

- (IBAction)historyButtonAction
{
    BLRHistoryMenuViewController *historyVC = [[BLRHistoryMenuViewController alloc] initWithNibName: bMenuVC
                                                                                             bundle: nil];
    [self.navigationController pushViewController: historyVC
                                         animated: NO];
}

- (IBAction)moreButtonAction
{
    BLRMoreMenuViewController *moreVC = [[BLRMoreMenuViewController alloc] initWithNibName: bMenuVC
                                                                                    bundle: nil];
    [self.navigationController pushViewController: moreVC
                                         animated:NO];
}

- (void)startToPinScreen
{
    if(self.menuTableView.isEditing)
    {
        [self.menuTableView setEditing: NO
                              animated: YES];
        return;
    }
    
    if(![self checkForSelectedPlayers])
    {
        return;
    }

    [self.gameManager setUpNewGame: [self.historyManager retrieveSelectedPlayers: self.selectedBowlrs]
                         alleyName: self.selectedAlley];
    
    BLRMainGameViewController *gameVC = [[BLRMainGameViewController alloc] initWithNibName: bMainGameScreenVC
                                                                                        bundle: nil
                                                                                   gameManager: self.gameManager
                                                                                stateProcessor: [[BLRStateProcessor alloc] init]];
    [self.navigationController pushViewController: gameVC
                                         animated: YES];
}

- (BOOL)shouldAutorotate
{
    return NO;
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

@end
