//
//  Game+Utils.m
//  Bowlr
//
//  Created by Daniel Stewart on 8/8/15.
//  Copyright (c) 2015 Daniel Stewart. All rights reserved.
//

#import "Game+Utils.h"

@implementation Game (Utils)

- (void)computeCurrentGameScoreThroughFrame1
{
    Frame *firstFrame = [self.allFrames objectAtIndex: bFrameOneIndex];
    Frame *secondFrame = [self.allFrames objectAtIndex: bFrameTwoIndex];
    Frame *thirdFrame = [self.allFrames objectAtIndex: bFrameThreeIndex];
    
    if(firstFrame.result == BLRFrameResultSpare)
    {
        firstFrame.currentGameScore = firstFrame.scoreForFrame + secondFrame.firstAttempt.scoreForAttempt;
    }
    else if(firstFrame.result == BLRFrameResultStrike)
    {
        firstFrame.currentGameScore = firstFrame.scoreForFrame + secondFrame.firstAttempt.scoreForAttempt;
        if(secondFrame.result == BLRFrameResultStrike)
        {
            firstFrame.currentGameScore += thirdFrame.firstAttempt.scoreForAttempt;
        }
        else
        {
            firstFrame.currentGameScore += secondFrame.secondAttempt.scoreForAttempt;
        }
    }
    else
    {
        firstFrame.currentGameScore = firstFrame.scoreForFrame;
    }
}

- (void)computeCurrentGameScoreThroughFrame2
{
    Frame *firstFrame = [self.allFrames objectAtIndex: bFrameOneIndex];
    Frame *secondFrame = [self.allFrames objectAtIndex: bFrameTwoIndex];
    Frame *thirdFrame = [self.allFrames objectAtIndex: bFrameThreeIndex];
    Frame *fourthFrame = [self.allFrames objectAtIndex: bFrameFourIndex];
    
    [self computeCurrentGameScoreThroughFrame1];
    secondFrame.currentGameScore = firstFrame.currentGameScore;
    
    if(secondFrame.result == BLRFrameResultSpare)
    {
        secondFrame.currentGameScore += secondFrame.scoreForFrame + thirdFrame.firstAttempt.scoreForAttempt;
    }
    else if(secondFrame.result == BLRFrameResultStrike)
    {
        secondFrame.currentGameScore += secondFrame.scoreForFrame + thirdFrame.firstAttempt.scoreForAttempt;
        if(thirdFrame.result == BLRFrameResultStrike)
        {
            secondFrame.currentGameScore += fourthFrame.firstAttempt.scoreForAttempt;
        }
        else
        {
            secondFrame.currentGameScore += thirdFrame.secondAttempt.scoreForAttempt;
        }
    }
    else
    {
        secondFrame.currentGameScore += secondFrame.scoreForFrame;
    }
}

- (void)computeCurrentGameScoreThroughFrame3
{
    Frame *secondFrame = [self.allFrames objectAtIndex: bFrameTwoIndex];
    Frame *thirdFrame = [self.allFrames objectAtIndex: bFrameThreeIndex];
    Frame *fourthFrame = [self.allFrames objectAtIndex: bFrameFourIndex];
    Frame *fifthFrame = [self.allFrames objectAtIndex: bFrameFiveIndex];
    
    [self computeCurrentGameScoreThroughFrame1];
    [self computeCurrentGameScoreThroughFrame2];
    thirdFrame.currentGameScore = secondFrame.currentGameScore;
    
    if(thirdFrame.result == BLRFrameResultSpare)
    {
        thirdFrame.currentGameScore += thirdFrame.scoreForFrame + fourthFrame.firstAttempt.scoreForAttempt;
    }
    else if(thirdFrame.result == BLRFrameResultStrike)
    {
        thirdFrame.currentGameScore += thirdFrame.scoreForFrame + fourthFrame.firstAttempt.scoreForAttempt;
        if(fourthFrame.result == BLRFrameResultStrike)
        {
            thirdFrame.currentGameScore += fifthFrame.firstAttempt.scoreForAttempt;
        }
        else
        {
            thirdFrame.currentGameScore += fourthFrame.secondAttempt.scoreForAttempt;
        }
    }
    else
    {
        thirdFrame.currentGameScore += thirdFrame.scoreForFrame;
    }
}

- (void)computeCurrentGameScoreThroughFrame4
{
    Frame *thirdFrame = [self.allFrames objectAtIndex: bFrameThreeIndex];
    Frame *fourthFrame = [self.allFrames objectAtIndex: bFrameFourIndex];
    Frame *fifthFrame = [self.allFrames objectAtIndex: bFrameFiveIndex];
    Frame *sixthFrame = [self.allFrames objectAtIndex: bFrameSixIndex];
    
    [self computeCurrentGameScoreThroughFrame1];
    [self computeCurrentGameScoreThroughFrame2];
    [self computeCurrentGameScoreThroughFrame3];
    
    fourthFrame.currentGameScore = thirdFrame.currentGameScore;
    
    if(fourthFrame.result == BLRFrameResultSpare)
    {
        fourthFrame.currentGameScore += fourthFrame.scoreForFrame + fifthFrame.firstAttempt.scoreForAttempt;
    }
    else if(fourthFrame.result == BLRFrameResultStrike)
    {
        fourthFrame.currentGameScore += fourthFrame.scoreForFrame + fifthFrame.firstAttempt.scoreForAttempt;
        if(fifthFrame.result == BLRFrameResultStrike)
        {
            fourthFrame.currentGameScore += sixthFrame.firstAttempt.scoreForAttempt;
        }
        else
        {
            fourthFrame.currentGameScore += fifthFrame.secondAttempt.scoreForAttempt;
        }
    }
    else
    {
        fourthFrame.currentGameScore += fourthFrame.scoreForFrame;
    }
}

