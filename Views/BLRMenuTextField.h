//
//  BLRMenuTextField.h
//  Bowlr
//
//  Created by Daniel Stewart on 9/7/15.
//  Copyright (c) 2015 Daniel Stewart. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BLRMenuTextField : UITextField

@property (nonatomic, strong) NSString *placeHolderText;

- (void)displayPlaceHolderForText:(NSString *)text
                        withColor:(UIColor *)color;
- (void)displayPlaceHolder;
- (void)textFieldSetUp;

@end
