//
//  BLRGameSummaryLineItemViewController.m
//  Bowlr
//
//  Created by Daniel Stewart on 4/9/17.
//  Copyright © 2017 Daniel Stewart. All rights reserved.
//

#import "BLRGameSummaryLineItemViewController.h"
#import "Game+Utils.h"

@interface BLRGameSummaryLineItemViewController ()

@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *scoreLabel;
@property (strong, nonatomic) IBOutlet UILabel *strikeLabel;
@property (strong, nonatomic) IBOutlet UILabel *spareLabel;
@property (strong, nonatomic) IBOutlet UILabel *openLabel;

@property (strong, nonatomic) Player *player;

@end

@implementation BLRGameSummaryLineItemViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil
                         bundle:(NSBundle *)nibBundleOrNil
                         player:(Player *)player
{
    self = [super initWithNibName: bGameSummaryLineItem
                           bundle:nil];
    if(self)
    {
        self.player = player;
    }
    
    return self;
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    if(!self.player)
    {
        [self populateWithTitles];
    }
    else
    {
        [self populateWithPlayerStats];
    }
}

- (void)populateWithPlayerStats
{
    self.nameLabel.text = self.player.name;
    [self.nameLabel setTextColor: [UIColor BLRGameSummaryTextColor]];
    self.scoreLabel.text = [NSString stringWithFormat: @"%i", self.player.currentGame.totalScore];
    self.strikeLabel.text = [NSString stringWithFormat: @"%i", [self.player.currentGame countStrikes]];
    self.spareLabel.text = [NSString stringWithFormat: @"%i", [self.player.currentGame countSpares]];
    self.openLabel.text = [NSString stringWithFormat: @"%i", [self.player.currentGame countOpenFrames]];
}

- (void)populateWithTitles
{
    [self.scoreLabel setTextColor: [UIColor BLRGameSummaryTextColor]];
    [self.strikeLabel setTextColor: [UIColor BLRGameSummaryTextColor]];
    [self.spareLabel setTextColor: [UIColor BLRGameSummaryTextColor]];
    [self.openLabel setTextColor: [UIColor BLRGameSummaryTextColor]];
}

@end
