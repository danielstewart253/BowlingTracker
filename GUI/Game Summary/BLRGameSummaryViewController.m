//
//  BLRGameSummaryViewController.h
//  Bowlr
//
//  Created by Daniel Stewart on 3/20/17.
//  Copyright (c) 2017 Daniel Stewart. All rights reserved.
//

#import "BLRGameSummaryViewController.h"
#import "BLRGameSummaryLineItemViewController.h"
#import "BLRBorderView.h"
#import "BLRCircledNumber.h"
#import "BLRBackButtonView.h"
#import "BLREndGameButtonView.h"
#import "Game+Utils.h"

@interface BLRGameSummaryViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *pendantImage;
@property (weak, nonatomic) IBOutlet BLRBorderView *contentView;
@property (weak, nonatomic) IBOutlet BLRButton *backButton;
@property (weak, nonatomic) IBOutlet BLRButton *endGameButton;

@property (strong, nonatomic) NSMutableArray *displayedPlayers;

@end

@implementation BLRGameSummaryViewController

#define BLR_CIRCLE_FRAME_WIDTH 22
#define BLR_LINE_ITEM_HEIGHT 45
#define BLR_VERTICAL_BUFFER 15

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.displayedPlayers = [self.gameManager.allBowlrs copy];
    
    [self.endGameButton setStandardView: [[BLREndGameButtonView alloc] initWithFrame: self.endGameButton.frame
                                                                               color: [UIColor BLRGameSummaryButtonColor]]
                        highlightedView: [[BLREndGameButtonView alloc] initWithFrame: self.endGameButton.frame
                                                                               color: [UIColor BLRGameSummaryHighlightedButtonColor]]];
    [self.backButton setStandardView: [[BLRBackButtonView alloc] initWithFrame: self.backButton.frame
                                                                               color: [UIColor BLRGameSummaryButtonColor]]
                        highlightedView: [[BLRBackButtonView alloc] initWithFrame: self.endGameButton.frame
                                                                               color: [UIColor BLRGameSummaryHighlightedButtonColor]]];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    [self layoutTitles];
    [self layoutPlayerLines];
    [self resizeContentView];
}

- (void)layoutTitles
{
    BLRGameSummaryLineItemViewController *lineItem = [[BLRGameSummaryLineItemViewController alloc] initWithNibName: bGameSummaryLineItem
                                                                                                            bundle: nil
                                                                                                            player: nil];
    CGRect frame = lineItem.view.frame;
    frame.origin.y = frame.origin.y - frame.size.height / 2;
    frame.size.width = self.contentView.frame.size.width;
    lineItem.view.frame = frame;
    lineItem.view.frame = [self.contentView convertRect: lineItem.view.frame toView: self.view];
    
    [self.view addSubview: lineItem.view];
}

- (void)layoutPlayerLines
{
    for(int i = 0; i < [self.displayedPlayers count]; i++)
    {
        BLRGameSummaryLineItemViewController *lineItem = [[BLRGameSummaryLineItemViewController alloc] initWithNibName: bGameSummaryLineItem
                                                                                                                bundle: nil
                                                                                                                player: [self.displayedPlayers objectAtIndex: i]];
        lineItem.view.frame = CGRectMake(lineItem.view.frame.origin.x, BLR_VERTICAL_BUFFER + lineItem.view.frame.size.height * i, self.contentView.frame.size.width, lineItem.view.frame.size.height);
        [self.contentView addSubview: lineItem.view];
        
        BLRCircledNumber *currentNumber = [[BLRCircledNumber alloc] initWithFrame: CGRectMake(0, 0, BLR_CIRCLE_FRAME_WIDTH, BLR_CIRCLE_FRAME_WIDTH)
                                                                  backgroundColor: [UIColor BLRGameSummaryBackgroundColor]
                                                                      strokeColor: [UIColor BLRGameSummaryTextColor]];
        currentNumber.center = CGPointMake(0, CGRectGetMidY(lineItem.view.frame));
        [currentNumber setText: [NSString stringWithFormat: @"%i", i + 1]];
        [currentNumber setTextColor: [UIColor BLRGameSummaryTextColor]];
        currentNumber.frame = [self.contentView convertRect: currentNumber.frame toView: self.view];
        [self.view addSubview: currentNumber];
    }
}

- (void)resizeContentView
{
    CGRect contentFrame = self.contentView.frame;
    contentFrame = CGRectMake(contentFrame.origin.x, contentFrame.origin.y, contentFrame.size.width, BLR_VERTICAL_BUFFER * 2 + [self.displayedPlayers count] * BLR_LINE_ITEM_HEIGHT);
    self.contentView.frame = contentFrame;
}

- (IBAction)backButtonAction
{
    [self.navigationController popToRootViewControllerAnimated: YES];
}

- (IBAction)endGameButtonAction
{
    [self.gameManager updateStatistics];
    [self updateBowlrGameHistory];
    [[BLRHistoryManager sharedManager] saveBowlrData];
    [[BLRHistoryManager sharedManager] saveGameIDNumber: [[BLRHistoryManager sharedManager] loadGameIDNumber] + 1];
    [self returnToMenu];
}

- (void)updateBowlrGameHistory
{
    for(Player *player in self.gameManager.allBowlrs)
    {
        [player.gameHistory.listOfGames addObject: player.currentGame];
        player.currentGame = nil;
    }
}

- (void)returnToMenu
{
    [UIView transitionWithView: self.navigationController.view
                      duration: 0.4
                       options: UIViewAnimationOptionTransitionCrossDissolve
                    animations: ^{[self.navigationController popToRootViewControllerAnimated: NO];}
                    completion: NULL];
}

@end