- (void)computeCurrentGameScoreThroughFrame5
{
    Frame *fourthFrame = [self.allFrames objectAtIndex: bFrameFourIndex];
    Frame *fifthFrame = [self.allFrames objectAtIndex: bFrameFiveIndex];
    Frame *sixthFrame = [self.allFrames objectAtIndex: bFrameSixIndex];
    Frame *seventhFrame = [self.allFrames objectAtIndex: bFrameSevenIndex];
    
    [self computeCurrentGameScoreThroughFrame1];
    [self computeCurrentGameScoreThroughFrame2];
    [self computeCurrentGameScoreThroughFrame3];
    [self computeCurrentGameScoreThroughFrame4];
    
    fifthFrame.currentGameScore = fourthFrame.currentGameScore;
    
    if(fifthFrame.result == BLRFrameResultSpare)
    {
        fifthFrame.currentGameScore += fifthFrame.scoreForFrame + sixthFrame.firstAttempt.scoreForAttempt;
    }
    else if(fifthFrame.result == BLRFrameResultStrike)
    {
        fifthFrame.currentGameScore += fifthFrame.scoreForFrame + sixthFrame.firstAttempt.scoreForAttempt;
        if(sixthFrame.result == BLRFrameResultStrike)
        {
            fifthFrame.currentGameScore += seventhFrame.firstAttempt.scoreForAttempt;
        }
        else
        {
            fifthFrame.currentGameScore += sixthFrame.secondAttempt.scoreForAttempt;
        }
    }
    else
    {
        fifthFrame.currentGameScore += fifthFrame.scoreForFrame;
    }
}

- (void)computeCurrentGameScoreThroughFrame6
{
    Frame *fifthFrame = [self.allFrames objectAtIndex: bFrameFiveIndex];
    Frame *sixthFrame = [self.allFrames objectAtIndex: bFrameSixIndex];
    Frame *seventhFrame = [self.allFrames objectAtIndex: bFrameSevenIndex];
    Frame *eigthFrame = [self.allFrames objectAtIndex: bFrameEightIndex];
    
    [self computeCurrentGameScoreThroughFrame1];
    [self computeCurrentGameScoreThroughFrame2];
    [self computeCurrentGameScoreThroughFrame3];
    [self computeCurrentGameScoreThroughFrame4];
    [self computeCurrentGameScoreThroughFrame5];
    
    sixthFrame.currentGameScore = fifthFrame.currentGameScore;
    
    if(sixthFrame.result == BLRFrameResultSpare)
    {
        sixthFrame.currentGameScore += sixthFrame.scoreForFrame + seventhFrame.firstAttempt.scoreForAttempt;
    }
    else if(sixthFrame.result == BLRFrameResultStrike)
    {
        sixthFrame.currentGameScore += sixthFrame.scoreForFrame + seventhFrame.firstAttempt.scoreForAttempt;
        if(seventhFrame.result == BLRFrameResultStrike)
        {
            sixthFrame.currentGameScore += eigthFrame.firstAttempt.scoreForAttempt;
        }
        else
        {
            sixthFrame.currentGameScore += seventhFrame.secondAttempt.scoreForAttempt;
        }
    }
    else
    {
        sixthFrame.currentGameScore += sixthFrame.scoreForFrame;
    }
}

- (void)computeCurrentGameScoreThroughFrame7
{
    Frame *sixthFrame = [self.allFrames objectAtIndex: bFrameSixIndex];
    Frame *seventhFrame = [self.allFrames objectAtIndex: bFrameSevenIndex];
    Frame *eigthFrame = [self.allFrames objectAtIndex: bFrameEightIndex];
    Frame *ninthFrame = [self.allFrames objectAtIndex: bFrameNineIndex];
    
    [self computeCurrentGameScoreThroughFrame1];
    [self computeCurrentGameScoreThroughFrame2];
    [self computeCurrentGameScoreThroughFrame3];
    [self computeCurrentGameScoreThroughFrame4];
    [self computeCurrentGameScoreThroughFrame5];
    [self computeCurrentGameScoreThroughFrame6];
    
    seventhFrame.currentGameScore = sixthFrame.currentGameScore;
    
    if(seventhFrame.result == BLRFrameResultSpare)
    {
        seventhFrame.currentGameScore += seventhFrame.scoreForFrame + eigthFrame.firstAttempt.scoreForAttempt;
    }
    else if(seventhFrame.result == BLRFrameResultStrike)
    {
        seventhFrame.currentGameScore += seventhFrame.scoreForFrame + eigthFrame.firstAttempt.scoreForAttempt;
        if(eigthFrame.result == BLRFrameResultStrike)
        {
            seventhFrame.currentGameScore += ninthFrame.firstAttempt.scoreForAttempt;
        }
        else
        {
            seventhFrame.currentGameScore += eigthFrame.secondAttempt.scoreForAttempt;
        }
    }
    else
    {
        seventhFrame.currentGameScore += seventhFrame.scoreForFrame;
    }
}

