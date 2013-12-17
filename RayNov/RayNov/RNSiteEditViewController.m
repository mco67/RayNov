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
#import "RNSiteClientTableViewController.h"
#import "RNClientEditViewController.h"
#import "RNStore+RNClient.h"

@interface RNSiteEditViewController ()

@property (weak, nonatomic) IBOutlet UITextField* siteName;
@property (weak, nonatomic) IBOutlet UILabel* siteNameErrorLabel;
@property (weak, nonatomic) IBOutlet UITextField* siteReference;
@property (weak, nonatomic) IBOutlet UILabel* siteReferenceErrorLabel;
@property (weak, nonatomic) IBOutlet UITextField* siteAddress1;
@property (weak, nonatomic) IBOutlet UITextField* siteAddress2;
@property (weak, nonatomic) IBOutlet UITextField* siteTown;
@property (weak, nonatomic) IBOutlet UITextField* sitePostalCode;
@property (weak, nonatomic) IBOutlet UITextField* siteCountry;
@property (weak, nonatomic) IBOutlet UILabel* siteClient;
@property (weak, nonatomic) IBOutlet UIBarButtonItem* rightButton;
@property (weak, nonatomic) UIPopoverController* attachClientPopoverController;
@end


@implementation RNSiteEditViewController

#pragma mark - Controller lifeCycle

- (void) viewDidLoad
{
    [super viewDidLoad];
    
    // Set event handlers
    [self.siteName addTarget:self action:@selector(siteNameDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.siteReference addTarget:self action:@selector(siteRefDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    // Update form fields
    [self updateFields];
}

- (void) updateFields
{
    // Specific settings in modification mode
    if (!IsNullOrEmpty(self.site.siteName) && !IsNullOrEmpty(self.site.siteReference))
    {
        // Update title
        self.navigationItem.title = [NSString stringWithFormat:@"Site %@", self.site.siteName];
        
        // Lock lastName and firstname field
        self.siteName.userInteractionEnabled = FALSE;
        self.siteReference.userInteractionEnabled = FALSE;
    }
    
    // Update fields
    self.siteName.text = self.site.siteName;
    self.siteReference.text = self.site.siteReference;
    self.siteAddress1.text = self.site.address.postalAddress1;
    self.siteAddress2.text = self.site.address.postalAddress2;
    self.siteTown.text = self.site.address.town;
    self.sitePostalCode.text = self.site.address.postalCode;
    self.siteCountry.text = self.site.address.country;
    self.siteClient.text = self.site.client.displayName;
    
    // Update error label and buttons
    self.siteNameErrorLabel.hidden = YES;
    self.siteReferenceErrorLabel.hidden = YES;
    self.rightButton.enabled = [self isFormValid];
}


#pragma mark - Buttons action handling

- (IBAction) onLeftButtonTap:(id)sender
{
    // Execute left button block
    self.leftButtonBlock(self.site);
}

- (IBAction) onRightButtonTap:(id)sender
{
    // Fill site identifiers
    self.site.siteName = self.siteName.text;
    self.site.siteReference = self.siteReference.text;
    
    // Fill address fields
    RNAddress* address = self.site.address;
    address.postalAddress1 = self.siteAddress1.text;
    address.postalAddress2 = self.siteAddress2.text;
    address.town = self.siteTown.text;
    address.postalCode = self.sitePostalCode.text;
    address.country = self.siteCountry.text;
    
    // Execute left button block
    self.rightButtonBlock(self.site);
}


#pragma mark - Private methods

- (void) siteNameDidChange:(UITextField*)textField
{
    NSString* siteName = self.siteName.text;
    self.siteNameErrorLabel.hidden = [[RNStore instance] checkSiteNameUnicity:siteName];
    self.rightButton.enabled = [self isFormValid];
}

- (void) siteRefDidChange:(UITextField*)textField
{
    NSString* siteRef = self.siteReference.text;
    self.siteReferenceErrorLabel.hidden = [[RNStore instance] checkSiteReferenceUnicity:siteRef];
    self.rightButton.enabled = [self isFormValid];
}

- (BOOL) isFormValid
{
    return !IsNullOrEmpty(self.siteName.text) && !IsNullOrEmpty(self.siteReference.text) && !IsNullOrEmpty(self.site.client);
}



#pragma mark - segue management

- (void) prepareForSegue:(UIStoryboardSegue*)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"siteAttachClient"]) {
        
        // Store popover controller
        self.attachClientPopoverController = ((UIStoryboardPopoverSegue*)segue).popoverController;
        
        UINavigationController* navigationController = (UINavigationController*)segue.destinationViewController;
        RNSiteClientTableViewController* siteClientTableViewController = (RNSiteClientTableViewController*)navigationController.viewControllers[0];
        
        // Configure the cell selected block
        siteClientTableViewController.cellSelectedBlock = ^(RNClient* client)
        {
            self.site.client = client;
            self.siteClient.textColor = [UIColor blackColor];
            self.siteClient.text = client.displayName;
            self.rightButton.enabled = [self isFormValid];
            [self.attachClientPopoverController dismissPopoverAnimated:YES];
        };
    }
    else if ([segue.identifier isEqualToString:@"siteCreateModifyClient"]) {
        
        // Fetch or create the client
        RNClient* client = self.site.client?self.site.client:[[RNStore instance] createClient];;
        
        // Configure RNClientEditViewController
        RNClientEditViewController* clientEditViewController = (RNClientEditViewController*)segue.destinationViewController;
        clientEditViewController.client = client;
        
        // Configure action on leftButton (Back)
        clientEditViewController.leftButtonBlock = ^(RNClient* client)
        {
            [[RNStore instance] deleteClient:client];
            self.site.client = nil;
            self.rightButton.enabled = [self isFormValid];
            [self.navigationController popViewControllerAnimated:YES];
        };
        
        // Configure action on leftButton (Done)
        clientEditViewController.rightButtonBlock = ^(RNClient* client)
        {
            self.site.client = client;
            self.siteClient.textColor = [UIColor blackColor];
            self.siteClient.text = client.displayName;
            self.rightButton.enabled = [self isFormValid];
            [self.navigationController popViewControllerAnimated:YES];
        };
    }
}

@end
