//
//  BLRMenuTableViewCell.m
//  Bowlr
//
//  Created by Daniel Stewart on 7/19/15.
//  Copyright (c) 2015 Daniel Stewart. All rights reserved.
//

#import "BLRMenuTableViewCell.h"

@implementation BLRMenuTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier indexPath:(NSIndexPath *)indexPath
{
    self = [super initWithStyle: style reuseIdentifier: reuseIdentifier];
    if(self)
    {
        self.textLabel.textColor = [UIColor BLRMenuViewCellTextColor];
        self.textLabel.font = [UIFont systemFontOfSize: 18.0];
        self.selectionStyle = UITableViewCellSelectionStyleBlue;
        self.textLabel.highlightedTextColor = [UIColor BLRMenuViewCellTextColorHighlighted];
        
        self.contentView.backgroundColor = [self cellColorForIndexPath: indexPath];
        self.textLabel.backgroundColor = [self cellColorForIndexPath: indexPath];
        
        // Set up highlighted background view
        UIView *highlightBackgroundView = [[UIView alloc] initWithFrame: self.frame];
        highlightBackgroundView.backgroundColor = self.contentView.backgroundColor;
        self.selectedBackgroundView = highlightBackgroundView;
    }
    
    return self;
}

- (UIColor *)cellColorForIndexPath:(NSIndexPath *)indexPath
{
    return (indexPath.row % 2 == 0) ? [UIColor BLRMenuViewCellMidColor] : [UIColor BLRMenuViewCellHighColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected: selected animated: animated];
}

@end
