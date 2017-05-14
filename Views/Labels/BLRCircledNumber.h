//
//  BLRCircledNumber.h
//  Bowlr
//
//  Created by Daniel Stewart on 4/6/17.
//  Copyright © 2017 Daniel Stewart. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BLRCircledNumber : UIView

- (instancetype)initWithFrame:(CGRect)frame
              backgroundColor:(UIColor *)backgroundColor
                  strokeColor:(UIColor *)strokeColor;
- (void)setText:(NSString *)text;
- (void)setTextColor:(UIColor *)textColor;

@end
