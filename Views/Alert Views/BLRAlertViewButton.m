//
//  BLRAlertViewButton.m
//  Bowlr
//
//  Created by Daniel Stewart on 3/24/17.
//  Copyright © 2017 Daniel Stewart. All rights reserved.
//

#import "BLRAlertViewButton.h"

@implementation BLRAlertViewButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame: frame];
    if(self)
    {
        [self setBackgroundImage: [UIImage imageWithColor: [UIColor BLRAlertViewButtonHighlightColor]]
                        forState: UIControlStateHighlighted];
    }
    
    return self;
}

@end
