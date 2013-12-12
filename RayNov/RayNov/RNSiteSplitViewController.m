//
//  RNSiteSplitViewController.m
//  RayNov
//
//  Created by Mathieu Cordebard on 11/12/2013.
//  Copyright (c) 2013 Mathieu Cordebard. All rights reserved.
//

#import "RNSiteSplitViewController.h"
#import "RNSiteTableViewController.h"
#import "RNSiteDetailsViewController.h"
#import <SWRevealViewController/SWRevealViewController.h>

@interface RNSiteSplitViewController ()

@property (weak, nonatomic) IBOutlet UIBarButtonItem* menuButtonItem;

@end

@implementation RNSiteSplitViewController

- (void) viewDidLoad
{
    [super viewDidLoad];
    
    // Handle left and right child viewControllers
    RNSiteTableViewController* menuController = (RNSiteTableViewController*)self.leftViewController;
    RNSiteDetailsViewController* detailsController = (RNSiteDetailsViewController*)self.rightViewController;
    menuController.delegate = detailsController;
    
    // Handle Button behavior
    [self.menuButtonItem setTarget: self.revealViewController];
    [self.menuButtonItem setAction: @selector(revealToggle:)];
    
    // Add gesture recognizer
    [self.navigationController.navigationBar addGestureRecognizer: self.revealViewController.panGestureRecognizer];
}


@end