- (void)computeCurrentGameScoreThroughFrame8
{
    Frame *seventhFrame = [self.allFrames objectAtIndex: bFrameSevenIndex];
    Frame *eigthFrame = [self.allFrames objectAtIndex: bFrameEightIndex];
    Frame *ninthFrame = [self.allFrames objectAtIndex: bFrameNineIndex];
    Frame *tenthFrame = [self.allFrames objectAtIndex: bFrameTenIndex];
    
    [self computeCurrentGameScoreThroughFrame1];
    [self computeCurrentGameScoreThroughFrame2];
    [self computeCurrentGameScoreThroughFrame3];
    [self computeCurrentGameScoreThroughFrame4];
    [self computeCurrentGameScoreThroughFrame5];
    [self computeCurrentGameScoreThroughFrame6];
    [self computeCurrentGameScoreThroughFrame7];
    
    eigthFrame.currentGameScore = seventhFrame.currentGameScore;
    
    if(eigthFrame.result == BLRFrameResultSpare)
    {
        eigthFrame.currentGameScore += eigthFrame.scoreForFrame + ninthFrame.firstAttempt.scoreForAttempt;
    }
    else if(eigthFrame.result == BLRFrameResultStrike)
    {
        eigthFrame.currentGameScore += eigthFrame.scoreForFrame + ninthFrame.firstAttempt.scoreForAttempt;
        if(ninthFrame.result == BLRFrameResultStrike)
        {
            eigthFrame.currentGameScore += tenthFrame.firstAttempt.scoreForAttempt;
        }
        else
        {
            eigthFrame.currentGameScore += ninthFrame.secondAttempt.scoreForAttempt;
        }
    }
    else
    {
        eigthFrame.currentGameScore += eigthFrame.scoreForFrame;
    }
}

- (void)computeCurrentGameScoreThroughFrame9
{
    Frame *eigthFrame = [self.allFrames objectAtIndex: bFrameEightIndex];
    Frame *ninthFrame = [self.allFrames objectAtIndex: bFrameNineIndex];
    Frame *tenthFrame = [self.allFrames objectAtIndex: bFrameTenIndex];
    
    [self computeCurrentGameScoreThroughFrame1];
    [self computeCurrentGameScoreThroughFrame2];
    [self computeCurrentGameScoreThroughFrame3];
    [self computeCurrentGameScoreThroughFrame4];
    [self computeCurrentGameScoreThroughFrame5];
    [self computeCurrentGameScoreThroughFrame6];
    [self computeCurrentGameScoreThroughFrame7];
    [self computeCurrentGameScoreThroughFrame8];
    
    ninthFrame.currentGameScore = eigthFrame.currentGameScore;
    
    if(ninthFrame.result == BLRFrameResultSpare)
    {
        ninthFrame.currentGameScore += ninthFrame.scoreForFrame + tenthFrame.firstAttempt.scoreForAttempt;
    }
    else if(ninthFrame.result == BLRFrameResultStrike)
    {
        ninthFrame.currentGameScore += ninthFrame.scoreForFrame + tenthFrame.firstAttempt.scoreForAttempt + tenthFrame.secondAttempt.scoreForAttempt;
    }
    else
    {
        ninthFrame.currentGameScore += ninthFrame.scoreForFrame;
    }
}

- (void)computeCurrentGameScoreThroughFrame10
{
    Frame *ninthFrame = [self.allFrames objectAtIndex: bFrameNineIndex];
    Frame *tenthFrame = [self.allFrames objectAtIndex: bFrameTenIndex];
    
    [self computeCurrentGameScoreThroughFrame1];
    [self computeCurrentGameScoreThroughFrame2];
    [self computeCurrentGameScoreThroughFrame3];
    [self computeCurrentGameScoreThroughFrame4];
    [self computeCurrentGameScoreThroughFrame5];
    [self computeCurrentGameScoreThroughFrame6];
    [self computeCurrentGameScoreThroughFrame7];
    [self computeCurrentGameScoreThroughFrame8];
    [self computeCurrentGameScoreThroughFrame9];
    
    tenthFrame.currentGameScore = ninthFrame.currentGameScore;
    
    if(tenthFrame.firstAttempt.result == BLRAttemptResultStrike || tenthFrame.secondAttempt.result == BLRAttemptResultStrike || tenthFrame.secondAttempt.result == BLRAttemptResultSpare)
    {
        tenthFrame.currentGameScore += tenthFrame.scoreForFrame;
    }
    else
    {
        tenthFrame.currentGameScore += tenthFrame.firstAttempt.scoreForAttempt + tenthFrame.secondAttempt.scoreForAttempt;
    }
}

- (int)calculateScoreThroughFrame1
{
    Frame *firstFrame = [self.allFrames objectAtIndex: 0];
    return firstFrame.scoreForFrame;
}

// Adjusts the total score of Frame 2
- (int)calculateScoreThroughFrame2
{
    Frame *firstFrame = [self.allFrames objectAtIndex:0];
    Frame *secondFrame = [self.allFrames objectAtIndex:1];
    
    if(firstFrame.result == BLRFrameResultSpare)
    {
        return firstFrame.scoreForFrame + secondFrame.firstAttempt.scoreForAttempt + secondFrame.scoreForFrame;
    }
    else if(firstFrame.result == BLRFrameResultStrike)
    {
        if(secondFrame.result == BLRFrameResultStrike)
        {
            return firstFrame.scoreForFrame + (secondFrame.firstAttempt.scoreForAttempt * 2);
        }
        else
        {
            return firstFrame.scoreForFrame + secondFrame.scoreForFrame;
        }
    }
    else
    {
        return firstFrame.scoreForFrame + secondFrame.scoreForFrame;
    }
}

