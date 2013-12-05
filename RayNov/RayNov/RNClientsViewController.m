//
//  RNClientsControllerViewController.m
//  RayNov
//
//  Created by Mathieu Cordebard on 03/12/2013.
//  Copyright (c) 2013 Mathieu Cordebard. All rights reserved.
//

#import "RNClientsViewController.h"
#import <SWRevealViewController/SWRevealViewController.h>

@interface RNClientsViewController ()
@property (weak, nonatomic) IBOutlet UIBarButtonItem* revealButtonItem;


@end

@implementation RNClientsViewController

- (id) initWithNibName:(NSString*)nibNameOrNil bundle:(NSBundle*)nibBundleOrNil
{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        
    }
    return self;
}

- (void) viewDidLoad
{
    [super viewDidLoad];
    
    // Handle menu button behavior
    [self.menuButtonItem setTarget: self.revealViewController];
    [self.menuButtonItem setAction: @selector(revealToggle:)];
}

- (void) didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
