//
//  BLRLandingViewController.h
//  Bowlr
//
//  Created by Daniel Stewart on 4/25/17.
//  Copyright © 2017 Daniel Stewart. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BLRViewController.h"
#import "MenuEditTableView.h"
#import "BLRButton.h"

@interface BLRLandingViewController : BLRViewController <MenuEditTableViewDelegate, MenuEditTableViewDataSource, UITextFieldDelegate>

- (instancetype)initWithGameManager:(BLRGameManager *)gameManager
                     historyManager:(BLRHistoryManager *)historyManager;

@end
