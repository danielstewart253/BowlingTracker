//
//  AchievementsTableCell.h
//  Bowlr
//
//  Created by Daniel Stewart on 12/17/14.
//  Copyright (c) 2014 Daniel Stewart. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AchievementsTableCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UIImageView *trophyImage;
@property (strong, nonatomic) IBOutlet UIImageView *disclosureArrow;
@property (weak, nonatomic) IBOutlet UIView *disclosureContentView;

- (void)populateCellWithAchievement:(Achievement *)achievement
                        atIndexPath:(NSIndexPath *)indexPath;
- (void)setCellSelectionState:(BOOL)selected;
- (void)animateToDeselectedState;
- (void)animateToSelectedState;

@end