- (int)calculateGameScoreThroughFrame3
{
    Frame *firstFrame = [self.allFrames objectAtIndex: 0];
    Frame *secondFrame = [self.allFrames objectAtIndex: 1];
    Frame *thirdFrame = [self.allFrames objectAtIndex: 2];
    

    if(firstFrame.result == BLRFrameResultStrike)
    {
        if(secondFrame.result == BLRFrameResultStrike)
        {
            return firstFrame.scoreForFrame + secondFrame.firstAttempt.scoreForAttempt + thirdFrame.firstAttempt.scoreForAttempt;
        }
        else
        {
            return firstFrame.scoreForFrame + secondFrame.scoreForFrame;
        }
    }
    else if(secondFrame.result == BLRFrameResultStrike)
    {
        return secondFrame.scoreForFrame + secondFrame.scoreForFrame;
    }
    
    return 0;
}

// Returns the score of the game through the specified frameNumber
- (int)calculateGameScoreThroughFrame:(int)frameNumber
{
    if(frameNumber == 1)
    {
        return [self calculateScoreThroughFrame1];
    }
    else if(frameNumber == 2)
    {
        return [self calculateScoreThroughFrame2];
    }
    else if(frameNumber == 3)
    {
        return ([self calculateScoreThroughFrame1] + [self calculateScoreThroughFrame2] + [self calculateScoreThroughFrame3]);
    }
    else if(frameNumber == 4)
    {
        return ([self calculateScoreThroughFrame1] + [self calculateScoreThroughFrame2] + [self calculateScoreThroughFrame3] + [self calculateScoreThroughFrame4]);
    }
    else if(frameNumber == 5)
    {
        return ([self calculateScoreThroughFrame1] + [self calculateScoreThroughFrame2] + [self calculateScoreThroughFrame3] + [self calculateScoreThroughFrame4] + [self calculateScoreThroughFrame5]);
    }
    else if(frameNumber == 6)
    {
        return ([self calculateScoreThroughFrame1] + [self calculateScoreThroughFrame2]+ [self calculateScoreThroughFrame3] + [self calculateScoreThroughFrame4] + [self calculateScoreThroughFrame5] + [self calculateScoreThroughFrame6]);
    }
    else if(frameNumber == 7)
    {
        return ([self calculateScoreThroughFrame1] + [self calculateScoreThroughFrame2] + [self calculateScoreThroughFrame3] + [self calculateScoreThroughFrame4] + [self calculateScoreThroughFrame5] + [self calculateScoreThroughFrame6] + [self calculateScoreThroughFrame7]);
    }
    else if(frameNumber == 8)
    {
        return ([self calculateScoreThroughFrame1] + [self calculateScoreThroughFrame2] + [self calculateScoreThroughFrame3] + [self calculateScoreThroughFrame4] + [self calculateScoreThroughFrame5] + [self calculateScoreThroughFrame6] + [self calculateScoreThroughFrame7] + [self calculateScoreThroughFrame8]);
    }
    else if(frameNumber == 9)
    {
        return ([self calculateScoreThroughFrame1] + [self calculateScoreThroughFrame2] + [self calculateScoreThroughFrame3] + [self calculateScoreThroughFrame4] + [self calculateScoreThroughFrame5] + [self calculateScoreThroughFrame6] + [self calculateScoreThroughFrame7] + [self calculateScoreThroughFrame8] + [self calculateScoreThroughFrame9]);
    }
    else if(frameNumber == 10)
    {
        return ([self calculateScoreThroughFrame1] + [self calculateScoreThroughFrame2] + [self calculateScoreThroughFrame3] + [self calculateScoreThroughFrame4] + [self calculateScoreThroughFrame5] + [self calculateScoreThroughFrame6] + [self calculateScoreThroughFrame7] + [self calculateScoreThroughFrame8] + [self calculateScoreThroughFrame9] + [self calculateScoreThroughFrame10]);
    }
    else
    {
        return 0;
    }
}

// Returns the total score for the game
- (int)calculateScoreForGame
{
    Frame *frame1 = [self.allFrames objectAtIndex:0];
    Frame *frame2 = [self.allFrames objectAtIndex:1];
    Frame *frame3 = [self.allFrames objectAtIndex:2];
    Frame *frame4 = [self.allFrames objectAtIndex:3];
    Frame *frame5 = [self.allFrames objectAtIndex:4];
    Frame *frame6 = [self.allFrames objectAtIndex:5];
    Frame *frame7 = [self.allFrames objectAtIndex:6];
    Frame *frame8 = [self.allFrames objectAtIndex:7];
    Frame *frame9 = [self.allFrames objectAtIndex:8];
    Frame *frame10 = [self.allFrames objectAtIndex:9];
    self.totalScore = frame1.scoreForFrame + frame2.scoreForFrame + frame3.scoreForFrame + frame4.scoreForFrame + frame5.scoreForFrame + frame6.scoreForFrame + frame7.scoreForFrame + frame8.scoreForFrame + frame9.scoreForFrame + frame10.scoreForFrame;
    return self.totalScore;
}

