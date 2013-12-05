//
//  RNMenuViewController.m
//  RayNov
//
//  Created by Mathieu Cordebard on 29/11/2013.
//  Copyright (c) 2013 Mathieu Cordebard. All rights reserved.
//

#import "RNMenuViewController.h"
#import <SWRevealViewController/SWRevealViewController.h>

@implementation RNMenuViewController

#pragma mark - Segue managment

- (void) prepareForSegue:(UIStoryboardSegue*)segue sender:(id)sender
{
    if ([segue isKindOfClass:[SWRevealViewControllerSegue class]]) {
        SWRevealViewControllerSegue* revealViewControllerSegue = (SWRevealViewControllerSegue*)segue;
        SWRevealViewController* revealViewController = self.revealViewController;
        
        
        revealViewControllerSegue.performBlock = ^(SWRevealViewControllerSegue* rvc_segue, UIViewController* svc, UIViewController* dvc) {
            //UINavigationController* nc = [[UINavigationController alloc] initWithRootViewController:dvc];
            [revealViewController setFrontViewController:dvc animated:YES];
        };
    }

    // Restore the frontViewController in full screen
    //[self.revealViewController setFrontViewController:self.revealViewController.frontViewController animated:YES];
}

@end
