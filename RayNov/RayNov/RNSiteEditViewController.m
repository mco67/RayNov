//
//  RNCreateProjectViewController.m
//  RayNov
//
//  Created by Mathieu Cordebard on 25/11/2013.
//  Copyright (c) 2013 Mathieu Cordebard. All rights reserved.
//

#import "RNSiteEditViewController.h"
#import "RNStore+RNSite.h"
#import "RNSite.h"
#import "RNClient.h"
#import "RNAddress.h"


@interface RNSiteEditViewController () <UITextFieldDelegate>

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
@property (nonatomic) BOOL updateMode;

@end


@implementation RNSiteEditViewController

#pragma mark - Controller lifeCycle

- (void) viewDidLoad
{
    self.siteNameErrorLabel.hidden = YES;
    self.siteReferenceErrorLabel.hidden = YES;
    self.applyButton.enabled = [self isFormValid];
    [self.siteName addTarget:self action:@selector(siteNameDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.siteReference addTarget:self action:@selector(siteRefDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    // Update information
    [self updateFromSite:self.site];
    
    [super viewDidLoad];
}

- (void) updateFromSite:(RNSite*)site
{
    // Check if we are in update mode
    self.updateMode = (site != nil);
    
    if (self.updateMode) {
        
        // Update title
        self.navigationItem.title = [NSString stringWithFormat:@"Site %@", self.site.siteName];
        
        // Handle project info
        self.siteName.text = self.site.siteName;
        self.siteReference.text = self.site.siteReference;
        self.siteAddress1.text = self.site.address.postalAddress1;
        self.siteAddress2.text = self.site.address.postalAddress2;
        self.siteTown.text = self.site.address.town;
        self.sitePostalCode.text = self.site.address.postalCode;
        self.siteCountry.text = self.site.address.country;
        
        // Update error label and buttons
        self.siteNameErrorLabel.hidden = YES;
        self.applyButton.enabled = [self isFormValid];
        
        // Lock siteName and siteReference field
        self.siteName.userInteractionEnabled = FALSE;
        self.siteReference.userInteractionEnabled = FALSE;
    }
}


#pragma mark - Handle user actions

- (IBAction) cancel:(id)sender
{
    // Hide the modal view
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction) done:(id)sender
{
    // Fetch key information
    NSString* siteName = self.siteName.text;
    NSString* siteReference = self.siteReference.text;
    
    if (!self.updateMode) {
        // Create and configure the project entity
        NSError* error = nil;
        RNSite* site = [[RNStore instance] createSiteWithSiteName:siteName andSiteReference:siteReference andError:&error];
        if (!site || error) {
            if (error.code == ERROR_DUPLICATE_SITE_NAME) self.siteNameErrorLabel.hidden = NO;
            if (error.code == ERROR_DUPLICATE_SITE_REFERENCE) self.siteReferenceErrorLabel.hidden = NO;
            return;
        }
    }
    
    // Fill address fields
    RNAddress* address = self.site.address;
    address.postalAddress1 = self.siteAddress1.text;
    address.postalAddress2 = self.siteAddress2.text;
    address.town = self.siteTown.text;
    address.postalCode = self.sitePostalCode.text;
    address.country = self.siteCountry.text;
    
    // Store the project entity
    [[RNStore instance] saveContext];
    
    // Send event for site modification in update mode
    if (self.updateMode) {
        [self.delegate onSiteModified:self.site];
    }
    
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
