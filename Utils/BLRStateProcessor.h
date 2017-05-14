//
//  BLRStateProcessor.h
//  Bowlr
//
//  Created by Daniel Stewart on 3/7/17.
//  Copyright © 2017 Daniel Stewart. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BLRStateProcessor : NSObject

- (void)determineState:(Frame *)currentFrame;
- (void)setStrikeStateForAttempt:(Attempt *)currentAttempt;

@end
