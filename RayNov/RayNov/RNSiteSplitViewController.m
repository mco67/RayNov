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
#import "RNSiteEditViewController.h"
#import "RNStore+RNSite.h"

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

    menuController.cellSelectedBlock = ^(RNSite* site)
    {
        detailsController.site = site;
    };
    
    // Handle Button behavior
    [self.menuButtonItem setTarget: self.revealViewController];
    [self.menuButtonItem setAction: @selector(revealToggle:)];
    
    // Add gesture recognizer
    [self.navigationController.navigationBar addGestureRecognizer: self.revealViewController.panGestureRecognizer];
}


#pragma mark - segue management

- (void) prepareForSegue:(UIStoryboardSegue*)segue sender:(id)sender
{
    [super prepareForSegue:segue sender:sender];
    
    if ([segue.identifier isEqualToString:@"createNewSite"])
    {
        // Create the new RNSite object;
        RNSite* newSite = [[RNStore instance] createSite];

        // Fetch and configure the destination view controller
        UINavigationController* navigationController = (UINavigationController*)segue.destinationViewController;
        RNSiteEditViewController* siteEditViewController = (RNSiteEditViewController*)navigationController.viewControllers[0];
        siteEditViewController.site = newSite;
        
        // Configure action on leftButton (Cancel)
        siteEditViewController.leftButtonBlock = ^(RNSite* site) {
            [[RNStore instance] deleteSite:site];
            [self dismissViewControllerAnimated:YES completion:nil];
        };
        
        // Configure action on rightButton (Done)
        siteEditViewController.rightButtonBlock = ^(RNSite* site) {
            [[RNStore instance] saveContext];
            RNSiteDetailsViewController* siteDetailsViewController = (RNSiteDetailsViewController*)self.rightViewController;
            siteDetailsViewController.site = site;
            [self dismissViewControllerAnimated:YES completion:nil];
        };
    }
}


@end
