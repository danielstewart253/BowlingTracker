//
//  UIImage+BLRImage.h
//  Bowlr
//
//  Created by Daniel Stewart on 12/11/14.
//  Copyright (c) 2014 Daniel Stewart. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (BLRImage)

+ (UIImage *)imageWithColor:(UIColor *)color;
+ (UIImage *)imageFromView:(UIView*)view;

@end
