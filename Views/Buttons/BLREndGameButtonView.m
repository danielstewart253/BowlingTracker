//
//  BLREndGameButtonView.m
//  Bowlr
//
//  Created by Daniel Stewart on 4/1/17.
//  Copyright © 2017 Daniel Stewart. All rights reserved.
//

#import "BLREndGameButtonView.h"

@interface BLREndGameButtonView()

@property (nonatomic, strong) UIColor *buttonColor;

@end

@implementation BLREndGameButtonView

- (id)initWithFrame:(CGRect)frame
              color:(UIColor *)color
{
    self = [super initWithFrame:frame];
    if(self)
    {
        self.backgroundColor = [UIColor clearColor];
        self.buttonColor = color;
        self.layer.cornerRadius = 4.0f;
        self.backgroundColor = color;
    }
    
    return self;
}

@end
