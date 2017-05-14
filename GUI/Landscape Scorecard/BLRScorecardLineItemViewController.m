//
//  BLRScorecardLineItemViewController.m
//  Bowlr
//
//  Created by Daniel Stewart on 4/2/17.
//  Copyright © 2017 Daniel Stewart. All rights reserved.
//

#import "BLRScorecardLineItemViewController.h"
#import "BLRSingleFrameViewController.h"
#import "BLRTenthFrameViewController.h"

@interface BLRScorecardLineItemViewController ()

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIView *frame1Container;
@property (weak, nonatomic) IBOutlet UIView *frame2Container;
@property (weak, nonatomic) IBOutlet UIView *frame3Container;
@property (weak, nonatomic) IBOutlet UIView *frame4Container;
@property (weak, nonatomic) IBOutlet UIView *frame5Container;
@property (weak, nonatomic) IBOutlet UIView *frame6Container;
@property (weak, nonatomic) IBOutlet UIView *frame7Container;
@property (weak, nonatomic) IBOutlet UIView *frame8Container;
@property (weak, nonatomic) IBOutlet UIView *frame9Container;
@property (weak, nonatomic) IBOutlet UIView *frame10Container;
@property (weak, nonatomic) IBOutlet UILabel *gameScoreLabel;

@property (strong, nonnull) Player *currentPlayer;

@end

@implementation BLRScorecardLineItemViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil
                         bundle:(NSBundle *)nibBundleOrNil
                         player:(Player *)player
{
    self = [super initWithNibName: nibNameOrNil
                           bundle: nibBundleOrNil];
    if(self)
    {
        self.currentPlayer = player;
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)populateScorecardLine
{
    self.nameLabel.text = self.currentPlayer.name;
    for(int i = 0; i < [self.allFrames count] - 1; i++)
    {
        UIView *frame = [self.allFrames objectAtIndex: i];
        BLRSingleFrameViewController *singleFrame = [[BLRSingleFrameViewController alloc] initWithNibName: bSingleFrameVC
                                                                                                   bundle: nil
                                                                                                    frame: [self.currentPlayer.currentGame.allFrames objectAtIndex: i]];
        [frame addSubview: singleFrame.view];
    }
    
    UIView *tenthFrameContainer = [self.allFrames lastObject];
    BLRTenthFrameViewController *finalFrame = [[BLRTenthFrameViewController alloc] initWithNibName: bTenthFrameVC
                                                                                            bundle: nil
                                                                                             frame: [self.currentPlayer.currentGame.allFrames lastObject]];
    [tenthFrameContainer addSubview: finalFrame.view];
}

- (void)adjustWidth:(CGFloat)width
{
    CGRect frame = self.view.frame;
    frame.size.width = width;
    self.view.frame = frame;
}

@end
