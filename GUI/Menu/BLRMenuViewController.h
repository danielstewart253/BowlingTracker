//
//  BLRMenuViewController.h
//  Bowlr
//
//  Created by Daniel Stewart on 7/19/15.
//  Copyright (c) 2015 Daniel Stewart. All rights reserved.
//

#import "BLRViewController.h"

@interface BLRMenuViewController : BLRViewController

- (NSString *)titleForCellAtIndexPath:(NSIndexPath *)indexPath;
- (BOOL)isHistoryButtonEnabled;
- (BOOL)isMoreButtonEnabled;

@end