// Adjusts the total score of Frame 3
- (int)calculateScoreThroughFrame3 {
    
    Frame *thirdFrame = [self.allFrames objectAtIndex:2];
    
    //Initially set the totalFrameScore to 10 to assume a strike or spare occurred
    thirdFrame.scoreForFrame = BLR_STRIKE_SCORE;
    
    /**If a spare or strike didn't occur, set the totalFrameScore to the actual score by calling the computeTotalFrameScore method**/
    if((thirdFrame.result != BLRFrameResultStrike) && (thirdFrame.result != BLRFrameResultSpare)) {
        [thirdFrame computeTotalFrameScore];
    }
    
    //Check the first two Frames for a spare or strike
    Frame *firstFrame = [self.allFrames objectAtIndex:0];
    
    Frame *secondFrame = [self.allFrames objectAtIndex:1];
    
    //If Strike occured on first 2 Frames, set Frame 1 score to 20 + 3rd Frame 1st Attempt score
    if((firstFrame.result == BLRFrameResultStrike) && (secondFrame.result == BLRFrameResultStrike))
        firstFrame.scoreForFrame = 20 + thirdFrame.firstAttempt.scoreForAttempt;
    
    //If a Strike occurred on the 2nd Frame and not on the 3rd Frame, set Frame 2 score to Frame 2 score + 3rd Frame score
    if(secondFrame.result == BLRFrameResultStrike && thirdFrame.result != BLRFrameResultStrike)
        secondFrame.scoreForFrame = BLR_STRIKE_SCORE + thirdFrame.scoreForFrame;
    
    //If a strike occurred on the 2nd and 3rd Frame, change the 2nd Frame total score
    else if((secondFrame.result == BLRFrameResultStrike) && (thirdFrame.result == BLRFrameResultStrike))
        secondFrame.scoreForFrame = 20;
    
    //If a Spare occurred on the 2nd Frame, set Frame 2 score to Frame 2 score + 3rd Frame 1st Attempt score
    else if(secondFrame.result == BLRFrameResultSpare)
        secondFrame.scoreForFrame = BLR_STRIKE_SCORE + thirdFrame.firstAttempt.scoreForAttempt;
    
    return thirdFrame.scoreForFrame;
}

// Adjusts the total score of Frame 4
- (int)calculateScoreThroughFrame4 {
    
    Frame *fourthFrame = [self.allFrames objectAtIndex:3];
    
    //Initially set the totalFrameScore to 10 to assume a strike or spare occurred
    fourthFrame.scoreForFrame = 10;
    
    /**If a spare or strike didn't occur, set the totalFrameScore to the actual score by calling the computeTotalFrameScore method**/
    if((fourthFrame.result != BLRFrameResultStrike) && (fourthFrame.result != BLRFrameResultSpare)) {
        [fourthFrame computeTotalFrameScore];
    }
    
    //Check the previous two Frames for a spare or strike
    Frame *secondFrame = [self.allFrames objectAtIndex:1];
    
    Frame *thirdFrame = [self.allFrames objectAtIndex:2];
    
    //If Strike occured on previous 2 Frames, set 2nd Frame score to 20 + 4th Frame 1st Attempt score
    if((secondFrame.result == BLRFrameResultStrike) && (thirdFrame.result == BLRFrameResultStrike))
        secondFrame.scoreForFrame = 20 + fourthFrame.firstAttempt.scoreForAttempt;
    
    //If a Strike occurred on the 3rd Frame and not on the 4th Frame, set 3rd Frame score to 10 + 4th Frame total score
    if(thirdFrame.result == BLRFrameResultStrike && fourthFrame.result != BLRFrameResultStrike)
        thirdFrame.scoreForFrame = 10 + fourthFrame.scoreForFrame;
    
    //If a strike occurred on the 3rd and 4th Frame, change the 3rd Frame total score
    else if((thirdFrame.result == BLRFrameResultStrike) && (fourthFrame.result == BLRFrameResultStrike))
        thirdFrame.scoreForFrame = 20;
    
    //If a Spare occurred on the 3rd Frame, set 3rd Frame score to 3rd Frame score + 4th Frame 1st Attempt score
    else if(thirdFrame.result == BLRFrameResultSpare)
        thirdFrame.scoreForFrame = 10 + fourthFrame.firstAttempt.scoreForAttempt;
    
    return fourthFrame.scoreForFrame;
}

