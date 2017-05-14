//
//  MenuAchievementsViewController.m
//  Bowlr
//
//  Created by Daniel Stewart on 12/27/14.
//  Copyright (c) 2014 Daniel Stewart. All rights reserved.
//

#import "MenuAchievementsViewController.h"

@interface MenuAchievementsViewController ()

@end

@implementation MenuAchievementsViewController

- (id)init
{
    self = [super initWithNibName: bAchievementsVC
                           bundle: nil];
    
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
    return YES;
}

- (BOOL)shouldHideMenuButton
{
    return NO;
}

@end
