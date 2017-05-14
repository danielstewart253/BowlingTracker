//
//  BLRPlayButtonView.m
//  Bowlr
//
//  Created by Daniel Stewart on 12/14/14.
//  Copyright (c) 2014 Daniel Stewart. All rights reserved.
//

#import "BLRPlayButtonView.h"

@interface BLRPlayButtonView()

@property (nonatomic, strong) UIColor *buttonColor;

@end

@implementation BLRPlayButtonView

- (id)initWithFrame:(CGRect)frame
              color:(UIColor *)color
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = [UIColor clearColor];
        self.buttonColor = color;
    }
    
    return self;
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextBeginPath(ctx);
    CGContextMoveToPoint   (ctx, CGRectGetMinX(rect), CGRectGetMinY(rect));
    CGContextAddArcToPoint(ctx, CGRectGetMinX(rect), CGRectGetMinY(rect), CGRectGetMinX(rect), CGRectGetMaxY(rect), 2.0);
    CGContextAddArcToPoint(ctx, CGRectGetMinX(rect), CGRectGetMaxY(rect), CGRectGetMaxX(rect), CGRectGetMidY(rect), 2.0);  
    CGContextAddArcToPoint(ctx, CGRectGetMaxX(rect), CGRectGetMidY(rect), CGRectGetMinX(rect), CGRectGetMinY(rect), 2.0);
    CGContextAddArcToPoint(ctx, CGRectGetMinX(rect), CGRectGetMinY(rect), CGRectGetMinX(rect), CGRectGetMaxY(rect), 2.0);
    CGContextClosePath(ctx);
    CGContextSetFillColorWithColor(ctx, [self.buttonColor CGColor]);
    CGContextFillPath(ctx);
}

@end
