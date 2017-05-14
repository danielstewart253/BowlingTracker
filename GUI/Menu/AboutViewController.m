//
//  AboutViewController.m
//  Bowlr
//
//  Created by Daniel Stewart on 12/12/14.
//  Copyright (c) 2014 Daniel Stewart. All rights reserved.
//

#import "AboutViewController.h"

@interface AboutViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *aboutBackgroundImage;
@property (weak, nonatomic) IBOutlet UIButton *aboutBackButton;
@property (weak, nonatomic) IBOutlet UITableView *aboutTable;

@end

@implementation AboutViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

#pragma - mark UITableview Setup
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier = @"CustomCell";

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }

    cell.textLabel.textColor = [UIColor BLRAboutViewCellTextColor];
    cell.textLabel.font = [UIFont systemFontOfSize:18.0];
    cell.selectionStyle = UITableViewCellSelectionStyleBlue;
    cell.textLabel.highlightedTextColor = [UIColor BLRAboutViewCellTextHighlightColor];
    
    // Alternate background colors of each cell
    if(indexPath.row %2 == 0)
    {
        cell.contentView.backgroundColor = [UIColor BLRAboutViewCellMidColor];
    }
    else if(indexPath.row %2 == 1)
    {
        cell.contentView.backgroundColor = [UIColor BLRAboutViewCellHighColor];
    }
    
    cell.textLabel.backgroundColor = cell.contentView.backgroundColor;
    
    // Set up highlighted background view
    UIView *highlightBackgroundView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, cell.frame.size.width, cell.frame.size.height)];
    highlightBackgroundView.backgroundColor = cell.contentView.backgroundColor;
    cell.selectedBackgroundView = highlightBackgroundView;
    
    // The title for each cell
    if(indexPath.row == 0)
    {
        cell.textLabel.text = @"Visit our website";
    }
    else if(indexPath.row == 1)
    {
        cell.textLabel.text = @"Follow us on Twitter";
    }
    else if(indexPath.row == 2)
    {
        cell.textLabel.text = @"Like us on Facebook";
    }
    
    return cell;
}

// Selection of any cell will open web browser to the specified website
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *url;
    
    switch (indexPath.row) {
        case 0:
            url = @"http://www.twosixjuliet.com";
            break;
        case 1:
            url = @"http://twitter.com/twosixjulietinc";
            break;
        case 2:
            url = @"http://facebook.com/twosixjulietinc";
            break;
        default:
            break;
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url] options: [NSDictionary new] completionHandler: nil];
}

// Returns the number of sections in the table
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

// Returns the number of rows for each section
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

// Sets the height for each cell
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45;
}

- (IBAction)backButtonAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
