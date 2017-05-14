//
//  InGameAchievementsViewController.m
//  Bowlr
//
//  Created by Daniel Stewart on 12/27/14.
//  Copyright (c) 2014 Daniel Stewart. All rights reserved.
//

#import "InGameAchievementsViewController.h"

@interface InGameAchievementsViewController ()

@end

@implementation InGameAchievementsViewController

- (id)init
{
    self = [super initWithNibName: bAchievementsVC bundle:nil];
    
    if(!self)
    {
        return nil;
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (BOOL)shouldHideResumeButton
{
    return NO;
}

- (BOOL)shouldHideMenuButton
{
    return YES;
}

@end
