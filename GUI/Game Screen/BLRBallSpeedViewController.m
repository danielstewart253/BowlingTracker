//
//  BLRBallSpeedViewController.m
//  Bowlr
//
//  Created by Daniel Stewart on 3/14/17.
//  Copyright © 2017 Daniel Stewart. All rights reserved.
//

#import "BLRBallSpeedViewController.h"

@interface BLRBallSpeedViewController ()

@property (weak, nonatomic) IBOutlet UIScrollView *leftDial;
@property (weak, nonatomic) IBOutlet UIScrollView *rightDial;

@end

@implementation BLRBallSpeedViewController

#define BLR_LEFT_DIAL_CONTENT_SIZE 1560
#define BLR_RIGHT_DIAL_CONTENT_SIZE 472
#define BLR_TOP_BUFFER 59.0
#define BLR_LABEL_WIDTH 25.0
#define BLR_LABEL_HEIGHT 35.0
#define BLR_LEFT_DIAL_BUFFER 22.0
#define BLR_DIAL_BUFFER 14.0
#define BLR_DIAL_ZERO_VALUE 0
#define BLR_TWO_DIGIT_OFFSET 7.0
#define BLR_SPEED_MAX 41
#define BLR_DECIMAL_MAX .9

- (instancetype)initWithNibName:(NSString *)nibNameOrNil
                         bundle:(NSBundle *)nibBundleOrNil
                    gameManager:(BLRGameManager *)gameManager
                 stateProcessor:(BLRStateProcessor *)stateProcessor
              ballSpeedDelegate:(id<BallSpeedSetterDelegate>)ballSpeedDelegate
{
    self = [super initWithNibName: nibNameOrNil
                           bundle: nil
                      gameManager: gameManager
                   stateProcessor: stateProcessor];
    if(self)
    {
        self.ballSpeedDelegate = ballSpeedDelegate;
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor clearColor];
    [self ballSpeedDialSetUp];
    [self.leftDial setDelegate: self];
    [self.rightDial setDelegate: self];
}

- (void)ballSpeedDialSetUp
{
    self.leftDial.contentSize = CGSizeMake(0.0, BLR_LEFT_DIAL_CONTENT_SIZE);
    [self.leftDial setContentOffset:CGPointMake(0.0, 0.0)];
    
    for(int i = 0; i < BLR_SPEED_MAX; i++)
    {
        UILabel *numberLabel = [[UILabel alloc]initWithFrame:CGRectMake(BLR_LEFT_DIAL_BUFFER, (BLR_TOP_BUFFER + i * BLR_LABEL_HEIGHT), BLR_LABEL_WIDTH, BLR_LABEL_HEIGHT)];
        numberLabel.font = [UIFont boldSystemFontOfSize: BLR_FONT_SIZE];
        NSString *string = [NSString stringWithFormat: @"%d", i];
        numberLabel.text = string;
        
        if(i > 9)
        {
            numberLabel.center = CGPointMake(numberLabel.center.x - BLR_TWO_DIGIT_OFFSET, numberLabel.center.y);
        }
        
        [self.leftDial addSubview: numberLabel];
    }
    
    self.rightDial.contentSize = CGSizeMake(0.0, BLR_RIGHT_DIAL_CONTENT_SIZE);
    
    for(int i = 0; i < 10; i++)
    {
        UILabel *numberLabel = [[UILabel alloc]initWithFrame:CGRectMake(BLR_DIAL_BUFFER, (BLR_TOP_BUFFER + i * BLR_LABEL_HEIGHT), BLR_LABEL_WIDTH, BLR_LABEL_HEIGHT)];
        numberLabel.font = [UIFont boldSystemFontOfSize: BLR_FONT_SIZE];
        NSString *string = [NSString stringWithFormat: @"%d", i];
        numberLabel.text = string;
        
        [self.rightDial addSubview: numberLabel];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat leftSpeed;
    CGFloat rightSpeed;
    
    int leftDialYOffset = self.leftDial.contentOffset.y + BLR_DIAL_BUFFER;
    
    leftSpeed = leftDialYOffset / 35;
    
    
    float rightDialYOffset = self.rightDial.contentOffset.y;
    
    if(rightDialYOffset < BLR_DIAL_ZERO_VALUE)
    {
        rightSpeed = BLR_DIAL_ZERO_VALUE;
    }
    else
    {
        rightDialYOffset = rightDialYOffset / BLR_LABEL_HEIGHT;
        rightSpeed = rightDialYOffset / 10;
        
        if(rightSpeed > BLR_DECIMAL_MAX)
        {
            rightSpeed = BLR_DECIMAL_MAX;
        }
    }
    
    self.gameManager.selectedAttempt.ballSpeedForAttempt = leftSpeed + rightSpeed;
    [self.ballSpeedDelegate setBallSpeedForButtonTitle];
}

@end
