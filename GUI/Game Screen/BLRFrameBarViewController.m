//
//  BLRFrameBarViewController.m
//  Bowlr
//
//  Created by Daniel Stewart on 3/14/17.
//  Copyright © 2017 Daniel Stewart. All rights reserved.
//

#import "BLRFrameBarViewController.h"

@interface BLRFrameBarViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *currentFramePendant;
@property (weak, nonatomic) IBOutlet UIImageView *nextFramePendant;
@property (weak, nonatomic) IBOutlet UIImageView *previousFramePendant;
@property (strong, nonatomic) NSMutableArray *frameImages;

@end

#define BLR_PREVIOUS_FRAME_BOUNDARY (self.view.frame.size.width / 2 - 50)
#define BLR_NEXT_FRAME_BOUNDARY (self.view.frame.size.width / 2 + 50)
#define BLR_LEFT_INNTER_BOUNDARY (self.view.frame.size.width / 2 - 85)
#define BLR_RIGHT_INNTER_BOUNDARY (self.view.frame.size.width / 2 + 85)
#define BLR_RIGHT_OUTER_BOUNDARY (self.view.frame.size.width / 2 + 120)
#define BLR_LEFT_OUTER_BOUNDARY (self.view.frame.size.width / 2 - 120)
#define BLR_VIEW_CENTER self.view.frame.size.width / 2
#define BLR_CURRENT_FRAME_CENTER self.view.frame.size.width/2 - 3
#define BLR_NEXT_FRAME_CENTER self.view.frame.size.width + 80
#define BLR_LAST_FRAME_CENTER -80

static double animationSpeedHigh = .225;
static double animationSpeedMedium = .250;
static double animationSpeedLow = .275;

CGPoint startLocation;

@implementation BLRFrameBarViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initializeFrameImages];
}

- (void)hideOffScreenFramePendants
{
    self.previousFramePendant.hidden = YES;
    self.nextFramePendant.hidden = YES;
}

