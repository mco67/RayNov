//
//  RNViewController.m
//  RayNov
//
//  Created by Mathieu Cordebard on 22/11/2013.
//  Copyright (c) 2013 Mathieu Cordebard. All rights reserved.
//

#import "RNViewController.h"
#import "RNCreateProjectViewController.h"


@interface RNViewController () <RNCreateProjectViewControllerDelegate>

@end


@implementation RNViewController

- (void) viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void) didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) prepareForSegue:(UIStoryboardSegue*)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"AddProject"]) {
        UINavigationController *navigationController = segue.destinationViewController;
        RNCreateProjectViewController* createProjectViewController = [navigationController viewControllers][0];
        createProjectViewController.delegate = self;
    }
}

- (void) createProjectViewControllerDidCancel:(RNCreateProjectViewController*)controller
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void) createProjectViewControllerDidApply:(RNCreateProjectViewController*)controller
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
