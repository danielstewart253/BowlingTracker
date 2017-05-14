//
//  BLRActivityViewController.m
//  Bowlr
//
//  Created by Daniel Stewart on 4/9/17.
//  Copyright © 2017 Daniel Stewart. All rights reserved.
//

#import "BLRActivityViewController.h"

@interface BLRActivityViewController ()

@end

@implementation BLRActivityViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (UIDeviceOrientation)currentOrientation
{
    return [[UIDevice currentDevice] orientation];
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return UIInterfaceOrientationLandscapeRight;
}

@end
