//
//  RNClientsControllerViewController.m
//  RayNov
//
//  Created by Mathieu Cordebard on 03/12/2013.
//  Copyright (c) 2013 Mathieu Cordebard. All rights reserved.
//

#import "RNClientsSplitViewController.h"
#import <SWRevealViewController/SWRevealViewController.h>
#import "RNClientTableViewController.h"
#import "RNClientDetailsViewController.h"


@interface RNClientsSplitViewController ()

@property (weak, nonatomic) IBOutlet UIBarButtonItem* menuButtonItem;

@end

@implementation RNClientsSplitViewController


- (void) viewDidLoad
{
    [super viewDidLoad];
    
    // Handle left and right child viewControllers
    RNClientTableViewController* menuController = (RNClientTableViewController*)self.leftViewController;
    RNClientDetailsViewController* detailsController = (RNClientDetailsViewController*)self.rightViewController;
    menuController.delegate = detailsController;
    
    // Handle Button behavior
    [self.menuButtonItem setTarget: self.revealViewController];
    [self.menuButtonItem setAction: @selector(revealToggle:)];
    
    // Add gesture recognizer
    [self.navigationController.navigationBar addGestureRecognizer: self.revealViewController.panGestureRecognizer];
}

@end
