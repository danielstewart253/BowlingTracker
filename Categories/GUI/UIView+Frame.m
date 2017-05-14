//
//  UIView+Frame.m
//  Bowlr
//
//  Created by Daniel Stewart on 4/7/17.
//  Copyright © 2017 Daniel Stewart. All rights reserved.
//

#import "UIView+Frame.h"

@implementation UIView (Frame)

+ (CGRect)createMidSizeFrameWithView:(UIView *)view
{
    return CGRectMake(0, 0, CGRectGetWidth(view.frame) / 2, CGRectGetHeight(view.frame) / 2);
}

@end
