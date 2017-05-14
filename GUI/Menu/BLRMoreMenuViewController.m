//
//  BLRMoreMenuViewController.m
//  Bowlr
//
//  Created by Daniel Stewart on 7/19/15.
//  Copyright (c) 2015 Daniel Stewart. All rights reserved.
//

#import "BLRMoreMenuViewController.h"
#import "AboutViewController.h"
#import "BLRHistoryManager.h"

@implementation BLRMoreMenuViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (BOOL)isHistoryButtonEnabled
{
    return YES;
}

- (BOOL)isMoreButtonEnabled
{
    return NO;
}

- (NSString *)titleForCellAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
            return bTellFriendMenuItem;
            break;
        case 1:
            return bTutorialMenuItem;
            break;
        case 2:
            return bReportBugMenuItem;
            break;
        case 3:
            return bMakeSuggestionMenuItem;
            break;
        case 4:
            return bAboutMenuItem;
            break;
        default:
            return nil;
    }
}

// Selection of any cell will open web browser to the specified website
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath: indexPath animated: NO];
    
    switch(indexPath.row)
    {
        case 0:
            [self shareBowlr];
            break;
        case 1:
            [self handleTutorial];
            break;
        case 2:
            [self createEmail: bReportBugTitle message: bReportBugMessage];
            break;
        case 3:
            [self createEmail: bSuggestionTitle message: bSuggestionMessage];
            break;
        case 4:
            [self navigateToAboutViewController];
            break;
        default:
            break;
    }
}

// Returns the number of rows for each section
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

- (void)handleTutorial
{    
    if([[BLRHistoryManager sharedManager] loadPinTutorialSettings])
    {
        [self alertDimViewAnimation];
        [self notifyAlertViewSetUpWithTitle: bTutorialTitle
                                    message: bTutorialMessage
                                     action: @selector(alertViewDismissAnimation)];
        [self alertViewPopUpAnimation: self.customAlert];
        [[BLRHistoryManager sharedManager] savePinTutorialSettings: YES];
        [[BLRHistoryManager sharedManager] savePadTutorialSettings: YES];
    }
}

// The shareButton action
- (void)shareBowlr
{
    NSArray *activityItems;
    
    activityItems = @[bShareBowlrText];
    
    UIActivityViewController *activityViewController = [[UIActivityViewController alloc] initWithActivityItems: activityItems applicationActivities: nil];
    
    [self presentViewController: activityViewController animated: YES completion: NULL];
}

- (void)createEmail:(NSString *)subject message:(NSString *)message
{
    if([MFMailComposeViewController canSendMail])
    {
        MFMailComposeViewController *mail = [[MFMailComposeViewController alloc] init];
        mail.mailComposeDelegate = self;
        [mail setToRecipients: [NSArray arrayWithObject: bBowlrEmail]];
        [mail setSubject: subject];
        [mail setMessageBody: message isHTML: NO];
        if(mail)
        {
            [self presentViewController: mail animated: YES completion: nil];
        }
    }
    else
    {
        [self displayEmailFailedAlertView];
    }
}

- (void)displayEmailFailedAlertView
{
    [self alertDimViewAnimation];
    [self notifyAlertViewSetUpWithTitle: bEmailFailureTitle
                                message: bEmailFailureMessage
                                 action: @selector(alertViewDismissAnimation)];
    [self alertViewPopUpAnimation: self.customAlert];
}

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    [self dismissViewControllerAnimated: YES completion: nil];
}

- (void)navigateToAboutViewController
{
    AboutViewController *aboutScreen = [[AboutViewController alloc]initWithNibName: bAboutVC bundle: nil];
    [self.navigationController pushViewController: aboutScreen animated: YES];
}

@end

