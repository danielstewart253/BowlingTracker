//
//  StatCardViewController.m
//  Bowlr
//
//  Created by Daniel Stewart on 12/9/14.
//  Copyright (c) 2014 Daniel Stewart. All rights reserved.
//

#import "StatCardViewController.h"

@interface StatCardViewController ()

@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (weak, nonatomic) IBOutlet UIImageView *statPendantImage;

@property (weak, nonatomic) IBOutlet UIView *statContentView;
@property (weak, nonatomic) IBOutlet UIScrollView *statScroller;
@property (weak, nonatomic) IBOutlet UILabel *pinfallTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *scoreTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *highScoreTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *lowScoreTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *openFramesTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *strikesTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *sparesTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *splitsTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *conversionsTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *guttersTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *foulsTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *firstPinfallTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *firstBallSpeedTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *secondBallSpeedTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *gamesTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *winsTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *lossesTitleLabel;

@property (weak, nonatomic) IBOutlet UILabel *pinfallTotalLabel;
@property (weak, nonatomic) IBOutlet UILabel *highScoreTotalLabel;
@property (weak, nonatomic) IBOutlet UILabel *lowScoreTotalLabel;
@property (weak, nonatomic) IBOutlet UILabel *openFramesTotalLabel;
@property (weak, nonatomic) IBOutlet UILabel *strikesTotalLabel;
@property (weak, nonatomic) IBOutlet UILabel *sparesTotalLabel;
@property (weak, nonatomic) IBOutlet UILabel *splitsTotalLabel;
@property (weak, nonatomic) IBOutlet UILabel *conversionsTotalLabel;
@property (weak, nonatomic) IBOutlet UILabel *guttersTotalLabel;
@property (weak, nonatomic) IBOutlet UILabel *foulsTotalLabel;
@property (weak, nonatomic) IBOutlet UILabel *gamesTotalLabel;
@property (weak, nonatomic) IBOutlet UILabel *winsTotalLabel;
@property (weak, nonatomic) IBOutlet UILabel *lossesTotalLabel;

@property (weak, nonatomic) IBOutlet UILabel *pinfallAverageLabel;
@property (weak, nonatomic) IBOutlet UILabel *scoreAverageLabel;
@property (weak, nonatomic) IBOutlet UILabel *openFramesAverageLabel;
@property (weak, nonatomic) IBOutlet UILabel *strikesAverageLabel;
@property (weak, nonatomic) IBOutlet UILabel *sparesAverageLabel;
@property (weak, nonatomic) IBOutlet UILabel *splitsAverageLabel;
@property (weak, nonatomic) IBOutlet UILabel *conversionsAverageLabel;
@property (weak, nonatomic) IBOutlet UILabel *guttersAverageLabel;
@property (weak, nonatomic) IBOutlet UILabel *foulsAverageLabel;
@property (weak, nonatomic) IBOutlet UILabel *firstPinfallAverageLabel;
@property (weak, nonatomic) IBOutlet UILabel *firstBallSpeedAverageLabel;
@property (weak, nonatomic) IBOutlet UILabel *secondBallSpeedAverageLabel;


@end

@implementation StatCardViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    //[self.statScroller setContentSize:self.statContentView.frame.size];
    [self.statScroller setContentSize:self.statContentView.frame.size];
    [self.statScroller addSubview:self.statContentView];
    
    UIView *statBorder = [[UIView alloc]init];
    
    // Set up view for 4-inch screen
    if ([[UIScreen mainScreen] bounds].size.height == 568)
    {
        // Setup the border UIView
        statBorder.frame = CGRectMake(0.0, 0.0, 287.0, 383.0);
        statBorder.center = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2 + 6.0);
        statBorder.backgroundColor = [UIColor clearColor];
        [statBorder.layer setCornerRadius:13.25f];
        [statBorder.layer setBorderColor:[[UIColor alloc]initWithRed:102.0/255.0 green:127.0/255.0 blue:59.0/255.0 alpha:1.0].CGColor];
        [statBorder.layer setBorderWidth:3.75f];
        [self.view addSubview:statBorder];
        [self.view sendSubviewToBack:statBorder];
        
        // Setup the total/average UILabel
        UILabel *totalAverage = [[UILabel alloc]initWithFrame:CGRectMake(180.0, 0.0, 78.0, 25.0)];
        totalAverage.center = CGPointMake(246.0, 98.0);
        totalAverage.text = @"Total   Avg.";
        totalAverage.textColor = [[UIColor alloc]initWithRed:102.0/255.0 green:127.0/255.0 blue:59.0/255.0 alpha:1.0];
        totalAverage.backgroundColor = [[UIColor alloc]initWithRed:164.0/255.0 green:164.0/255.0 blue:59.0/255.0 alpha:1.0];
        totalAverage.font = [UIFont boldSystemFontOfSize:14.0];
        totalAverage.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:totalAverage];
    }
    
    // Only set selectedPlayer to first Player in historyOfAllBowlrs array if the array is not empty
    if([self.historyOfAllBowlrs count] > 0)
        selectedPlayer = [self.historyOfAllBowlrs objectAtIndex:0];
   // [self adjustStatisticsToPlayer];
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