// Adjusts the total score of Frame 5
- (int)calculateScoreThroughFrame5 {
    
    Frame *fifthFrame = [self.allFrames objectAtIndex:4];
    
    //Initially set the totalFrameScore to 10 to assume a strike or spare occurred
    fifthFrame.scoreForFrame = 10;
    
    /**If a spare or strike didn't occur, set the totalFrameScore to the actual score by calling the computeTotalFrameScore method**/
    if((fifthFrame.result != BLRFrameResultStrike) && (fifthFrame.result != BLRFrameResultSpare)) {
        [fifthFrame computeTotalFrameScore];
    }
    
    //Check the previous two Frames for a spare or strike
    Frame *thirdFrame = [self.allFrames objectAtIndex:2];
    
    Frame *fourthFrame = [self.allFrames objectAtIndex:3];
    
    //If Strike occured on previous 2 Frames, set 3rd Frame score to 20 + 5th Frame 1st Attempt score
    if((thirdFrame.result == BLRFrameResultStrike) && (fourthFrame.result == BLRFrameResultStrike))
        thirdFrame.scoreForFrame = 20 + fifthFrame.firstAttempt.scoreForAttempt;
    
    //If a Strike occurred on the 4th Frame and not on the 5th Frame, set 4th Frame score to 4th Frame score + 5th Frame score
    if(fourthFrame.result == BLRFrameResultStrike && fifthFrame.result != BLRFrameResultStrike)
        fourthFrame.scoreForFrame = 10 + fifthFrame.scoreForFrame;
    
    //If a strike occurred on the 4th and 5th Frame, change the 4th Frame total score
    else if((fourthFrame.result == BLRFrameResultStrike) && (fifthFrame.result == BLRFrameResultStrike))
        fourthFrame.scoreForFrame = 20;
    
    //If a Spare occurred on the 4th Frame, set 4th Frame score to 4th Frame score + 5th Frame 1st Attempt score
    else if(fourthFrame.result == BLRFrameResultSpare)
        fourthFrame.scoreForFrame = 10 + fifthFrame.firstAttempt.scoreForAttempt;
    
    return fifthFrame.scoreForFrame;
}

// Adjusts the total score of Frame 6
- (int)calculateScoreThroughFrame6 {
    
    Frame *sixthFrame = [self.allFrames objectAtIndex:5];
    
    //Initially set the totalFrameScore to 10 to assume a strike or spare occurred
    sixthFrame.scoreForFrame = 10;
    
    /**If a spare or strike didn't occur, set the totalFrameScore to the actual score by calling the computeTotalFrameScore method**/
    if((sixthFrame.result != BLRFrameResultStrike) && (sixthFrame.result != BLRFrameResultSpare)) {
        [sixthFrame computeTotalFrameScore];
    }
    
    //Check the previous two Frames for a spare or strike
    Frame *fourthFrame = [self.allFrames objectAtIndex:3];
    
    Frame *fifthFrame = [self.allFrames objectAtIndex:4];
    
    //If Strike occured on previous 2 Frames, set 4th Frame score to 20 + 6th Frame 1st Attempt score
    if((fourthFrame.result == BLRFrameResultStrike) && (fifthFrame.result == BLRFrameResultStrike))
        fourthFrame.scoreForFrame = 20 + sixthFrame.firstAttempt.scoreForAttempt;
    
    //If a Strike occurred on the 5th Frame and not on the 6th Frame, set 5th Frame score to 5th Frame score + 6th Frame score
    if(fifthFrame.result == BLRFrameResultStrike && sixthFrame.result != BLRFrameResultStrike)
        fifthFrame.scoreForFrame = 10 + sixthFrame.scoreForFrame;
    
    //If a strike occurred on the 5th and 6th Frame, change the 5th Frame total score
    else if((fifthFrame.result == BLRFrameResultStrike) && (sixthFrame.result == BLRFrameResultStrike))
        fifthFrame.scoreForFrame = 20;
    
    //If a Spare occurred on the 5th Frame, set 5th Frame score to 5th Frame score + 6th Frame 1st Attempt score
    else if(fifthFrame.result == BLRFrameResultSpare)
        fifthFrame.scoreForFrame = 10 + sixthFrame.firstAttempt.scoreForAttempt;
    
    return sixthFrame.scoreForFrame;
}

// Adjusts the total score of Frame 7
- (int)calculateScoreThroughFrame7 {
    
    Frame *seventhFrame = [self.allFrames objectAtIndex:6];
    
    //Initially set the totalFrameScore to 10 to assume a strike or spare occurred
    seventhFrame.scoreForFrame = 10;
    
    /**If a spare or strike didn't occur, set the totalFrameScore to the actual score by calling the computeTotalFrameScore method**/
    if((seventhFrame.result != BLRFrameResultStrike) && (seventhFrame.result != BLRFrameResultSpare)) {
        [seventhFrame computeTotalFrameScore];
    }
    
    //Check the previous two Frames for a spare or strike
    Frame *fifthFrame = [self.allFrames objectAtIndex:4];
    
    Frame *sixthFrame = [self.allFrames objectAtIndex:5];
    
    //If Strike occured on previous 2 Frames, set 5th Frame score to 20 + 7th Frame 1st Attempt score
    if((fifthFrame.result == BLRFrameResultStrike) && (sixthFrame.result == BLRFrameResultStrike))
        fifthFrame.scoreForFrame = 20 + seventhFrame.firstAttempt.scoreForAttempt;
    
    //If a Strike occurred on the 6th Frame and not on the 7th Frame, set 6th Frame score to 6th Frame score + 7th Frame score
    if(sixthFrame.result == BLRFrameResultStrike && seventhFrame.result != BLRFrameResultStrike)
        sixthFrame.scoreForFrame = 10 + seventhFrame.scoreForFrame;
    
    //If a strike occurred on the 6th and 7th Frame, change the 6th Frame total score
    else if((sixthFrame.result == BLRFrameResultStrike) && (seventhFrame.result == BLRFrameResultStrike))
        sixthFrame.scoreForFrame = 20;
    
    //If a Spare occurred on the 6th Frame, set 6th Frame score to 6th Frame score + 7th Frame 1st Attempt score
    else if(sixthFrame.result == BLRFrameResultSpare)
        sixthFrame.scoreForFrame = 10 + seventhFrame.firstAttempt.scoreForAttempt;
    
    return seventhFrame.scoreForFrame;
}


