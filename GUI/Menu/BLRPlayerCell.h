//
//  BLRPlayerCell.h
//  Bowlr
//
//  Created by Daniel Stewart on 5/3/17.
//  Copyright © 2017 Daniel Stewart. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BLRMenuTableCell.h"

@interface BLRPlayerCell : BLRMenuTableCell

@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet BLRMenuTextField *textField;
@property (weak, nonatomic) IBOutlet UIButton *deleteButton;
@property (weak, nonatomic) IBOutlet UIButton *editButton;
@property (weak, nonatomic) IBOutlet UIImageView *accessoryImage;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *editButtonContraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *labelConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *textFieldConstraint;

@end
