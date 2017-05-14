//
//  BLRBackButtonView.m
//  Bowlr
//
//  Created by Daniel Stewart on 4/11/17.
//  Copyright © 2017 Daniel Stewart. All rights reserved.
//

#import "BLRBackButtonView.h"

@interface BLRBackButtonView()

@property (nonatomic, strong) UIColor *buttonColor;

@end

@implementation BLRBackButtonView

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
    self.layer.cornerRadius = self.frame.size.width / 2;
    self.layer.borderWidth = 6;
    self.layer.borderColor = [self.buttonColor CGColor];
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(context, [self.buttonColor CGColor]);
    CGContextSetLineWidth(context, 6.5f);
    CGContextSetLineCap(context, kCGLineCapRound);
    CGContextMoveToPoint(context, CGRectGetMidX(rect) * 1.2, CGRectGetMidY(rect) * .6);
    CGContextAddLineToPoint(context, CGRectGetMidX(rect) * .7, CGRectGetMidY(rect));
    CGContextMoveToPoint(context, CGRectGetMidX(rect) * 1.2, CGRectGetMidY(rect) * 1.4);
    CGContextAddLineToPoint(context, CGRectGetMidX(rect) * .7, CGRectGetMidY(rect));
    CGContextStrokePath(context);
}

@end
