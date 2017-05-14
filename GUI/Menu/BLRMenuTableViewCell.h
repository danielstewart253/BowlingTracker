//
//  BLRMenuTableViewCell.h
//  Bowlr
//
//  Created by Daniel Stewart on 7/19/15.
//  Copyright (c) 2015 Daniel Stewart. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BLRMenuTableViewCell : UITableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style
              reuseIdentifier:(NSString *)reuseIdentifier
                    indexPath:(NSIndexPath *)indexPath;

@end
