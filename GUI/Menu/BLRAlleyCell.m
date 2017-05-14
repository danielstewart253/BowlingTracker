//
//  BLRAlleyCell.m
//  Bowlr
//
//  Created by Daniel Stewart on 5/2/17.
//  Copyright © 2017 Daniel Stewart. All rights reserved.
//

#import "BLRAlleyCell.h"

@implementation BLRAlleyCell

@dynamic label, textField, deleteButton, editButton ,editButtonContraint, labelConstraint, textFieldConstraint;

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected: selected animated: animated];
}

@end
