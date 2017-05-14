//
//  BLRLandscapeOptionViewController.m
//  Bowlr
//
//  Created by Daniel Stewart on 8/8/15.
//  Copyright (c) 2015 Daniel Stewart. All rights reserved.
//

#import "BLRLandscapeOptionViewController.h"
#import "BLRLandscapeScorecardViewController.h"
#import "BLRLandscapeStatcardViewController.h"

@interface BLRLandscapeOptionViewController ()

@property (nonatomic, strong) BLRLandscapeScorecardViewController *scorecardView;
@property (nonatomic, strong) BLRLandscapeStatcardViewController *statcardView;

@end

@implementation BLRLandscapeOptionViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear: animated];
    
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    [[NSNotificationCenter defaultCenter] addObserver: self
                                             selector: @selector(orientationChanged:)
                                                 name: UIDeviceOrientationDidChangeNotification
                                               object: [UIDevice currentDevice]];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear: animated];
    [[NSNotificationCenter defaultCenter] removeObserver: self];
}

- (void)orientationChanged:(NSNotification *)note
{
    UIDevice * device = note.object;
    switch(device.orientation)
    {
        case UIDeviceOrientationLandscapeLeft:
        {
            self.scorecardView = [[BLRLandscapeScorecardViewController alloc] initWithNibName: bLandscapeScorecardVC
                                                                                    bundle: nil
                                                                               gameManager: self.gameManager
                                                                            stateProcessor: nil];

            AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
            [delegate.window.rootViewController presentViewController: self.scorecardView
                                                             animated: YES
                                                           completion: nil];
            break;
        }
        case UIDeviceOrientationLandscapeRight:
        {
            self.statcardView = [[BLRLandscapeStatcardViewController alloc] initWithNibName: bLandscapeStatcardVC
                                                                                  bundle: nil];
            
            AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
            [delegate.window.rootViewController presentViewController: self.statcardView
                                                             animated: YES
                                                           completion: nil];
            break;
        }
        default:
            break;
    }
}

@end
