//
//  BLRCircledNumber.m
//  Bowlr
//
//  Created by Daniel Stewart on 4/6/17.
//  Copyright © 2017 Daniel Stewart. All rights reserved.
//

#import "BLRCircledNumber.h"

@interface BLRCircledNumber()

@property(strong, nonatomic) UILabel *numberLabel;
@property(strong, nonatomic) UIColor *strokeColor;

@end

@implementation BLRCircledNumber

#define BLR_SCORECARD_FONT_SIZE 12

- (instancetype)initWithFrame:(CGRect)frame
              backgroundColor:(UIColor *)backgroundColor
                  strokeColor:(UIColor *)strokeColor
{
    self = [super initWithFrame: frame];
    if(self)
    {
        self.numberLabel = [[UILabel alloc] initWithFrame: CGRectMake(0, 0, frame.size.width, frame.size.height)];
        self.numberLabel.textAlignment = NSTextAlignmentCenter;
        self.numberLabel.adjustsFontSizeToFitWidth = YES;
        self.numberLabel.minimumScaleFactor = 0.5;
        self.numberLabel.font = [UIFont boldSystemFontOfSize: BLR_SCORECARD_FONT_SIZE];
        self.backgroundColor = backgroundColor;
        self.strokeColor = strokeColor;
        [self addSubview: self.numberLabel];
    }
    
    return self;
}

- (void)setText:(NSString *)text
{
    self.numberLabel.text = text;
}

- (void)setTextColor:(UIColor *)textColor
{
    self.numberLabel.textColor = textColor;
}

- (void)drawRect:(CGRect)rect
{
    CAShapeLayer *circleLayer = [CAShapeLayer layer];
    [circleLayer setPath: [[UIBezierPath bezierPathWithOvalInRect: CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)] CGPath]];
    [circleLayer setLineWidth: 4];
    [circleLayer setStrokeColor: [self.strokeColor CGColor]];
    [circleLayer setFillColor: [[UIColor clearColor] CGColor]];
    [[self layer] addSublayer: circleLayer];
}

@end
