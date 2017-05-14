//
//  BLRLandscapeViewController.m
//  Bowlr
//
//  Created by Daniel Stewart on 8/7/15.
//  Copyright (c) 2015 Daniel Stewart. All rights reserved.
//

#import "BLRLandscapeViewController.h"

@interface BLRLandscapeViewController ()

@end

@implementation BLRLandscapeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    [[NSNotificationCenter defaultCenter] addObserver: self
                                             selector: @selector(orientationChanged:)
                                                 name: UIDeviceOrientationDidChangeNotification
                                               object: [UIDevice currentDevice]];
    
    self.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver: self];
}

- (void)orientationChanged:(NSNotification *)note
{
    UIDevice * device = note.object;
    switch(device.orientation)
    {
        case UIDeviceOrientationPortrait:
        {
            AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
            [delegate.window.rootViewController dismissViewControllerAnimated: YES
                                                                   completion: nil];
        }
            break;
        default:
            break;
    };
}

- (BOOL)shouldAutorotate
{
    return NO;
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

@end
