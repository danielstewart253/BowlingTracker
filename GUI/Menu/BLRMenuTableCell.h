//
//  BLRMenuTableCell.h
//  Bowlr
//
//  Created by Daniel Stewart on 4/28/17.
//  Copyright © 2017 Daniel Stewart. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BLRMenuTextField.h"

@interface BLRMenuTableCell : UITableViewCell

@property (weak, nonatomic) UILabel *label;
@property (weak, nonatomic) BLRMenuTextField *textField;
@property (weak, nonatomic) UIButton *deleteButton;
@property (weak, nonatomic) UIButton *editButton;
@property (weak, nonatomic) UIImageView *accessoryImage;
@property (weak, nonatomic) NSLayoutConstraint *editButtonContraint;
@property (weak, nonatomic) NSLayoutConstraint *labelConstraint;
@property (weak, nonatomic) NSLayoutConstraint *textFieldConstraint;
@property (nonatomic) BOOL deleteButtonRevealed;
@property (nonatomic) BOOL editButtonPressed;

- (void)cellBackgroundColor:(UIColor *)color;
- (void)animateDeleteButtonToVisible:(BOOL)beVisible;
- (void)prepareForMove;
- (BOOL)textHasChanged;

@end