// Adjusts all statistics labels to the selected Player of the nameDial
- (void)adjustStatisticsToPlayer
{    
//    // Set all labels to the newly selectedPlayer
//    self.pinfallTotalLabel.text = [NSString stringWithFormat:@"%.0f", selectedPlayer.totalPinfall];
//    self.pinfallAverageLabel.text = [NSString stringWithFormat:@"%.1f", selectedPlayer.averagePinfall];
//    if(selectedPlayer.totalGames == 0)
//    {
//        self.scoreAverageLabel.text = @"0.0";
//        self.highScoreTotalLabel.text = @"0";
//        self.lowScoreTotalLabel.text = @"0";
//        //openFramesTotalLabel.text = @"0%";
//    }
//    else
//    {
//        self.scoreAverageLabel.text = [NSString stringWithFormat:@"%.1f", selectedPlayer.totalScore/selectedPlayer.totalGames];
//        self.highScoreTotalLabel.text = [NSString stringWithFormat:@"%.0f", selectedPlayer.highScore];
//        self.lowScoreTotalLabel.text = [NSString stringWithFormat:@"%.0f", selectedPlayer.lowScore];
//        //openFramesTotalLabel.text = [NSString stringWithFormat:@"%.0f%%", ((selectedPlayer.totalOpenFrames/(selectedPlayer.totalGames * 10)) * 100)];
//    }
//    
//    self.openFramesTotalLabel.text = [NSString stringWithFormat:@"%.0f", selectedPlayer.totalOpenFrames];
//    
//    self.openFramesAverageLabel.text = [NSString stringWithFormat:@"%.1f",selectedPlayer.averageOpenFrames];
//    self.strikesTotalLabel.text = [NSString stringWithFormat:@"%.0f", selectedPlayer.totalStrikes];
//    self.strikesAverageLabel.text = [NSString stringWithFormat:@"%.1f", selectedPlayer.averageStrikes];
//    self.sparesTotalLabel.text = [NSString stringWithFormat:@"%.0f", selectedPlayer.totalSpares];
//    self.sparesAverageLabel.text = [NSString stringWithFormat:@"%.1f", selectedPlayer.averageSpares];
//    self.splitsTotalLabel.text = [NSString stringWithFormat:@"%.0f", selectedPlayer.totalSplits];
//    self.splitsAverageLabel.text = [NSString stringWithFormat:@"%.1f", selectedPlayer.averageSplits];
//    self.conversionsTotalLabel.text = [NSString stringWithFormat:@"%.0f",selectedPlayer.totalSplitConversions];
//    self.conversionsAverageLabel.text = [NSString stringWithFormat:@"%.1f", selectedPlayer.averageSplitConversions];
//    self.guttersTotalLabel.text = [NSString stringWithFormat:@"%.0f", selectedPlayer.totalGutterBalls];
//    self.guttersAverageLabel.text = [NSString stringWithFormat:@"%.1f", selectedPlayer.averageGutterBalls];
//    self.foulsTotalLabel.text = [NSString stringWithFormat:@"%.0f", selectedPlayer.totalFouls];
//    self.foulsAverageLabel.text = [NSString stringWithFormat:@"%.1f", selectedPlayer.averageFouls];
//    self.firstPinfallAverageLabel.text = [NSString stringWithFormat:@"%.1f", selectedPlayer.averageFirstBallPinfall];
//    
//    //Check for averages that might be divided by 0
//    if(isnan(selectedPlayer.averageFirstBallSpeed))
//    {
//        self.firstBallSpeedAverageLabel.text = @"0.0";
//    }
//    else
//    {
//        self.firstBallSpeedAverageLabel.text = [NSString stringWithFormat:@"%.1f", selectedPlayer.averageFirstBallSpeed];
//    }
//    if(isnan(selectedPlayer.averageSecondBallSpeed))
//    {
//        self.secondBallSpeedAverageLabel.text = @"0.0";
//    }
//    else
//    {
//        self.secondBallSpeedAverageLabel.text = [NSString stringWithFormat:@"%.1f", selectedPlayer.averageSecondBallSpeed];
//    }
//    
//    self.gamesTotalLabel.text = [NSString stringWithFormat:@"%.0f", selectedPlayer.totalGames];
//    self.winsTotalLabel.text = [NSString stringWithFormat:@"%.0f", selectedPlayer.totalWins];
//    self.lossesTotalLabel.text = [NSString stringWithFormat:@"%.0f", selectedPlayer.totalLosses];
}

//Returns to History menu screen
- (IBAction)backButtonAction:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
