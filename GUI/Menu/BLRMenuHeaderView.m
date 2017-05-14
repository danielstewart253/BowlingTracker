//
//  BLRMenuHeaderView.m
//  Bowlr
//
//  Created by Daniel Stewart on 5/2/17.
//  Copyright © 2017 Daniel Stewart. All rights reserved.
//

#import "BLRMenuHeaderView.h"

@interface BLRMenuHeaderView()

@property (weak, nonatomic) IBOutlet UILabel *headerLabel;

@end

@implementation BLRMenuHeaderView

- (void)setText:(NSString *)headerText
{
    self.headerLabel.text = headerText;
}

@end
