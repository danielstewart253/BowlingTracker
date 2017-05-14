//
//  BLRLandscapeStatcardView.h
//  Bowlr
//
//  Created by Daniel Stewart on 4/20/17.
//  Copyright © 2017 Daniel Stewart. All rights reserved.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE

@interface BLRLandscapeStatcardView : UIView

- (instancetype)initWithTitle:(NSString *)title
                        total:(int)total
                      average:(int)average;

- (void)setTitle:(NSString *)title total:(int)total average:(int)average;

@end
