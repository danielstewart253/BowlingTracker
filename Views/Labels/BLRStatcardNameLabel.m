//
//  BLRStatcardNameLabel.m
//  Bowlr
//
//  Created by Daniel Stewart on 3/24/17.
//  Copyright © 2017 Daniel Stewart. All rights reserved.
//

#import "BLRStatcardNameLabel.h"

@implementation BLRStatcardNameLabel

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
    self.textColor = [[UIColor alloc] initWithRed: 101.0/255.0 green: 127.0/255.0 blue: 59.0/255.0 alpha: 1.0];
    self.font = [UIFont systemFontOfSize: 15.0f];
    self.adjustsFontSizeToFitWidth = YES;
}

@end
