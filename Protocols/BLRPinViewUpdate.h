//
//  BLRPinViewUpdate.h
//  Bowlr
//
//  Created by Daniel Stewart on 3/17/17.
//  Copyright © 2017 Daniel Stewart. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BLRPinViewUpdate <NSObject>

- (void)shouldUpdatePinsForSpare:(BOOL)spareOccurred;

@end