// Adjusts the total score of Frame 8
- (int)calculateScoreThroughFrame8 {
    
    Frame *eigthFrame = [self.allFrames objectAtIndex:7];
    
    //Initially set the totalFrameScore to 10 to assume a strike or spare occurred
    eigthFrame.scoreForFrame = 10;
    
    /**If a spare or strike didn't occur, set the totalFrameScore to the actual score by calling the computeTotalFrameScore method**/
    if((eigthFrame.result != BLRFrameResultStrike) && (eigthFrame.result != BLRFrameResultSpare)) {
        [eigthFrame computeTotalFrameScore];
    }
    
    //Check the previous two Frames for a spare or strike
    Frame *sixthFrame = [self.allFrames objectAtIndex:5];
    
    Frame *seventhFrame = [self.allFrames objectAtIndex:6];
    
    //If Strike occured on previous 2 Frames, set 6th Frame score to 20 + 8th Frame 1st Attempt score
    if((sixthFrame.result == BLRFrameResultStrike) && (seventhFrame.result == BLRFrameResultStrike))
        sixthFrame.scoreForFrame = 20 + eigthFrame.firstAttempt.scoreForAttempt;
    
    //If a Strike occurred on the 7th Frame and not on the 8th Frame, set 7th Frame score to 7th Frame score + 8th Frame score
    if(seventhFrame.result == BLRFrameResultStrike && eigthFrame.result != BLRFrameResultStrike)
        seventhFrame.scoreForFrame = 10 + eigthFrame.scoreForFrame;
    
    //If a strike occurred on the 7th and 8th Frame, change the 7th Frame total score
    else if((seventhFrame.result == BLRFrameResultStrike) && (eigthFrame.result == BLRFrameResultStrike))
        seventhFrame.scoreForFrame = 20;
    
    //If a Spare occurred on the 7th Frame, set 7th Frame score to 7th Frame score + 8th Frame 1st Attempt score
    else if(seventhFrame.result == BLRFrameResultSpare)
        seventhFrame.scoreForFrame = 10 + eigthFrame.firstAttempt.scoreForAttempt;
    
    return eigthFrame.scoreForFrame;
}

// Adjusts the total score of Frame 9
- (int)calculateScoreThroughFrame9 {
    
    Frame *ninthFrame = [self.allFrames objectAtIndex:8];
    
    //Initially set the totalFrameScore to 10 to assume a strike or spare occurred
    ninthFrame.scoreForFrame = 10;
    
    /**If a spare or strike didn't occur, set the totalFrameScore to the actual score by calling the computeTotalFrameScore method**/
    if((ninthFrame.result != BLRFrameResultStrike) && (ninthFrame.result == BLRFrameResultSpare)) {
        [ninthFrame computeTotalFrameScore];
    }
    
    //Check the previous two Frames for a spare or strike
    Frame *seventhFrame = [self.allFrames objectAtIndex:6];
    
    Frame *eigthFrame = [self.allFrames objectAtIndex:7];
    
    //If Strike occured on previous 2 Frames, set 7th Frame score to 20 + 9th Frame 1st Attempt score
    if((seventhFrame.result == BLRFrameResultStrike) && (eigthFrame.result == BLRFrameResultStrike))
        seventhFrame.scoreForFrame = 20 + ninthFrame.firstAttempt.scoreForAttempt;
    
    //If a Strike occurred on the 8th Frame and not on the 9th Frame, set 8th Frame score to 8th Frame score + 9th Frame score
    if(eigthFrame.result == BLRFrameResultStrike && ninthFrame.result != BLRFrameResultStrike)
        eigthFrame.scoreForFrame = 10 + ninthFrame.scoreForFrame;
    
    //If a strike occurred on the 8th and 9th Frame, change the 8th Frame total score
    else if((eigthFrame.result == BLRFrameResultStrike) && (ninthFrame.result == BLRFrameResultStrike))
        eigthFrame.scoreForFrame = 20;
    
    //If a Spare occurred on the 8th Frame, set 8th Frame score to 8th Frame score + 9th Frame 1st Attempt score
    else if(eigthFrame.result == BLRFrameResultSpare)
        eigthFrame.scoreForFrame = 10 + ninthFrame.firstAttempt.scoreForAttempt;
    
    return ninthFrame.scoreForFrame;
}

