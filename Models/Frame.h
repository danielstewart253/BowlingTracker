//
//  Frame.h
//  Bowlr
//
//  Created by Daniel Stewart on 12/9/14.
//  Copyright (c) 2014 Daniel Stewart. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Attempt+Utils.h"

@interface Frame : NSObject <NSCoding>

@property (readwrite, nonatomic) int frameNumber;
@property (readwrite, nonatomic) int scoreForFrame;
@property (readwrite, nonatomic) int currentGameScore;
@property (nonatomic, strong)   Frame *nextFrame;

// Each Frame has 2 Attempts, a third Frame is included for the 10th Frame
@property (strong, nonatomic) Attempt *firstAttempt;
@property (strong, nonatomic) Attempt *secondAttempt;
@property (strong, nonatomic) Attempt *thirdAttempt;

@property (readwrite, nonatomic) BLRFrameResult result;
@property (readwrite, nonatomic) BLRCurrentAttempt currentAttempt;

@end
