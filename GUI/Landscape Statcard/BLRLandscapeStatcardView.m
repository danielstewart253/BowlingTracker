//
//  BLRLandscapeStatcardView.m
//  Bowlr
//
//  Created by Daniel Stewart on 4/20/17.
//  Copyright © 2017 Daniel Stewart. All rights reserved.
//

#import "BLRLandscapeStatcardView.h"
#import "BLRStatcardValueLabel.h"

@interface BLRLandscapeStatcardView()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet BLRStatcardValueLabel *totalLabel;
@property (weak, nonatomic) IBOutlet BLRStatcardValueLabel *averageLabel;

@end

@implementation BLRLandscapeStatcardView

- (instancetype)initWithTitle:(NSString *)title
                        total:(int)total
                      average:(int)average
{
    self = [[[NSBundle mainBundle] loadNibNamed: bStatCardLine
                                          owner: self
                                        options: nil] firstObject];
    if(self)
    {
        self.titleLabel.text = title;
        self.totalLabel.text = [NSString stringWithFormat: @"%i", total];
        self.averageLabel.text = [NSString stringWithFormat: @"%i", average];
    }
    
    return self;
}

- (void)setTitle:(NSString *)title total:(int)total average:(int)average
{
    self.titleLabel.text = title;
    self.totalLabel.text = [NSString stringWithFormat: @"%i", total];
    self.averageLabel.text = [NSString stringWithFormat: @"%i", average];
}

@end