// Adjusts the total score of Frame 10
- (int)calculateScoreThroughFrame10
{
    Frame *tenthFrame = [self.allFrames objectAtIndex:9];
    
    /**If a spare or strike didn't occur in the first 2 Attempts, set the totalFrameScore to the actual score by calling the computeTotalFrameScore method**/
    if((tenthFrame.firstAttempt.result != BLRAttemptResultStrike) && (tenthFrame.secondAttempt.result != BLRAttemptResultSpare))
    {
        tenthFrame.scoreForFrame = tenthFrame.firstAttempt.scoreForAttempt + tenthFrame.secondAttempt.scoreForAttempt;
    }
    
    // Check the previous two Frames for a Spare or Strike
    Frame *eigthFrame = [self.allFrames objectAtIndex:7];
    
    Frame *ninthFrame = [self.allFrames objectAtIndex:8];
    
    // If Strike occured on previous 2 Frames, set Frame 8 score to 20 + 10th Frame 1st Attempt score
    if((eigthFrame.result == BLRFrameResultStrike) && (ninthFrame.result == BLRFrameResultStrike))
    {
        eigthFrame.scoreForFrame = 20 + tenthFrame.firstAttempt.scoreForAttempt;
    }
    
    // If a Strike occurred on the 9th Frame and not on the 10th Frame, set Frame 9 score to Frame 9 score + 10th Frame score
    if(ninthFrame.result == BLRFrameResultStrike)
    {
        ninthFrame.scoreForFrame = 10 + tenthFrame.firstAttempt.scoreForAttempt + tenthFrame.secondAttempt.scoreForAttempt;
    }
    
    // If a Spare occurred on the 9th Frame, set Frame 9 score to Frame 9 score + 10th Frame 1st Attempt score
    if(ninthFrame.result == BLRFrameResultSpare)
    {
        ninthFrame.scoreForFrame = 10 + tenthFrame.firstAttempt.scoreForAttempt;
    }
    
    // If a Strike occurred on the 1st Attempt of the 10th Frame
    if(tenthFrame.firstAttempt.result == BLRAttemptResultStrike)
    {
        tenthFrame.firstAttempt.scoreForAttempt = 10;
        tenthFrame.scoreForFrame = tenthFrame.firstAttempt.scoreForAttempt + tenthFrame.secondAttempt.scoreForAttempt + tenthFrame.thirdAttempt.scoreForAttempt;
    }
    
    // If a Strike occurred on the 1st and 2nd Attempt of the 10th Frame
    if(tenthFrame.firstAttempt.result == BLRAttemptResultStrike && tenthFrame.secondAttempt.result == BLRAttemptResultStrike)
    {
        tenthFrame.firstAttempt.scoreForAttempt = 10;
        tenthFrame.secondAttempt.scoreForAttempt = 10;
        tenthFrame.scoreForFrame = tenthFrame.firstAttempt.scoreForAttempt + tenthFrame.secondAttempt.scoreForAttempt + tenthFrame.thirdAttempt.scoreForAttempt;
        
    }
    // If a Strike occurred on all 3 Attempts of the 10th Frame
    if(tenthFrame.firstAttempt.result == BLRAttemptResultStrike && tenthFrame.secondAttempt.result == BLRAttemptResultStrike && tenthFrame
       .thirdAttempt.result == BLRAttemptResultStrike)
    {
        tenthFrame.scoreForFrame = 30;
        tenthFrame.firstAttempt.scoreForAttempt = 10;
        tenthFrame.secondAttempt.scoreForAttempt = 10;
        tenthFrame.thirdAttempt.scoreForAttempt = 10;
    }
    
    // If a Spare occurred on the 2nd Attempt of the 10th Frame
    if(tenthFrame.secondAttempt.result == BLRAttemptResultSpare)
    {
        tenthFrame.scoreForFrame = tenthFrame.firstAttempt.scoreForAttempt + tenthFrame.secondAttempt.scoreForAttempt + tenthFrame.thirdAttempt.scoreForAttempt;
    }
    
    return tenthFrame.scoreForFrame;
}


// Returns the total number of Strikes achieved in a game
- (int)countStrikes
{
    int strikeCount = 0;
    for(int i = 0; i < 10; i++)
    {
        Frame *frame = [self.allFrames objectAtIndex:i];
        
        if(frame.result == BLRFrameResultStrike)
        {
            strikeCount++;
        }
        
        // Frame 10 can have multiple Strikes, so each Attempt must be checked
        else if(frame.frameNumber == 10)
        {
            if(frame.firstAttempt.result == BLRAttemptResultStrike)
            {
                strikeCount++;
            }
            if(frame.secondAttempt.result == BLRAttemptResultStrike)
            {
                strikeCount++;
            }
            if(frame.thirdAttempt.result == BLRAttemptResultStrike)
            {
                strikeCount++;
            }
        }
    }
    
    return strikeCount;
}

// Returns the total number of Spares achieved in a game
- (int)countSpares
{
    int spareCount = 0;
    for(int i = 0; i < 10; i++)
    {
        Frame *frame = [self.allFrames objectAtIndex:i];
        
        if(frame.result == BLRFrameResultSpare)
            spareCount++;
        
        // Frame 10 must check 2nd Attempt for Spare
        else if(frame.frameNumber == 10 && frame.secondAttempt.result == BLRAttemptResultSpare)
        {
            spareCount++;
        }
    }
    return spareCount;
}

// Returns the total number of Open Frames for a game
- (int)countOpenFrames
{
    int openFrameCount = 0;
    for(int i = 0; i < 10; i++)
    {
        Frame *frame = [self.allFrames objectAtIndex:i];
        
        if(frame.frameNumber != 10)
        {
            if(frame.result != BLRFrameResultStrike && frame.result != BLRFrameResultSpare)
            {
                openFrameCount++;
            }
        }
        
        // Frame 10 can have multiple Strikes, so each Attempt must be checked
        else if(frame.frameNumber == 10)
        {
            if(frame.firstAttempt.result != BLRAttemptResultStrike && frame.secondAttempt.result != BLRAttemptResultSpare)
            {
                openFrameCount++;
            }
        }
    }
    return openFrameCount;
}

@end
