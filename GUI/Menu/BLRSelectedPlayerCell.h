//
//  BLRSelectedPlayerCell.h
//  Bowlr
//
//  Created by Daniel Stewart on 5/4/17.
//  Copyright © 2017 Daniel Stewart. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BLRMenuTableCell.h"

@interface BLRSelectedPlayerCell : BLRMenuTableCell

@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet BLRMenuTextField *textField;
@property (weak, nonatomic) IBOutlet UIButton *deleteButton;
@property (weak, nonatomic) IBOutlet UIButton *editButton;
@property (weak, nonatomic) IBOutlet UIImageView *accessoryImage;

@end
