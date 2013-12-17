//
//  RNSplitViewController.m
//  RayNov
//
//  Created by Mathieu Cordebard on 05/12/2013.
//  Copyright (c) 2013 Mathieu Cordebard. All rights reserved.
//

#import "RNSplitViewController.h"
#import "RNSplitContentView.h"

static NSString* const RNSegueLeftIdentifier = @"rn_left";
static NSString* const RNSegueRightIdentifier = @"rn_right";


#pragma mark - RNSplitViewController Class
@implementation RNSplitViewController

- (void) loadView
{
    // Call each segue separately to load nested viewControllers
    if (self.storyboard && self.leftViewController == nil) {
        @try { [self performSegueWithIdentifier:RNSegueLeftIdentifier sender:nil]; }
        @catch (NSException *exception) {
            NSLog(@"%@", exception);
        }
        @try { [self performSegueWithIdentifier:RNSegueRightIdentifier sender:nil]; }
        @catch (NSException* exception) {
            NSLog(@"%@", exception);
        }
    }
    
    // Set our contentView to the controllers view
    self.view = [[RNSplitContentView alloc] initWithLeftView:self.leftViewController.view
                                              andRightView:self.rightViewController.view];
}

#pragma mark storyboard support

- (void) prepareForSegue:(RNSplitViewControllerSegue*)segue sender:(id)sender
{
    NSString* identifier = segue.identifier;
    if ([segue isKindOfClass:[RNSplitViewControllerSegue class]] && sender == nil) {
        if ([identifier isEqualToString:RNSegueLeftIdentifier]) {
            segue.performBlock = ^(RNSplitViewControllerSegue* rvc_segue, UIViewController* svc, UIViewController* dvc) {
                self.leftViewController = dvc;
                [self addChildViewController:dvc];
            };
        }
        else if ([identifier isEqualToString:RNSegueRightIdentifier] && sender == nil) {
            segue.performBlock = ^(RNSplitViewControllerSegue* rvc_segue, UIViewController* svc, UIViewController* dvc) {
                self.rightViewController = dvc;
                [self addChildViewController:dvc];
            };
        }
    }
}

@end


#pragma mark - RNSplitViewControllerSegue Class

@implementation RNSplitViewControllerSegue

- (void) perform
{
    if (_performBlock != nil) {
        _performBlock(self, self.sourceViewController, self.destinationViewController);
    }
}

@end