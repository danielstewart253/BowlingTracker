//
//  BLRMenuTextField.m
//  Bowlr
//
//  Created by Daniel Stewart on 9/7/15.
//  Copyright (c) 2015 Daniel Stewart. All rights reserved.
//

#import "BLRMenuTextField.h"

@implementation BLRMenuTextField

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder: aDecoder];
    if(self)
    {
        [self textFieldSetUp];
    }
    
    return self;
}

- (instancetype)init
{
    self = [super init];
    if(self)
    {
        [self textFieldSetUp];
    }
    
    return self;
}

- (void)displayPlaceHolderForText:(NSString *)text withColor:(UIColor *)color
{
    self.text = nil;
    self.attributedPlaceholder = [[NSAttributedString alloc] initWithString: text
                                                                 attributes: @{NSForegroundColorAttributeName: color}];
}

- (void)displayPlaceHolder
{
    self.text = nil;
    self.attributedPlaceholder = [[NSAttributedString alloc] initWithString: self.placeHolderText
                                                                 attributes: @{NSForegroundColorAttributeName: [UIColor BLRMenuViewCellPlaceHolderTextColor]}];
}

- (void)textFieldSetUp
{
    self.attributedPlaceholder = [[NSAttributedString alloc] initWithString: @""
                                                                 attributes: @{NSForegroundColorAttributeName: [UIColor BLRMenuViewCellPlaceHolderTextColor]}];
    self.returnKeyType = UIReturnKeyDone;
    self.opaque = YES;
    self.borderStyle = UITextBorderStyleNone;
    self.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.textColor = [UIColor BLRMenuViewCellTextColor];
    self.font = [UIFont systemFontOfSize: 18.0];
    self.frame = CGRectMake(10.0, 0.0, 287.0, 40.0);
    self.autocapitalizationType = UITextAutocapitalizationTypeWords;
    self.backgroundColor = [UIColor clearColor];
}

@end
