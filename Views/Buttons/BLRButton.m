//
//  BLRButton.m
//  Bowlr
//
//  Created by Daniel Stewart on 3/27/17.
//  Copyright (c) 2017 Daniel Stewart. All rights reserved.
//

#import "BLRButton.h"

@implementation BLRButton

- (void)setStandardView:(UIView *)standard
        highlightedView:(UIView *)highlightedView
{
    UIImage *standardImage = [standard toImageWithScale: 1
                                                 legacy: YES];
    UIImage *highlightedImage = [highlightedView toImageWithScale: 1
                                                           legacy: YES];
    [self setImage: standardImage
          forState: UIControlStateNormal];
    [self setImage: highlightedImage
          forState: UIControlStateHighlighted];
}

@end
