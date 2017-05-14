//
//  BLRStringProcessor.h
//  Bowlr
//
//  Created by Daniel Stewart on 3/20/17.
//  Copyright © 2017 Daniel Stewart. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BLRStringProcessor : NSObject

+ (NSString *)stringForAttemptResult:(Attempt *)attempt;
+ (NSString *)stringForFrameScore:(Frame *)frame;

@end
