//
//  BLRLogManager.h
//  Bowlr
//
//  Created by Daniel Stewart on 3/13/17.
//  Copyright © 2017 Daniel Stewart. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BLRLogManager : NSObject

- (instancetype)initWithGameManager:(BLRGameManager *)manager;
- (void)logCurrentFrame;
- (void)logCurrentAttempt;

@end
