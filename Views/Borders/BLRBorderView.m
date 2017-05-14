//
//  BLRBorderView.m
//  Bowlr
//
//  Created by Daniel Stewart on 4/10/17.
//  Copyright © 2017 Daniel Stewart. All rights reserved.
//

#import "BLRBorderView.h"

@implementation BLRBorderView

- (void)drawRect:(CGRect)rect
{
    [self.layer setBorderColor: [UIColor colorWithRed: 114.0 / 255.0 green: 16.0 / 255.0 blue: 17.0 / 255.0 alpha: 1.0].CGColor];
}


@end
