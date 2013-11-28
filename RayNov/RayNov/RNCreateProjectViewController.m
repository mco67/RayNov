//
//  RNCreateProjectViewController.m
//  RayNov
//
//  Created by Mathieu Cordebard on 25/11/2013.
//  Copyright (c) 2013 Mathieu Cordebard. All rights reserved.
//

#import "RNCreateProjectViewController.h"
#import "RNProjectStore.h"
#import "RNProject.h"

@interface RNCreateProjectViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField* projectName;
@property (weak, nonatomic) IBOutlet UILabel* projectNameErrorLabel;
@property (weak, nonatomic) IBOutlet UITextField* clientName;
@property (weak, nonatomic) IBOutlet UIBarButtonItem* applyButton;

@end


@implementation RNCreateProjectViewController

#pragma mark - Controller lifeCycle

- (id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
    }
    return self;
}

- (void) viewDidLoad
{
    self.projectNameErrorLabel.hidden = YES;
    self.applyButton.enabled = [self isFormValid];
    [self.projectName addTarget:self action:@selector(projectNameDidChange:) forControlEvents:UIControlEventEditingChanged];
    [super viewDidLoad];
}

- (void) didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


#pragma mark - Handle user actions

- (IBAction) cancel:(id)sender
{
    [self.delegate createProjectViewControllerDidCancel:self];
}

- (IBAction) done:(id)sender
{
    // Create and configure the project entity
    NSError* error = nil;
    RNProject* project = [[RNProjectStore instance] createProjectWithName:self.projectName.text andError:&error];
    if (!project || error) {
        self.projectNameErrorLabel.hidden = NO;
        return;
    }
    project.clientName = self.clientName.text;
    
    // Store the project entity
    [[RNProjectStore instance] saveContext];
    
    // Call parentController delegate
    [self.delegate createProjectViewControllerDidApply:self];
}


- (void) projectNameDidChange:(UITextField*)textField
{
    self.projectNameErrorLabel.hidden = YES;
    self.applyButton.enabled = [self isFormValid];
}

- (BOOL) isFormValid
{
    return !IsNullOrEmpty(self.projectName.text);
}

@end
