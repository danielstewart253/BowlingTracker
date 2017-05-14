//
//  BLRLandscapeStatcardViewController.m
//  Bowlr
//
//  Created by Daniel Stewart on 4/12/17.
//  Copyright © 2017 Daniel Stewart. All rights reserved.
//

#import "BLRLandscapeStatcardViewController.h"
#import "BLRLandscapeStatcardView.h"
#import "BLRStatcardValueLabel.h"

@interface BLRLandscapeStatcardViewController ()

@property (weak, nonatomic) IBOutlet UIView *pinfallContainer;
@property (weak, nonatomic) IBOutlet UIView *scoreContainer;
@property (weak, nonatomic) IBOutlet UIView *highScoreContainer;
@property (weak, nonatomic) IBOutlet UIView *lowScoreContainer;
@property (weak, nonatomic) IBOutlet UIView *openFramesContainer;
@property (weak, nonatomic) IBOutlet UIView *strikesContainer;
@property (weak, nonatomic) IBOutlet UIView *sparesContainer;
@property (weak, nonatomic) IBOutlet UIView *splitsContainer;
@property (weak, nonatomic) IBOutlet UIView *conversionsContainer;
@property (weak, nonatomic) IBOutlet UIView *gutterContainer;
@property (weak, nonatomic) IBOutlet UIView *foulsContainer;
@property (weak, nonatomic) IBOutlet UIView *firstPinfallContainer;
@property (weak, nonatomic) IBOutlet UIView *firstBallspeedContainer;
@property (weak, nonatomic) IBOutlet UIView *secondBallspeedContainer;
@property (weak, nonatomic) IBOutlet UIView *gamesContainer;
@property (weak, nonatomic) IBOutlet UIView *winsContainer;
@property (weak, nonatomic) IBOutlet UIView *lossesContainer;

@end

@implementation BLRLandscapeStatcardViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    BLRLandscapeStatcardView *pinfall = [[BLRLandscapeStatcardView alloc] initWithTitle: @"Pinfall" total: 0 average: 0];
    [self.pinfallContainer addSubview: pinfall];
    
    BLRLandscapeStatcardView *score = [[BLRLandscapeStatcardView alloc] initWithTitle: @"Score" total: 0 average: 0];
    [self.scoreContainer addSubview: score];
    
    BLRLandscapeStatcardView *highScore = [[BLRLandscapeStatcardView alloc] initWithTitle: @"High Score" total: 0 average: 0];
    [self.highScoreContainer addSubview: highScore];
    
    BLRLandscapeStatcardView *lowScore = [[BLRLandscapeStatcardView alloc] initWithTitle: @"Low Score" total: 0 average: 0];
    [self.lowScoreContainer addSubview: lowScore];
    
    BLRLandscapeStatcardView *openFrames = [[BLRLandscapeStatcardView alloc] initWithTitle: @"Open Frames" total: 0 average: 0];
    [self.openFramesContainer addSubview: openFrames];
    
    BLRLandscapeStatcardView *strikes = [[BLRLandscapeStatcardView alloc] initWithTitle: @"Strikes" total: 0 average: 0];
    [self.strikesContainer addSubview: strikes];
    
    BLRLandscapeStatcardView *spares = [[BLRLandscapeStatcardView alloc] initWithTitle: @"Spares" total: 0 average: 0];
    [self.sparesContainer addSubview: spares];
    
    BLRLandscapeStatcardView *splits = [[BLRLandscapeStatcardView alloc] initWithTitle: @"Splits" total: 0 average: 0];
    [self.splitsContainer addSubview: splits];
    
    BLRLandscapeStatcardView *conversions = [[BLRLandscapeStatcardView alloc] initWithTitle: @"Split Conversions" total: 0 average: 0];
    [self.conversionsContainer addSubview: conversions];
    
    BLRLandscapeStatcardView *gutter = [[BLRLandscapeStatcardView alloc] initWithTitle: @"Gutter Balls" total: 0 average: 0];
    [self.gutterContainer addSubview: gutter];
    
    BLRLandscapeStatcardView *fouls = [[BLRLandscapeStatcardView alloc] initWithTitle: @"Fouls" total: 0 average: 0];
    [self.foulsContainer addSubview: fouls];
    
    BLRLandscapeStatcardView *firstPinfall = [[BLRLandscapeStatcardView alloc] initWithTitle: @"1st Ball Pinfall" total: 0 average: 0];
    [self.firstPinfallContainer addSubview: firstPinfall];
    
    BLRLandscapeStatcardView *firstBallspeed = [[BLRLandscapeStatcardView alloc] initWithTitle: @"1st Ball Speed" total: 0 average: 0];
    [self.firstBallspeedContainer addSubview: firstBallspeed];
    
    BLRLandscapeStatcardView *secondBallspeed = [[BLRLandscapeStatcardView alloc] initWithTitle: @"2nd Ball Speed" total: 0 average: 0];
    [self.secondBallspeedContainer addSubview: secondBallspeed];
    
    BLRLandscapeStatcardView *games = [[BLRLandscapeStatcardView alloc] initWithTitle: @"Games" total: 0 average: 0];
    [self.gamesContainer addSubview: games];
    
    BLRLandscapeStatcardView *wins = [[BLRLandscapeStatcardView alloc] initWithTitle: @"Total Wins" total: 0 average: 0];
    [self.winsContainer addSubview: wins];
    
    BLRLandscapeStatcardView *losses = [[BLRLandscapeStatcardView alloc] initWithTitle: @"Total Losses" total: 0 average: 0];
    [self.lossesContainer addSubview: losses];
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return UIInterfaceOrientationLandscapeLeft;
}



@end
