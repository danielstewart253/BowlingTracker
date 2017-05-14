//
//  MenuEditTableView.h
//  Bowlr
//
//  Created by Daniel Stewart on 12/9/14.
//  Copyright (c) 2014 Daniel Stewart. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

@class MenuEditTableView;

@protocol MenuEditTableViewDelegate <NSObject, UITableViewDelegate>

@optional

// Allows customization of the target row for a particular row as it is being moved
- (NSIndexPath *)moveTableView:(MenuEditTableView *)tableView
targetIndexPathForMoveFromRowAtIndexPath:(NSIndexPath *)sourceIndexPath
           toProposedIndexPath:(NSIndexPath *)proposedDestinationIndexPath;

// Called before the particular row is about to change to a moving state
- (void)moveTableView:(MenuEditTableView *)tableView
willMoveRowAtIndexPath:(NSIndexPath *)indexPath;

@end

@protocol MenuEditTableViewDataSource <NSObject, UITableViewDataSource>

// Called after the particular row is being dropped to it's new index path
- (void)moveTableView:(MenuEditTableView *)tableView
 moveRowFromIndexPath:(NSIndexPath *)fromIndexPath
          toIndexPath:(NSIndexPath *)toIndexPath;

@optional

// Allows to reorder a particular row
- (BOOL)moveTableView:(MenuEditTableView *)tableView
canMoveRowAtIndexPath:(NSIndexPath *)indexPath;

@end


@interface MenuEditTableView : UITableView <UIGestureRecognizerDelegate>

@property (nonatomic, weak) id <MenuEditTableViewDataSource> dataSource;
@property (nonatomic, weak) id <MenuEditTableViewDelegate> delegate;
@property (nonatomic, strong) NSIndexPath *movingIndexPath;
@property (nonatomic, strong) NSIndexPath *initialIndexPathForMovingRow;
@property (nonatomic) BOOL inEditMode;
- (void)deleteRow:(NSIndexPath *)indexPath;
- (void)reloadSection:(NSInteger)section;
- (BOOL)indexPathIsMovingIndexPath:(NSIndexPath *)indexPath;

- (NSIndexPath *)adaptedIndexPathForRowAtIndexPath:(NSIndexPath *)indexPath;

@end
