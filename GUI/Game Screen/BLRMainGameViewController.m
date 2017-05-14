//
//  BLRMainGameViewController.m
//  Bowlr
//
//  Created by Daniel Stewart on 3/14/17.
//  Copyright © 2017 Daniel Stewart. All rights reserved.
//

#import "BLRMainGameViewController.h"
#import "BLRGameHeaderViewController.h"
#import "BLRFrameWindowViewController.h"
#import "BLRPinViewController.h"
#import "BLRNumberPadViewController.h"
#import "AchievementsViewController.h"
#import "BLRGameSummaryViewController.h"
#import "BLRAchievementsManager.h"
#import "BLRAchievementBanner.h"
#import "UIView+CAAnimation.h"
#import "Game+Utils.h"
#import "BLREndGameButtonView.h"
@interface BLRMainGameViewController ()

@property (nonatomic, strong) BLRGameHeaderViewController *gameHeader;
@property (nonatomic, strong) BLRPinViewController *pinView;
@property (nonatomic, strong) BLRNumberPadViewController *numberPadView;
@property (nonatomic, strong) BLRFrameWindowViewController *frameWindow;

@property (weak, nonatomic) IBOutlet UIView *headerContentView;
@property (weak, nonatomic) IBOutlet UIView *pinPadContentView;
@property (weak, nonatomic) IBOutlet UIView *frameWindowContentView;
@property (strong, nonatomic) BLRAchievementBanner *achievementBanner;
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImage;
@property (weak, nonatomic) IBOutlet UIButton *editGameButton;
@property (weak, nonatomic) IBOutlet BLRButton *gameSummaryButton;
@property (strong, nonatomic) UIImageView *tutorialImage;

@end

@implementation BLRMainGameViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil
                         bundle:(NSBundle *)nibBundleOrNil
                    gameManager:(BLRGameManager *)gameManager
            achievementsManager:(BLRAchievementsManager *)achievementsManager
                 stateProcessor:(BLRStateProcessor *)stateProcessor
{
    self = [super initWithNibName: nibNameOrNil
                           bundle: nil
                      gameManager: gameManager
                   stateProcessor: stateProcessor];
    if(self)
    {
        self.achievementsManager = achievementsManager;
    }
    
    return self;
}

- (void)loadView
{
    [super loadView];
    
    self.gameHeader = [[BLRGameHeaderViewController alloc] initWithNibName: bGameHeaderVC
                                                                    bundle: nil
                                                               gameManager: self.gameManager
                                                            stateProcessor: self.attemptProcessor];
    
    [self.headerContentView addSubview: self.gameHeader.view];
    
    self.frameWindow = [[BLRFrameWindowViewController alloc] initWithNibName: bFrameWindowVC
                                                                      bundle: nil
                                                                 gameManager: self.gameManager
                                                              stateProcessor: self.attemptProcessor];
    
    [self.frameWindowContentView addSubview: self.frameWindow.view];
    
    self.pinView = [[BLRPinViewController alloc] initWithNibName: bPinsVC
                                                     gameManager: self.gameManager
                                                  stateProcessor: [BLRStateProcessor new]
                                                  headerDelegate: self.gameHeader
                                                   frameDelegate: self.frameWindow
                                               animationDelegate: self];
    
    self.gameHeader.pinViewDelegate = self.pinView;
    [self.pinPadContentView addSubview: self.pinView.view];
    
    self.numberPadView = [[BLRNumberPadViewController alloc] initWithNibName: bNumberPadVC
                                                                 gameManager: self.gameManager
                                                              stateProcessor: [BLRStateProcessor new]
                                                              headerDelegate: self.gameHeader
                                                               frameDelegate: self.frameWindow
                                                           animationDelegate: self];
    
    [self.pinPadContentView addSubview: self.numberPadView.view];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    Player *newPlayer = [[Player alloc] init];
    newPlayer.name = @"Daniel";
    newPlayer.currentGame = [[Game alloc] init];
    
    Player *nextPlayer = [[Player alloc] init];
    nextPlayer.name = @"Justice";
    nextPlayer.currentGame = [[Game alloc] init];
    
    Player *player = [[Player alloc] init];
    player.name = @"Nikki";
    player.currentGame = [[Game alloc] init];
    
    [self.gameManager.allBowlrs addObject: newPlayer];
    [self.gameManager.allBowlrs addObject: nextPlayer];
    [self.gameManager.allBowlrs addObject: player];
    
    self.gameManager.selectedBowlr = [self.gameManager.allBowlrs objectAtIndex: 0];
    self.gameManager.selectedFrame = [self.gameManager.selectedBowlr.currentGame.allFrames objectAtIndex: 0];
    self.gameManager.selectedAttempt = self.gameManager.selectedFrame.firstAttempt;

    [self displayPinTutorial: [[BLRHistoryManager sharedManager] loadPinTutorialSettings]];
    
    [self.gameSummaryButton setStandardView: [[BLREndGameButtonView alloc] initWithFrame: self.gameSummaryButton.frame
                                                                                   color: [UIColor BLRGameScreenButtonColor]]
                            highlightedView: [[BLREndGameButtonView alloc] initWithFrame: self.gameSummaryButton.frame
                                                                                   color: [UIColor BLRGameScreenHighlightedButtonColor]]];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear: animated];
    self.view.backgroundColor = [UIColor blackColor];
}

