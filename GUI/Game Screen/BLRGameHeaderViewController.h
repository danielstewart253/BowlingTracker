//
//  BLRGameHeaderViewController.h
//  Bowlr
//
//  Created by Daniel Stewart on 3/14/17.
//  Copyright © 2017 Daniel Stewart. All rights reserved.
//

#import "BLRGameInterfaceViewController.h"
#import "BLRBallSpeedViewController.h"
#import "BLRHeaderUpdate.h"
#import "BLRPinViewUpdate.h"

@interface BLRGameHeaderViewController : BLRGameInterfaceViewController <BallSpeedSetterDelegate, BLRHeaderUpdate>

@property(weak, nonatomic) id<BLRPinViewUpdate>pinViewDelegate;

@end
