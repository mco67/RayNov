//
//  RNCreateProjectViewController.m
//  RayNov
//
//  Created by Mathieu Cordebard on 25/11/2013.
//  Copyright (c) 2013 Mathieu Cordebard. All rights reserved.
//

#import "RNProjectInfoViewController.h"
#import "RNStore+RNProject.h"
#import "RNProject.h"
#import "RNClient.h"
#import "RNAddress.h"


@interface RNProjectInfoViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField* siteName;
@property (weak, nonatomic) IBOutlet UILabel* siteNameErrorLabel;
@property (weak, nonatomic) IBOutlet UITextField* siteReference;
@property (weak, nonatomic) IBOutlet UILabel* siteReferenceErrorLabel;
@property (weak, nonatomic) IBOutlet UITextField* siteAddress1;
@property (weak, nonatomic) IBOutlet UITextField* siteAddress2;
@property (weak, nonatomic) IBOutlet UITextField* siteTown;
@property (weak, nonatomic) IBOutlet UITextField* sitePostalCode;
@property (weak, nonatomic) IBOutlet UITextField* siteCountry;
@property (weak, nonatomic) IBOutlet UIBarButtonItem* applyButton;

@end


@implementation RNProjectInfoViewController

#pragma mark - Controller lifeCycle

- (void) viewDidLoad
{
    self.siteNameErrorLabel.hidden = YES;
    self.siteReferenceErrorLabel.hidden = YES;
    self.applyButton.enabled = [self isFormValid];
    [self.siteName addTarget:self action:@selector(siteNameDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.siteReference addTarget:self action:@selector(siteRefDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    // Update information
    if (self.project) {
        
        // Update title
        self.navigationItem.title = [NSString stringWithFormat:@"Site %@", self.project.siteName];
        
        // Handle project info
        self.siteName.text = self.project.siteName;
        self.siteReference.text = self.project.siteReference;
        self.siteAddress1.text = self.project.address.postalAddress1;
        self.siteAddress2.text = self.project.address.postalAddress2;
        self.siteTown.text = self.project.address.town;
        self.sitePostalCode.text = [self.project.address.postalCode stringValue];
        self.siteCountry.text = self.project.address.country;
    }
    [super viewDidLoad];
}

#pragma mark - Handle user actions

- (IBAction) cancel:(id)sender
{
    // Hide the modal view
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction) done:(id)sender
{
    // Create and configure the project entity
    NSError* error = nil;
    RNProject* project = [[RNStore instance] createProjectWithSiteName:self.siteName.text andSiteReference:self.siteReference.text andError:&error];
    if (!project || error) {
        if (error.code == ERROR_DUPLICATE_SITE_NAME) self.siteNameErrorLabel.hidden = NO;
        if (error.code == ERROR_DUPLICATE_SITE_REFERENCE) self.siteReferenceErrorLabel.hidden = NO;
        return;
    }
    
    // Fill address fields
    RNAddress* address = self.project.address;
    address.postalAddress1 = self.siteAddress1.text;
    address.postalAddress2 = self.siteAddress2.text;
    address.town = self.siteTown.text;
    address.postalCode =  [NSNumber numberWithInt:[self.sitePostalCode.text intValue]];
    address.country = self.siteCountry.text;
    
    // Store the project entity
    [[RNStore instance] saveContext];
    
    // Hide the modal view
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void) siteNameDidChange:(UITextField*)textField
{
    self.siteNameErrorLabel.hidden = YES;
    self.applyButton.enabled = [self isFormValid];
}

- (void) siteRefDidChange:(UITextField*)textField
{
    self.siteReferenceErrorLabel.hidden = YES;
    self.applyButton.enabled = [self isFormValid];
}

- (BOOL) isFormValid
{
    return !IsNullOrEmpty(self.siteName.text) && !IsNullOrEmpty(self.siteReference.text);
}

@end
