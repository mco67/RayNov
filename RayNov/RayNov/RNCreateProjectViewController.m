//
//  RNCreateProjectViewController.m
//  RayNov
//
//  Created by Mathieu Cordebard on 25/11/2013.
//  Copyright (c) 2013 Mathieu Cordebard. All rights reserved.
//

#import "RNCreateProjectViewController.h"

@interface RNCreateProjectViewController ()

@end

@implementation RNCreateProjectViewController

- (id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void) viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void) didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction) cancel:(id)sender
{
    [self.delegate createProjectViewControllerDidCancel:self];
}

- (IBAction) done:(id)sender
{
    [self.delegate createProjectViewControllerDidApply:self];
}

@end
