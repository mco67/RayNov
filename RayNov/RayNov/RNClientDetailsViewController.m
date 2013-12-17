//
//  RNClientInfoViewController.m
//  RayNov
//
//  Created by Mathieu Cordebard on 02/12/2013.
//  Copyright (c) 2013 Mathieu Cordebard. All rights reserved.
//

#import "RNClientDetailsViewController.h"
#import "RNClientEditViewController.h"
#import "RNClientTableViewController.h"
#import "RNStore+RNClient.h"
#import "RNClient.h"
#import "RNAddress.h"


@interface RNClientDetailsViewController ()

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

@implementation RNClientDetailsViewController

- (void) viewDidLoad
{
    [super viewDidLoad];
    [self updateFields];
}

- (void) updateFields
{
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
        self.clientPostalCode.text = self.client.address.postalCode;
        self.clientCountry.text = self.client.address.country;
        
        // Update error label and buttons
        self.clientNameErrorLabel.hidden = YES;
    }
    
    self.tableView.hidden = (self.client == nil);
}


#pragma mark - RNClientTableViewControllerDelegate implementation

- (void) setClient:(RNClient*)client
{
    _client = client;
    [self updateFields];
}


- (void) tableView:(UITableView*)tableView willDisplayHeaderView:(UIView*)view forSection:(NSInteger)section
{
    if (section == 0) {
        CGFloat viewWidth = view.bounds.size.width;
        UIFont* font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:18];
        NSString* editLabel =@"Edit";
        CGRect rect = [editLabel boundingRectWithSize:CGSizeMake(300, 300)
                                              options:NSStringDrawingUsesLineFragmentOrigin
                                           attributes:@{NSFontAttributeName : font }
                                              context:nil];
        CGFloat buttonWidth = rect.size.width+32;
        UIButton* button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [button addTarget:self action:@selector(openModificationView) forControlEvents:UIControlEventTouchDown];
        [button setTitle:editLabel forState:UIControlStateNormal];
        button.titleLabel.font = font;
        
        button.titleLabel.shadowOffset = CGSizeZero;
        button.titleLabel.shadowColor = [UIColor clearColor];
        button.frame = CGRectMake(viewWidth-buttonWidth,15, buttonWidth, 40);
        [view addSubview:button];
    }
}

- (void) openModificationView
{
    [self performSegueWithIdentifier: @"editClient" sender: self.client];
}


#pragma mark - segue management

- (void) prepareForSegue:(UIStoryboardSegue*)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"editClient"]) {
        UINavigationController* navigationController = segue.destinationViewController;
        RNClientEditViewController* clientEditViewController = (RNClientEditViewController*)[navigationController viewControllers][0];
        clientEditViewController.client = (RNClient*)sender;
        
        // Configure action on leftButton (Back)
        clientEditViewController.leftButtonBlock = ^(RNClient* client)
        {
            [self.navigationController popViewControllerAnimated:YES];
        };
        
        // Configure action on leftButton (Done)
        clientEditViewController.rightButtonBlock = ^(RNClient* client)
        {
            self.client = client;
            [self updateFields];
            [self.navigationController popViewControllerAnimated:YES];
        };

        
    }
}


@end