#pragma - mark Touch Delegate Methods
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [[event allTouches] anyObject];
    if([touch view] == self.currentFramePendant)
    {
        self.nextFramePendant.hidden = NO;
        self.previousFramePendant.hidden = NO;
        
        CGPoint touchPoint = [[touches anyObject] locationInView: self.currentFramePendant];
        startLocation = touchPoint;
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [[event allTouches] anyObject];
    if([touch view] == self.currentFramePendant)
    {
        CGPoint touchPoint = [[touches anyObject] previousLocationInView: self.currentFramePendant];
        CGFloat currentFramedx = touchPoint.x - startLocation.x;
        
        self.currentFramePendant.center = [self updateCurrentFrameCenterBy: currentFramedx];
        if([self.gameManager isNotSelectedFrameNumber: bFrameNumberTen])
        {
            self.nextFramePendant.center = [self updateNextFrameCenterBy: currentFramedx];
        }
        
        if([self.gameManager isNotSelectedFrameNumber: bFrameOneIndex])
        {
            self.previousFramePendant.center = [self updatePreviousFrameCenterBy: currentFramedx];
        }
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [[event allTouches] anyObject];
    if([touch view] != self.currentFramePendant)
    {
        return;
    }
    
    [self handleFrameAnimationForLastTouchPoint: [touch locationInView: self.view]];
}

#pragma - mark Frame Pendant Animation Methods

- (void)handleFrameAnimationForLastTouchPoint:(CGPoint)touchPoint
{
    if(touchPoint.x < BLR_VIEW_CENTER && (touchPoint.x > BLR_PREVIOUS_FRAME_BOUNDARY || [self.gameManager isSelectedFrameNumber: bFrameNumberTen]))
    {
        [self nextFrameCancelAnimation];
    }
    else if(touchPoint.x <= BLR_PREVIOUS_FRAME_BOUNDARY)
    {
        if([self.gameManager isNotSelectedFrameNumber: bFrameNumberTen] && touchPoint.x > BLR_LEFT_INNTER_BOUNDARY)
        {
            [self nextFrameWithAnimation:animationSpeedLow];
        }
        else if([self.gameManager isNotSelectedFrameNumber: bFrameNumberTen] && touchPoint.x > BLR_LEFT_OUTER_BOUNDARY)
        {
            [self nextFrameWithAnimation: animationSpeedMedium];
        }
        else
        {
            [self nextFrameWithAnimation: animationSpeedHigh];
        }
    }
    else if(touchPoint.x > BLR_VIEW_CENTER && (touchPoint.x < BLR_NEXT_FRAME_BOUNDARY || [self.gameManager isSelectedFrameNumber: bFrameNumberOne]))
    {
        [self previousFrameCancelAnimation];
    }
    else if(touchPoint.x >= BLR_NEXT_FRAME_BOUNDARY)
    {
        if([self.gameManager isNotSelectedFrameNumber: bFrameNumberOne] && touchPoint.x < BLR_RIGHT_INNTER_BOUNDARY)
        {
            [self previousFrameWithAnimation:animationSpeedLow];
        }
        else if([self.gameManager isNotSelectedFrameNumber: bFrameNumberOne] && touchPoint.x < BLR_RIGHT_OUTER_BOUNDARY)
        {
            [self previousFrameWithAnimation: animationSpeedMedium];
        }
        else
        {
            [self previousFrameWithAnimation: animationSpeedHigh];
        }
    }
}

// Returns Frame Pendants to their original position
- (void)nextFrameCancelAnimation
{
    [UIView animateWithDuration: animationSpeedMedium
                          delay: 0
                        options: UIViewAnimationOptionCurveLinear
                     animations: ^{
                         self.currentFramePendant.center = [self currentFrameCenter];
                         self.nextFramePendant.center = [self nextFrameCenter];
                     }completion: ^(BOOL finished){
                         [self hideOffScreenFramePendants];
                     }];
}

// Returns Frame Pendants to their original position
- (void)previousFrameCancelAnimation
{
    [UIView animateWithDuration: animationSpeedMedium
                          delay: 0
                        options: UIViewAnimationOptionCurveLinear
                     animations: ^{
                         self.currentFramePendant.center = [self currentFrameCenter];
                         self.previousFramePendant.center = [self previousFrameCenter];
                     }completion:^(BOOL finished) {
                         [self hideOffScreenFramePendants];
                     }];
}

// Moves Frame Pendants to the left
- (void)nextFrameWithAnimation:(double)duration
{
    self.nextFramePendant.hidden = NO;
    [UIView animateWithDuration: duration
                          delay: 0
                        options: UIViewAnimationOptionCurveLinear
                     animations: ^{
                         self.currentFramePendant.center = [self previousFrameCenter];
                         self.nextFramePendant.center = [self currentFrameCenter];
                     }completion:^(BOOL finished) {
                         [self.gameManager setToNextFrame];
                         [self changePositionOfFramePendants];
                         [self setFramePendantImages];
                         [[NSNotificationCenter defaultCenter] postNotificationName: bUpdateGameInterface
                                                                             object: nil];
                     }];
}

// Moves Frame Pendants to the right
- (void)previousFrameWithAnimation:(double)duration
{
    self.previousFramePendant.hidden = NO;
    [UIView animateWithDuration: duration
                          delay: 0
                        options: UIViewAnimationOptionCurveLinear
                     animations: ^{
                         self.previousFramePendant.center = [self currentFrameCenter];
                         self.currentFramePendant.center = [self nextFrameCenter];
                     }completion: ^(BOOL finished) {
                         [self.gameManager setToPreviousFrame];
                         [self changePositionOfFramePendants];
                         [self setFramePendantImages];
                         [[NSNotificationCenter defaultCenter] postNotificationName: bUpdateGameInterface
                                                                             object: nil];
                     }];
}

#pragma -mark Frame Pendant Position Methods

- (void)changePositionOfFramePendants
{
    [self setFramePendantImages];
    self.currentFramePendant.center = [self currentFrameCenter];
    self.nextFramePendant.center = [self nextFrameCenter];
    self.previousFramePendant.center = [self previousFrameCenter];
    [self hideOffScreenFramePendants];
}

- (CGPoint)currentFrameCenter
{
    return CGPointMake(BLR_CURRENT_FRAME_CENTER, self.currentFramePendant.center.y);
}

- (CGPoint)nextFrameCenter
{
    return CGPointMake(BLR_NEXT_FRAME_CENTER, self.nextFramePendant.center.y);
}

- (CGPoint)previousFrameCenter
{
    return CGPointMake(BLR_LAST_FRAME_CENTER, self.previousFramePendant.center.y);
}

- (CGPoint)updateCurrentFrameCenterBy:(CGFloat)increment
{
    return CGPointMake(self.currentFramePendant.center.x + increment, self.currentFramePendant.center.y);
}

- (CGPoint)updateNextFrameCenterBy:(CGFloat)increment
{
    return CGPointMake(self.nextFramePendant.center.x + increment, self.currentFramePendant.center.y);
}

- (CGPoint)updatePreviousFrameCenterBy:(CGFloat)increment
{
    return CGPointMake(self.previousFramePendant.center.x + increment, self.currentFramePendant.center.y);
}

#pragma - mark Frame Image Methods

- (void)initializeFrameImages
{
    self.frameImages = [NSMutableArray new];
    
    for(int i = 1; i < 11; i++)
    {
        NSString *frameImageName = [NSString stringWithFormat: @"Frame%i.png", i];
        [self.frameImages addObject: [UIImage imageNamed: frameImageName]];
    }
}

- (void)setFramePendantImages
{
    [self updateCurrentFrameImage];
    [self updatePreviousFrameImage];
    [self updateNextFrameImage];
}

- (int)currentFrameImageIndex
{
    return self.gameManager.selectedFrame.frameNumber - 1;
}

- (int)previousFrameImageIndex
{
    return self.gameManager.selectedFrame.frameNumber - 2;
}

- (int)nextFrameImageIndex
{
    return self.gameManager.selectedFrame.frameNumber;
}

- (void)updateCurrentFrameImage
{
    [self.currentFramePendant setImage: [self.frameImages objectAtIndex: [self currentFrameImageIndex]]];
}

- (void)updatePreviousFrameImage
{
    if([self.gameManager isNotSelectedFrameNumber: bFrameNumberOne])
    {
        [self.previousFramePendant setImage: [self.frameImages objectAtIndex: [self previousFrameImageIndex]]];
    }
}

- (void)updateNextFrameImage
{
    if([self.gameManager isNotSelectedFrameNumber: bFrameNumberTen])
    {
        [self.nextFramePendant setImage: [self.frameImages objectAtIndex: [self nextFrameImageIndex]]];
    }
}

@end
