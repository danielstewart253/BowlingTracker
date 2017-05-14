//
//  BLRSelectedPlayerCell.m
//  Bowlr
//
//  Created by Daniel Stewart on 5/4/17.
//  Copyright © 2017 Daniel Stewart. All rights reserved.
//

#import "BLRSelectedPlayerCell.h"

@implementation BLRSelectedPlayerCell

@dynamic label, textField, deleteButton, editButton, accessoryImage, editButtonContraint, labelConstraint;

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

@end
