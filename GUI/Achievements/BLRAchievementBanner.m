//
//  BLRAchievementBanner.m
//  Bowlr
//
//  Created by Daniel Stewart on 3/13/17.
//  Copyright © 2017 Daniel Stewart. All rights reserved.
//

#import "BLRAchievementBanner.h"

@implementation BLRAchievementBanner

- (id)init
{
    self = [super initWithFrame:CGRectMake(0, 0, 240, 55)];
    if(self)
    {        
        self.backgroundColor = [UIColor BLRAchievementBannerBackgroundColor];
        [self.layer setCornerRadius:8.75f];
        [self.layer setBorderColor:[UIColor BLRAchievementBannerBorderColor].CGColor];
        [self.layer setBorderWidth:3.25f];
        
        UIImageView *trophy1 = [[UIImageView alloc]init];
        trophy1.frame = CGRectMake(8.0, 12.5, 25.0, 30.0);
        trophy1.image = [UIImage imageNamed:bAchievementTrophy];
        
        UIImageView *trophy2 = [[UIImageView alloc]init];
        trophy2.frame = CGRectMake(208.0, 12.5, 25.0, 30.0);
        trophy2.image = [UIImage imageNamed:bAchievementTrophy];
        
        [self addSubview:trophy1];
        [self addSubview:trophy2];
        
        UILabel *completionLabel = [[UILabel alloc]init];
        completionLabel.frame = CGRectMake(42.5, 5.0, 155.0, 22.5);
        completionLabel.backgroundColor = [UIColor clearColor];
        completionLabel.font = [UIFont systemFontOfSize:12.5];
        completionLabel.textColor = [UIColor whiteColor];
        completionLabel.textAlignment = NSTextAlignmentCenter;
        completionLabel.text = bAchievementCompleted;
        [self addSubview:completionLabel];
        
        UILabel *descriptionLabel = [[UILabel alloc]init];
        descriptionLabel.tag = 28;
        descriptionLabel.frame = CGRectMake(35.0, 20.0, 170.0, 30.0);
        descriptionLabel.backgroundColor = [UIColor clearColor];
        descriptionLabel.font = [UIFont boldSystemFontOfSize:16.5];
        descriptionLabel.textColor = [UIColor BLRAchievementBannerTextColor];
        descriptionLabel.textAlignment = NSTextAlignmentCenter;
        descriptionLabel.text = bBackFromTheDead;
        [self addSubview:descriptionLabel];
    }
    
    return self;
}

@end
