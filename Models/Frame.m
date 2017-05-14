//
//  Frame.m
//  Bowlr
//
//  Created by Daniel Stewart on 12/9/14.
//  Copyright (c) 2014 Daniel Stewart. All rights reserved.
//

#import "Frame.h"

@implementation Frame

- (id)init
{
    self = [super init];
    if(self)
    {
        self.result = BLRFrameResultNoAttempt;
        self.currentGameScore = 0;
        self.frameNumber = 0;
        self.scoreForFrame = 0;
        
        // Each Frame will have 2 Attempts, 10th Frame will have a 3rd Attempt
        self.firstAttempt = [[Attempt alloc] init];
        self.secondAttempt = [[Attempt alloc] init];
        self.thirdAttempt = [[Attempt alloc] init];
        
        self.currentAttempt = BLRCurrentAttemptFirst;
    }
    
    return self;
}

//Initialize Frame object with specific values for each property
//Used for saving and loading a Frame object
- (id)initWithFrameNumber:(int)frameNumber
         totalFrameScore:(int)totalFrameScore
         currentGameScore:(int)currentGameScore
          currentAttempt:(BLRCurrentAttempt)currentAttempt
            firstAttempt:(Attempt *)firstAttempt
           secondAttempt:(Attempt *)secondAttempt
            thirdAttempt:(Attempt *)thirdAttempt
{
    if((self = [super init]))
    {
        self.frameNumber = frameNumber;
        self.scoreForFrame = totalFrameScore;
        self.currentGameScore = currentGameScore;
        self.currentAttempt = currentAttempt;
        self.firstAttempt = firstAttempt;
        self.secondAttempt = secondAttempt;
        self.thirdAttempt = thirdAttempt;
    }
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeInt: self.frameNumber forKey: @"frameNumber"];
    [aCoder encodeInt: self.currentGameScore forKey: @"currentGameScore"];
    [aCoder encodeInt: self.scoreForFrame forKey: @"scoreForFrame"];
    [aCoder encodeInteger: self.currentAttempt forKey: @"currentAttempt"];
    [aCoder encodeObject: self.firstAttempt forKey: @"firstAttempt"];
    [aCoder encodeObject: self.secondAttempt forKey: @"secondAttempt"];
    [aCoder encodeObject: self.thirdAttempt forKey: @"thirdAttempt"];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    int frameNumber = [aDecoder decodeIntForKey:@"frameNumber"];
    int currentGameScore = [aDecoder decodeIntForKey:@"currentGameScore"];
    int scoreForFrame = [aDecoder decodeIntForKey:@"scoreForFrame"];
    BLRCurrentAttempt currentAttempt = [aDecoder decodeIntegerForKey:@"currentAttempt"];
    Attempt *firstAttempt = [aDecoder decodeObjectForKey:@"firstAttempt"];
    Attempt *secondAttempt = [aDecoder decodeObjectForKey:@"secondAttempt"];
    Attempt *thirdAttempt = [aDecoder decodeObjectForKey:@"thirdAttempt"];
    
    return [self initWithFrameNumber: frameNumber
                     totalFrameScore: scoreForFrame
                    currentGameScore: currentGameScore
                      currentAttempt: currentAttempt
                        firstAttempt: firstAttempt
                       secondAttempt: secondAttempt
                        thirdAttempt: thirdAttempt];
}

@end
