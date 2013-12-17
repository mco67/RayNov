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
@property (weak, nonatomic) IBOutlet UIBarButtonItem* rightButton;
@property (weak, nonatomic) IBOutlet UILabel* clientNameErrorLabel;
@property (nonatomic) BOOL rightButtonTapped;

@end

@implementation RNClientEditViewController


#pragma mark - View lifecycle

- (void) viewDidLoad
{
    [super viewDidLoad];
    
    // Set event handlers
    [self.clientFirstName addTarget:self action:@selector(clientFirstNameDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.clientLastName addTarget:self action:@selector(clientLastNameDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    // Update form fields
    [self updateFields];
}

- (void) updateFields
{
    // Specific settings in modification mode
    if (!IsNullOrEmpty(self.client.lastName) && !IsNullOrEmpty(self.client.firstName))
    {
        // Update title
        self.navigationItem.title = [NSString stringWithFormat:@"Client %@", self.client.displayName];
        
        // Lock lastName and firstname field
        self.clientLastName.userInteractionEnabled = FALSE;
        self.clientFirstName.userInteractionEnabled = FALSE;
    }
    
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
    self.rightButton.enabled = [self isFormValid];
    self.rightButtonTapped = NO;
}

-(void) viewWillDisappear:(BOOL)animated
{
    // Back button was pressed.  We know this is true because self is no longer
    // in the navigation stack.
    if ([self.navigationController.viewControllers indexOfObject:self] == NSNotFound)
    {
        // Execute left button block
        if (!self.rightButtonTapped) self.leftButtonBlock(self.client);
    }
    [super viewWillDisappear:animated];
}


#pragma mark - Buttons action handling

- (IBAction) onRightButtonTap:(id)sender
{
    // Fill RNClient objevt with form field values
    self.client.lastName = self.clientLastName.text;
    self.client.firstName = self.clientFirstName.text;
    self.client.phoneNumber = self.clientPhoneNumber.text;
    self.client.mobilePhoneNumber = self.clientMobilePhoneNumber.text;
    self.client.faxPhoneNumber = self.clientFaxPhoneNumber.text;
    self.client.emailAddress = self.clientEmail.text;
    
    // Fill relative address object
    RNAddress* clientAddress = self.client.address;
    clientAddress.postalAddress1 = self.clientAddress1.text;
    clientAddress.postalAddress2 = self.clientAddress2.text;
    clientAddress.town = self.clientTown.text;
    clientAddress.country = self.clientCountry.text;
    clientAddress.postalCode = self.clientPostalCode.text;
    
    // Execute right button block
    self.rightButtonTapped = YES;
    self.rightButtonBlock(self.client);
}


#pragma mark - Private stuff

- (void) clientFirstNameDidChange:(UITextField*)textField
{
    self.clientFirstName.text = [self.clientFirstName.text capitalizedString];
    self.clientNameErrorLabel.hidden = [[RNStore instance] checkClientNameUnicityWithLastName:self.clientLastName.text andFirstName:self.clientFirstName.text];
    self.rightButton.enabled = [self isFormValid];
}

- (void) clientLastNameDidChange:(UITextField*)textField
{
    self.clientLastName.text = [self.clientLastName.text uppercaseString];
    self.clientNameErrorLabel.hidden = [[RNStore instance] checkClientNameUnicityWithLastName:self.clientLastName.text andFirstName:self.clientFirstName.text];
    self.rightButton.enabled = [self isFormValid];
}

- (BOOL) isFormValid
{
    return self.clientNameErrorLabel.hidden && !IsNullOrEmpty(self.clientLastName.text) && !IsNullOrEmpty(self.clientFirstName.text);
}

@end
