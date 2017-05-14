//
//  BLRConstants.h
//  Bowlr
//
//  Created by Daniel Stewart on 12/10/14.
//  Copyright (c) 2014 Daniel Stewart. All rights reserved.
//

#import <Foundation/Foundation.h>

#define BLR_FONT_SIZE 19.0f
#define BLR_MIN_SCORE 0
#define BLR_NO_ATTEMPT_SCORE 0
#define BLR_GUTTER_SCORE 0
#define BLR_FOUL_SCORE 0
#define BLR_MISS_SCORE 0
#define BLR_STRIKE_SCORE 10
#define BLR_ATTEMPT_MAX_SCORE 10

static int bFrameOneIndex = 0;
static int bFrameTwoIndex = 1;
static int bFrameThreeIndex = 2;
static int bFrameFourIndex = 3;
static int bFrameFiveIndex = 4;
static int bFrameSixIndex = 5;
static int bFrameSevenIndex = 6;
static int bFrameEightIndex = 7;
static int bFrameNineIndex = 8;
static int bFrameTenIndex = 9;

static int bFrameNumberOne = 1;
static int bFrameNumberTwo = 2;
static int bFrameNumberThree = 3;
static int bFrameNumberFour = 4;
static int bFrameNumberFive = 5;
static int bFrameNumberSix = 6;
static int bFrameNumberSeven = 7;
static int bFrameNumberEight = 8;
static int bFrameNumberNine = 9;
static int bFrameNumberTen = 10;

typedef NS_ENUM(NSInteger, BLRPinState)
{
    BLRPinStateUp,
    BLRPinStateDown
};

typedef NS_ENUM(NSInteger, BLRCurrentAttempt)
{
    BLRCurrentAttemptFirst,
    BLRCurrentAttemptSecond,
    BLRCurrentAttemptThird
};

typedef NS_ENUM(NSUInteger, BLRAttemptResult)
{
    BLRAttemptResultPointsRecorded,
    BLRAttemptResultStrike,
    BLRAttemptResultSpare,
    BLRAttemptResultGutter,
    BLRAttemptResultSplit,
    BLRAttemptResultSplitConverted,
    BLRAttemptResultFoul,
    BLRAttemptResultMiss,
    BLRAttemptResultNoAttempt
};

typedef NS_ENUM(NSUInteger, BLRFrameResult)
{
    BLRFrameResultOpenFrame,
    BLRFrameResultStrike,
    BLRFrameResultSpare,
    BLRFrameResultNoAttempt
};

typedef NS_ENUM(NSUInteger, BLRGameResult)
{
    BLRGameResultWin,
    BLRGameResultLoss,
    BLRGameResultSoloGame
};

typedef  NS_ENUM (NSUInteger, BLRAlertViewType)
{
    BLRAlertViewTypeDeleteBowlr,
    BLRAlertViewTypeDeleteAlley,
    BLRAlertViewTypeMaxBowlrs,
    BLRAlertViewTypeDuplicateBowlr,
    BLRAlertViewTypeDuplicateAlley,
    BLRAlertViewTypeSelectBowlr,
    BLRAlertViewTypeTutorialOn
};

typedef NS_ENUM(NSUInteger, BLRMenuCellState)
{
    BLRMenuCellStateInitial,
    BLRMenuCellStateEditMode,
    BLRMenuCellStateEditButtonPressed,
    BLRMenuCellStateSwipActive,
    BLRMenuCellStateSelected
};

#pragma - mark - Exceptions
static NSString *bNoImplementationException = @"No Implementation Exception";

#pragma - mark - Achievement Strings
static NSString *bAchievementCompleted = @"Achievement completed!";
static NSString *bBackFromTheDead = @"Back From The Dead";
static NSString *bPrecision = @"Precision";
static NSString *bJuggernaut = @"Juggernaut";
static NSString *bTurkey = @"Turkey";
static NSString *bFatTurkey = @"Fat Turkey";
static NSString *bThanksgivingDinner = @"Thanksgiving Dinner";
static NSString *bPerfection = @"Perfection";
static NSString *bIntimidation = @"Intimidation";
static NSString *bHumiliation = @"Humiliation";
static NSString *bBackFromDead = @"Back From The Dead";
static NSString *bFail = @"Fail";
static NSString *bEpicFail = @"Epic Fail";
static NSString *bImpressive = @"Impressive";
static NSString *bHowThe = @"How The?";
static NSString *bGotBling = @"Got Bling?";
static NSString *bDominos = @"Dominos";
static NSString *bSleeper = @"The Sleeper";
static NSString *bStrikeout = @"Strikeout";
static NSString *bElite = @"Elite";
static NSString *bIncomplete = @"Incomplete";
static NSString *bSecret = @"It's a secret!";