- (void)achievementBannerSetUp
{
    if(!self.achievementBanner)
    {
        self.achievementBanner = [[BLRAchievementBanner alloc] init];
        self.achievementBanner.center = CGPointMake(self.view.center.x, self.view.center.y);
    }
}

#pragma - mark Screen Transitions

- (IBAction)goToGameSummary
{
    [self setToGameSummaryPage];
}

- (void)setToGameSummaryPage
{
    BLRGameSummaryViewController *gameScreenVC = [[BLRGameSummaryViewController alloc] initWithNibName: bGameSummaryVC
                                                                                                bundle: nil
                                                                                           gameManager: self.gameManager
                                                                                        stateProcessor: [BLRStateProcessor new]];
    [self.navigationController pushViewController: gameScreenVC
                                         animated: YES];
}

- (void)clearTutorial
{
    [self.tutorialImage removeFromSuperview];
}

- (void)displayPinTutorial:(BOOL)notViewed
{
    if(notViewed)
    {
        [self.tutorialImage removeFromSuperview];
        return;
    }
    
    [self setUpTutorialImage: bTutorialPinsImage];
    [[BLRHistoryManager sharedManager] savePinTutorialSettings: YES];
}

- (void)displayPadTutorial:(BOOL)notViewed
{
    if(!notViewed)
    {
        [self setUpTutorialImage: bTutorialNumberPadImage];
        self.tutorialImage.alpha = 0.0;
        [[BLRHistoryManager sharedManager] savePadTutorialSettings: YES];
    }
}

- (void)setUpTutorialImage:(NSString *)tutorialImage
{
    self.tutorialImage = [[UIImageView alloc] initWithImage: [UIImage imageNamed: tutorialImage]];
    self.tutorialImage.frame = self.view.frame;
    [self.view addSubview: self.tutorialImage];
    self.tutorialImage.userInteractionEnabled = YES;
    [self.tutorialImage addGestureRecognizer: [[UITapGestureRecognizer alloc] initWithTarget: self
                                                                                      action: @selector(clearTutorial)]];
    [self.view bringSubviewToFront: self.tutorialImage];
}

- (IBAction)setToEditPage
{
    //[self gameScreenToEditScreen];
}

#pragma - mark Animations

- (void)animateToNumberPadScreen
{
    [self displayPadTutorial: [[BLRHistoryManager sharedManager] loadPadTutorialSettings]];
    [self animateGameView: self.numberPadView.view
            dismissedView: self.pinView.view
             optionalView: self.tutorialImage];
}

- (void)animateToPinScreen
{
    [self animateGameView: self.pinView.view
            dismissedView: self.numberPadView.view
             optionalView: nil];
}

- (void)animateGameView:(UIView *)appearingView
          dismissedView:(UIView *)dismissedView
           optionalView:(UIView *)optionalView
{
    [UIView animateWithDuration: 0.6
                          delay: 0
                        options: UIViewAnimationOptionCurveLinear
                     animations: ^{
                         appearingView.alpha = 1.0;
                         optionalView.alpha = 1.0;
                         dismissedView.alpha = 0.0;
                     }
                     completion: nil];
}

- (void)animationDidStop:(CAAnimation *)theAnimation
                finished:(BOOL)flag
{
    if (theAnimation == [[self.achievementBanner layer] animationForKey: @"animation"])
    {
        [self.achievementBanner removeFromSuperview];
        self.achievementBanner = nil;
        [self setToGameSummaryPage];
    }
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

@end
