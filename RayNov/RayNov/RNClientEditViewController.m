//
//  RNClientEditViewController.m
//  RayNov
//
//  Created by Mathieu Cordebard on 02/12/2013.
//  Copyright (c) 2013 Mathieu Cordebard. All rights reserved.
//

#import "RNClientEditViewController.h"
#import "RNClientTableViewController.h"
#import "RNStore+RNClient.h"
#import "RNClient.h"
#import "RNAddress.h"


@interface RNClientEditViewController ()

@property (weak, nonatomic) IBOutlet UITextField* clientLastName;
@property (weak, nonatomic) IBOutlet UITextField* clientFirstName;
@property (weak, nonatomic) IBOutlet UITextField* clientAddress1;
@property (weak, nonatomic) IBOutlet UITextField* clientAddress2;
@property (weak, nonatomic) IBOutlet UITextField* clientTown;
@property (weak, nonatomic) IBOutlet UITextField* clientPostalCode;
@property (weak, nonatomic) IBOutlet UITextField* clientCountry;
@property (weak, nonatomic) IBOutlet UITextField* clientPhoneNumber;
@property (weak, nonatomic) IBOutlet UITextField* clientMobilePhoneNumber;
@property (weak, nonatomic) IBOutlet UITextField* clientFaxPhoneNumber;
@property (weak, nonatomic) IBOutlet UITextField* clientEmail;
@property (weak, nonatomic) IBOutlet UIBarButtonItem* applyButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem* cancelButton;
@property (weak, nonatomic) IBOutlet UILabel* clientNameErrorLabel;
@property (nonatomic) BOOL updateMode;

@end

@implementation RNClientEditViewController

- (void) viewDidLoad
{
    // Set event handlers
    [self.clientFirstName addTarget:self action:@selector(clientFirstNameDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.clientLastName addTarget:self action:@selector(clientLastNameDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    // Update information
    [self updateFromClient:self.client];
    
    [super viewDidLoad];
}

- (void) updateFromClient:(RNClient*)client
{
    // Check if we are in update mode
    self.updateMode = (client != nil);
    
    if (self.updateMode) {
        // Update self client
        self.client = client;
        
        // Update title
        self.navigationItem.title = [NSString stringWithFormat:@"Client %@", self.client.displayName];
        
        // Update fields
        self.clientLastName.text = self.client.lastName;
        self.clientFirstName.text = self.client.firstName;
        self.clientPhoneNumber.text = self.client.phoneNumber;
        self.clientMobilePhoneNumber.text = self.client.mobilePhoneNumber;
        self.clientFaxPhoneNumber.text = self.client.faxPhoneNumber;
        self.clientEmail.text = self.client.emailAddress;
        self.clientAddress1.text = self.client.address.postalAddress1;
        self.clientAddress2.text = self.client.address.postalAddress2;
        self.clientTown.text = self.client.address.town;
        self.clientPostalCode.text = self.client.address.postalCode;
        self.clientCountry.text = self.client.address.country;
        
        // Update error label and buttons
        self.clientNameErrorLabel.hidden = YES;
        self.applyButton.enabled = [self isFormValid];
        
        // Lock lastName and firstname field
        self.clientLastName.userInteractionEnabled = FALSE;
        self.clientFirstName.userInteractionEnabled = FALSE;
    }
}

- (IBAction) done:(id)sender
{
    // Fetch key information
    NSString* clientLastName = self.clientLastName.text;
    NSString* clientFirstName = self.clientFirstName.text;
    
    if (!self.updateMode) {
        // Create and configure the project entity
        NSError* error = nil;
        self.client = [[RNStore instance] createClientWithLastName:clientLastName andFirstName:clientFirstName andError:&error];
        if (!self.client || error) {
            if (error.code == ERROR_DUPLICATE_CLIENTNAME) self.clientNameErrorLabel.hidden = NO;
            return;
        }
    }
    self.client.phoneNumber = self.clientPhoneNumber.text;
    self.client.mobilePhoneNumber = self.clientMobilePhoneNumber.text;
    self.client.faxPhoneNumber = self.clientFaxPhoneNumber.text;
    self.client.emailAddress = self.clientEmail.text;
    
    // Create relative address object
    RNAddress* clientAddress = self.client.address;
    clientAddress.postalAddress1 = self.clientAddress1.text;
    clientAddress.postalAddress2 = self.clientAddress2.text;
    clientAddress.town = self.clientTown.text;
    clientAddress.country = self.clientCountry.text;
    clientAddress.postalCode = self.clientPostalCode.text;
    
    // Store the project entity
    [[RNStore instance] saveContext];
    
    // Send event for client modification in update mode
    if (self.updateMode) {
        [self.delegate onClientModified:self.client];
    }
    
    // Hide the modal view
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction) cancel:(id)sender
{
    // Hide the modal view
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void) clientFirstNameDidChange:(UITextField*)textField
{
    self.clientFirstName.text = [self.clientFirstName.text capitalizedString];
    self.clientNameErrorLabel.hidden = YES;
    self.applyButton.enabled = [self isFormValid];
}

- (void) clientLastNameDidChange:(UITextField*)textField
{
    self.clientLastName.text = [self.clientLastName.text uppercaseString];
    self.clientNameErrorLabel.hidden = YES;
    self.applyButton.enabled = [self isFormValid];
}

- (BOOL) isFormValid
{
    return !IsNullOrEmpty(self.clientLastName.text) && !IsNullOrEmpty(self.clientFirstName.text);
}



@end