#pragma mark - AlertView Strings
static NSString *bDeleteBowlrTitle = @"Delete Bowlr?";
static NSString *bDeleteBowlrMessage = @"All information for this Bowlr including statistics and game history will be permanently deleted.";
static NSString *bDeleteAlleyTitle = @"Delete Alley";
static NSString *bDeleteAlleyMessage = @"Are you sure?";

static NSString *bDuplicateAlleyTitle = @"Duplicate Alley!";
static NSString *bDuplicateAlleyMessage = @"An alley with this name already exists.\nTry adding a city name or initial.";
static NSString *bDuplicateBowlrTitle = @"Duplicate Bowlr!";
static NSString *bDuplicateBowlrMessage = @"A Bowlr with this name already exists.\nTry adding an initial or possibly using a nickname.";
static NSString *bMaxBowlrsTitle = @"Max Bowlrs!";
static NSString *bMaxBowlrsMessage = @"Sorry, no more than eight Bowlrs can be added to a single game at this time.";
static NSString *bSavechangesTitle = @"Save Changes?";
static NSString *bSavechangesMessage = @"You have made changes to this game. Would you like to save those changes?";
static NSString *bSelectBowlrTitle = @"Select A Bowlr!";
static NSString *bSelectBowlrMessage = @"You need to select at least one Bowlr before you can start a game!";
static NSString *bTutorialTitle = @"Tutorial On!";
static NSString *bTutorialMessage = @"The tutorial will be on the next time you visit \"Game\" screens.";
static NSString *bDeleteTitle = @"Delete Game?";
static NSString *bDeleteMessage = @"Deleting this game will remove any stats and completed achievements for all players in this game.\n\nThis step cannot be undone. Are you sure you wish to delete this game?";
static NSString *bDiscardTitle = @"Discard Game?";
static NSString *bDiscardMessage = @"Discarding this game will remove any stats and completed achievements for all players in this game.\n\nThis step cannot be undone. Are you sure you wish to discard this game?";
static NSString *bEmailFailureTitle = @"Email not sent";
static NSString *bEmailFailureMessage = @"Device is unable to send email";

static NSString *bCancelButtonTitle = @"Cancel";
static NSString *bDeleteButtonTitle = @"Delete";
static NSString *bDiscardButtonTitle = @"Discard";
static NSString *bOKButtonTitle = @"OK";
static NSString *bSaveButtonTitle = @"Save";
static NSString *bDontSaveButtonTitle = @"Don't Save";

#pragma mark - Image Names
static NSString * const bAchievementCellArrow = @"AchievementsCellDisclosureArrow.png";
static NSString * const bAchievementCellArrowHighlighted = @"AchievementsCellDisclosureArrowHighlighted.png";
static NSString * const bAchievementTrophy = @"AchievementsTrophy.png";
static NSString * const bCurrentScoreFrameBackground = @"CurrentScoreBackground.png";
static NSString * const bDeleteCellStartMenu = @"DeleteCellStartMenu.png";
static NSString * const bMenuHistoryButtonImage = @"HistoryButton.png";
static NSString * const bMenuCellMinus = @"MenuCellMinus.png";
static NSString * const bMenuEditWheelImage = @"MenuEditWheelButton.png";
static NSString * const bMenuEditWheelHighlightImage = @"MenuEditWheelButtonHighlighted.png";
static NSString * const bMenuMoveButtonImage = @"MenuMoveButton.png";
static NSString * const bHistoryButtonHighlightImage = @"HistoryButtonHighlighted.png";
static NSString * const bMoreButtonImage = @"MoreButton.png";
static NSString * const bMoreButtonHighlightImage = @"MoreButtonHighlighted.png";
static NSString * const bTutorialNumberPadImage = @"TutorialNumberPad.png";
static NSString * const bTutorialPinsImage = @"TutorialPinScreen.png";

