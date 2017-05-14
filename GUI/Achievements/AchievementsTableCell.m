//
//  AchievementsTableCell.m
//  Bowlr
//
//  Created by Daniel Stewart on 12/17/14.
//  Copyright (c) 2014 Daniel Stewart. All rights reserved.
//

#import "AchievementsTableCell.h"

@implementation AchievementsTableCell

- (void)populateCellWithAchievement:(Achievement *)achievement
                        atIndexPath:(NSIndexPath *)indexPath
{
    self.titleLabel.text = achievement.title;
    self.dateLabel.text = achievement.achievementWasEarned ? [NSString stringWithFormat: @"Completed %@", achievement.dateEarned] : bIncomplete;
    self.descriptionLabel.text = achievement.achievementWasEarned ? achievement.description : bSecret;
    self.trophyImage.hidden = achievement.achievementWasEarned ? NO : YES;
    
    self.selectedBackgroundView = [[UIView alloc] initWithFrame: CGRectMake(0.0, 0.0, self.frame.size.width, self.frame.size.height)];
    self.selectedBackgroundView.backgroundColor = (indexPath.row % 2 == 0) ? [UIColor BLRAchievementCellMidColor] : [UIColor BLRAchievementCellHighColor];
    self.contentView.backgroundColor = (indexPath.row % 2 == 0) ? [UIColor BLRAchievementCellMidColor] : [UIColor BLRAchievementCellHighColor];
    
    CGFloat labelAlpha = achievement.achievementWasEarned ? 1 : .5;
    self.titleLabel.alpha = labelAlpha;
    self.dateLabel.alpha = labelAlpha;
    self.descriptionLabel.alpha = labelAlpha;
}

- (void)setCellSelectionState:(BOOL)selected
{
    if(selected)
    {
        if(CGAffineTransformIsIdentity(self.disclosureArrow.transform))
        {
            CGAffineTransformRotate(self.disclosureArrow.transform, M_PI_2);
            self.descriptionLabel.alpha = 1.0;
        }
    }
    else
    {
        CGAffineTransform t = CGAffineTransformMakeRotation(M_PI_2);
        if(CGAffineTransformEqualToTransform(self.disclosureArrow.transform, t))
        {
            CGAffineTransformRotate(self.disclosureArrow.transform, -M_PI_2);
            self.descriptionLabel.alpha = 0.5;
        }
    }
}

- (void)animateToDeselectedState
{
    [UIView animateWithDuration: 0.25 animations:^{
        self.descriptionLabel.alpha = 0.0;
        self.disclosureArrow.transform = CGAffineTransformRotate(self.disclosureArrow.transform, -M_PI_2);
    }];
}

- (void)animateToSelectedState
{
    [UIView animateWithDuration: 0.25
                          delay: 0.0
                        options: UIViewAnimationOptionCurveLinear
                     animations:^{
                         self.descriptionLabel.alpha = 1.0;
                         self.disclosureArrow.transform = CGAffineTransformRotate(self.disclosureArrow.transform, M_PI_2);
                     }
                     completion: nil];
}


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    return [super initWithStyle: style reuseIdentifier: reuseIdentifier];
}

@end
