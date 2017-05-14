//
//  BLRScorecardLineItemViewController.h
//  Bowlr
//
//  Created by Daniel Stewart on 4/2/17.
//  Copyright © 2017 Daniel Stewart. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BLRScorecardLineItemViewController : UIViewController

@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *allFrames;

- (instancetype)initWithNibName:(NSString *)nibNameOrNil
                         bundle:(NSBundle *)nibBundleOrNil
                         player:(Player *)player;
- (void)populateScorecardLine;
- (void)adjustWidth:(CGFloat)width;

@end
