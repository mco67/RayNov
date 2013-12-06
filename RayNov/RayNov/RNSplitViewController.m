//
//  RNSplitViewController.m
//  RayNov
//
//  Created by Mathieu Cordebard on 05/12/2013.
//  Copyright (c) 2013 Mathieu Cordebard. All rights reserved.
//

#import "RNSplitViewController.h"
#import "RNSplitContentView.h"

#pragma mark - RNSplitViewController Class

@interface RNSplitViewController ()

@property (strong, nonatomic) UIViewController* menuViewController;
@property (strong, nonatomic) UIViewController* detailsViewController;

@end

@implementation RNSplitViewController

- (id) initWithCoder:(NSCoder*)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        
    }
    return self;
}

- (void) loadView
{
    // Call each segue separately to load nested viewControllers
    if (self.storyboard && self.menuViewController == nil) {
        @try { [self performSegueWithIdentifier:RNSegueMenuIdentifier sender:nil]; }
        @catch (NSException *exception) {}
        @try { [self performSegueWithIdentifier:RNSegueDetailsIdentifier sender:nil]; }
        @catch (NSException* exception) {}
    }
    
    // Set our contentView to the controllers view
    self.view = [[RNSplitContentView alloc] initWithMenuView:self.menuViewController.view
                                              andDetailsView:self.detailsViewController.view];
    
}

#pragma mark storyboard support

static NSString* const RNSegueMenuIdentifier = @"rn_menu";
static NSString* const RNSegueDetailsIdentifier = @"rn_details";

- (void) prepareForSegue:(RNSplitViewControllerSegue*)segue sender:(id)sender
{
    NSString* identifier = segue.identifier;
    if ([segue isKindOfClass:[RNSplitViewControllerSegue class]] && sender == nil) {
        if ([identifier isEqualToString:RNSegueMenuIdentifier]) {
            segue.performBlock = ^(RNSplitViewControllerSegue* rvc_segue, UIViewController* svc, UIViewController* dvc) {
                self.menuViewController = dvc;
                [self addChildViewController:dvc];
            };
        }
        else if ([identifier isEqualToString:RNSegueDetailsIdentifier] && sender == nil) {
            segue.performBlock = ^(RNSplitViewControllerSegue* rvc_segue, UIViewController* svc, UIViewController* dvc) {
                self.detailsViewController = dvc;
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