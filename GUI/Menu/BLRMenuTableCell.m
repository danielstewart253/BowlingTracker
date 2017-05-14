//
//  BLRMenuTableCell.m
//  Bowlr
//
//  Created by Daniel Stewart on 4/28/17.
//  Copyright © 2017 Daniel Stewart. All rights reserved.
//

#import "BLRMenuTableCell.h"

@implementation BLRMenuTableCell

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)willTransitionToState:(UITableViewCellStateMask)state
{
    [super willTransitionToState: state];
}

- (void)animateDeleteButtonToVisible:(BOOL)beVisible
{
    CGRect frame = self.deleteButton.frame;
    CGFloat width = (beVisible) ? -self.deleteButton.frame.size.width : self.deleteButton.frame.size.width;
    frame.origin.x = frame.origin.x + width;
    [UIView animateWithDuration: 0.3 animations:^{
        self.deleteButton.frame = frame;
    }];
}

- (void)cellBackgroundColor:(UIColor *)color
{
    UIView *highlightBackgroundView = [[UIView alloc] initWithFrame: CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    highlightBackgroundView.backgroundColor = color;
    self.selectedBackgroundView = highlightBackgroundView;
    self.contentView.backgroundColor = color;
    self.contentView.superview.backgroundColor = color;
}

- (void)prepareForMove
{
    self.label.text = nil;
    self.textField.text = nil;
    self.accessoryImage.hidden = YES;
}

- (BOOL)textHasChanged
{
    return ![self.label.text isEqualToString: self.textField.text];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected: selected animated: animated];
}

@end
