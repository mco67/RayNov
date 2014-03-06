//
//  RNRotateViewController.m
//  RayNov
//
//  Created by Mathieu Cordebard on 30/12/2013.
//  Copyright (c) 2013 Mathieu Cordebard. All rights reserved.
//

#import "RNRotateViewController.h"
#import "RNRotateContentView.h"


@implementation RNRotateViewController


static NSString* const RNSegueFrontIdentifier = @"rn_front";
static NSString* const RNSegueRearIdentifier = @"rn_rear";


- (void) loadView
{
    // Call each segue separately to load nested viewControllers
    if (self.storyboard && self.frontViewController == nil) {
        @try { [self performSegueWithIdentifier:RNSegueFrontIdentifier sender:nil]; }
        @catch (NSException *exception) {
            NSLog(@"%@", exception);
        }
        @try { [self performSegueWithIdentifier:RNSegueRearIdentifier sender:nil]; }
        @catch (NSException* exception) {
            NSLog(@"%@", exception);
        }
    }
    
    // Set our contentView to the controllers view 
    self.view = [[RNRotateContentView alloc] initWithFrontView:self.frontViewController.view
                                                andRearView:self.rearViewController.view];
}

- (void) rotateViews
{
    RNRotateContentView* rotateContentView = (RNRotateContentView*)self.view;
    [rotateContentView rotateViews];
}


#pragma mark storyboard support
- (void) prepareForSegue:(RNRotateViewControllerSegue*)segue sender:(id)sender
{
    NSString* identifier = segue.identifier;
    if ([segue isKindOfClass:[RNRotateViewControllerSegue class]] && sender == nil) {
        if ([identifier isEqualToString:RNSegueFrontIdentifier]) {
            segue.performBlock = ^(RNRotateViewControllerSegue* rvc_segue, UIViewController* svc, UIViewController* dvc) {
                self.frontViewController = dvc;
                [self addChildViewController:dvc];
            };
        }
        else if ([identifier isEqualToString:RNSegueRearIdentifier] && sender == nil) {
            segue.performBlock = ^(RNRotateViewControllerSegue* rvc_segue, UIViewController* svc, UIViewController* dvc) {
                self.rearViewController = dvc;
                [self addChildViewController:dvc];
            };
        }
    }
}

@end


#pragma mark - RNRotateViewControllerSegue Class

@implementation RNRotateViewControllerSegue

- (void) perform
{
    if (_performBlock != nil) {
        _performBlock(self, self.sourceViewController, self.destinationViewController);
    }
}

@end
