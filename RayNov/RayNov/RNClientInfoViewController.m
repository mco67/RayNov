//
//  RNClientInfoViewController.m
//  RayNov
//
//  Created by Mathieu Cordebard on 02/12/2013.
//  Copyright (c) 2013 Mathieu Cordebard. All rights reserved.
//

#import "RNClientInfoViewController.h"
#import "RNStore+RNClient.h"
#import "RNClient.h"
#import "RNAddress.h"


@interface RNClientInfoViewController ()

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
@property (weak, nonatomic) IBOutlet UILabel* clientNameErrorLabel;

@end

@implementation RNClientInfoViewController

- (void) viewDidLoad
{
    self.clientNameErrorLabel.hidden = YES;
    self.applyButton.enabled = [self isFormValid];
    [self.clientFirstName addTarget:self action:@selector(clientNameDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.clientLastName addTarget:self action:@selector(clientNameDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    // Update information
    if (self.client) {
        
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
        self.clientPostalCode.text = [self.client.address.postalCode stringValue];
        self.clientCountry.text = self.client.address.country;
    }
    [super viewDidLoad];
}

- (IBAction) done:(id)sender
{
    // Fetch key information
    NSString* clientLastName = self.clientLastName.text;
    NSString* clientFirstName = self.clientFirstName.text;

    // Create and configure the project entity
    NSError* error = nil;
    RNClient* client = [[RNStore instance] createClientWithLastName:clientLastName andFirstName:clientFirstName andError:&error];
    if (!client || error) {
        if (error.code == ERROR_DUPLICATE_CLIENTNAME) self.clientNameErrorLabel.hidden = NO;
        return;
    }
    client.phoneNumber = self.clientPhoneNumber.text;
    client.mobilePhoneNumber = self.clientMobilePhoneNumber.text;
    client.faxPhoneNumber = self.clientFaxPhoneNumber.text;
    client.emailAddress = self.clientEmail.text;
    
    // Create relative address object
    RNAddress* clientAddress = client.address;
    clientAddress.postalAddress1 = self.clientAddress1.text;
    clientAddress.postalAddress2 = self.clientAddress2.text;
    clientAddress.town = self.clientTown.text;
    clientAddress.country = self.clientCountry.text;
    clientAddress.postalCode = [NSNumber numberWithInt:[self.clientPostalCode.text intValue]];
    
    // Store the project entity
    [[RNStore instance] saveContext];
    
    // Hide the modal view
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void) clientNameDidChange:(UITextField*)textField
{
    self.clientNameErrorLabel.hidden = YES;
    self.applyButton.enabled = [self isFormValid];
}

- (BOOL) isFormValid
{
    return !IsNullOrEmpty(self.clientLastName.text) && !IsNullOrEmpty(self.clientFirstName.text);
}


@end
