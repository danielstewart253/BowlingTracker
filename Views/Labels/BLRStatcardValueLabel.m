//
//  BLRStatcardValueLabel.m
//  Bowlr
//
//  Created by Daniel Stewart on 3/24/17.
//  Copyright © 2017 Daniel Stewart. All rights reserved.
//

#import "BLRStatcardValueLabel.h"

@implementation BLRStatcardValueLabel

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    if(self)
    {
        [self labelSetup];
    }
    
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        [self labelSetup];
    }
    
    return self;
}

- (void)labelSetup
{
    self.backgroundColor = [UIColor clearColor];
    self.textColor = [UIColor whiteColor];
    self.font = [UIFont boldSystemFontOfSize: 15.0f];
    self.textAlignment = NSTextAlignmentCenter;
    self.adjustsFontSizeToFitWidth = YES;
}

@end
