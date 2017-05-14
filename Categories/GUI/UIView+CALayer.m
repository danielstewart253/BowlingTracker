//
//  UIView+CALayer.m
//  Bowlr
//
//  Created by Daniel Stewart on 3/26/17.
//  Copyright © 2017 Daniel Stewart. All rights reserved.
//

#import "UIView+CALayer.h"

@implementation UIView (CALayer)

@dynamic borderColor, borderWidth, cornerRadius;

- (void)setBorderColor:(UIColor *)borderColor
{
    [self.layer setBorderColor:borderColor.CGColor];
}

- (void)setBorderWidth:(CGFloat)borderWidth
{
    [self.layer setBorderWidth:borderWidth];
}

- (void)setCornerRadius:(CGFloat)cornerRadius
{
    [self.layer setCornerRadius:cornerRadius];
}

@end