#pragma mark - Menu Items
static NSString * const bAboutMenuItem = @"About";
static NSString * const bAchievementsMenuItem = @"Achievements";
static NSString * const bAddAlley = @"+Add Alley";
static NSString * const bAddBowlr = @"+Add Bowlr";
static NSString * const bGamesMenuItem = @"Games";
static NSString * const bMakeSuggestionMenuItem = @"Make A Suggestion";
static NSString * const bReportBugMenuItem = @"Report A Bug";
static NSString * const bStatsMenuItem = @"Stats";
static NSString * const bTellFriendMenuItem = @"Tell A Friend";
static NSString * const bTutorialMenuItem = @"Tutorial";

#pragma mark - Notifications
static NSString * const bUpdateGameInterface = @"UpdateGameInterface";

#pragma mark - XIB files
static NSString * const bAlertViewNotify = @"BLRNotifyAlertView";
static NSString * const bAlertViewOptions = @"BLROptionsAlertView";
static NSString * const bAboutVC = @"AboutViewController";
static NSString * const bAchievementsCell = @"AchievementsTableCell";
static NSString * const bAchievementsVC = @"AchievementsViewController";
static NSString * const bBallSpeedDialVC = @"BLRBallSpeedViewController";
static NSString * const bFrameBarVC = @"BLRFrameBarViewController";
static NSString * const bFrameWindowVC = @"BLRFrameWindowViewController";
static NSString * const bGameHeaderVC = @"BLRGameHeaderViewController";
static NSString * const bGameSummaryVC = @"BLRGameSummaryViewController";
static NSString * const bGameSummaryLineItem = @"BLRGameSummaryLineItemViewController";
static NSString * const bLandingVC = @"BLRLandingViewController";
static NSString * const bLandscapeScorecardVC = @"BLRLandscapeScorecardViewController";
static NSString * const bLandscapeStatcardVC = @"BLRLandscapeStatcardViewController";
static NSString * const bMenuVC = @"BLRMenuViewController";
static NSString * const bMoreMenuVC = @"MoreMenuViewController";
static NSString * const bNumberPadVC = @"BLRNumberPadViewController";
static NSString * const bMainGameScreenVC = @"BLRMainGameViewController";
static NSString * const bPinsVC = @"BLRPinViewController";
static NSString * const bScorecardLineItemVC = @"BLRScorecardLineItemViewController";
static NSString * const bSingleFrameVC = @"BLRSingleFrameViewController";
static NSString * const bStatCardVC = @"StatCardViewController";
static NSString * const bStatCardLine = @"BLRLandscapeStatcardView";
static NSString * const bTenthFrameVC = @"BLRTenthFrameViewController";
static NSString * const bMenuHeader = @"BLRMenuHeaderView";
static NSString * const bTextFieldCell = @"BLRTextFieldCell";
static NSString * const bAlleyCell = @"BLRAlleyCell";
static NSString * const bPlayerCell = @"BLRPlayerCell";
static NSString * const bSelectedPlayerCell = @"BLRSelectedPlayerCell";

#pragma mark - Misc.
static NSString * const bBowlrs = @"Bowlrs";
static NSString * const bAlleys = @"Alleys";
static NSString * const bBowlrEmail = @"des253@hotmail.com";
static NSString * const bSuggestionTitle = @"Make A Suggestion";
static NSString * const bSuggestionMessage = @"Have an idea that would make Bowlr even more epic, changing bowling life forever as we know it? \n\nShare your epiphany!";
static NSString * const bReportBugTitle = @"Report A Bug";
static NSString * const bReportBugMessage = @"Please describe the nasty insect you found in Bowlr with as much detail as possible. \n\nPlease note: poltergeists do not count. In fact, you may want to contact your local exorcist. Seriously.";
static NSString * const bShareBowlrText = @"Check out Bowlr, a slick new bowling score tracker for the iPhone! http://www.twosixjuliet.com/Bowlr";
static NSString * const bShareScoreMessage = @"Check out my bowling score!\n\nRecorded with Bowlr for iPhone";
