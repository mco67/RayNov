//
//  RNSiteDetailsViewController.m
//  RayNov
//
//  Created by Mathieu Cordebard on 11/12/2013.
//  Copyright (c) 2013 Mathieu Cordebard. All rights reserved.
//

#import "RNSiteDetailsViewController.h"
#import "RNSiteEditViewController.h"
#import "RNAddress.h"
#import "RNClient.h"
#import "RNMainRotateViewController.h"

@interface RNSiteDetailsViewController ()

@property (weak, nonatomic) IBOutlet UITextField* siteName;
@property (weak, nonatomic) IBOutlet UITextField* siteReference;
@property (weak, nonatomic) IBOutlet UITextField* siteAddress1;
@property (weak, nonatomic) IBOutlet UITextField* siteAddress2;
@property (weak, nonatomic) IBOutlet UITextField* siteTown;
@property (weak, nonatomic) IBOutlet UITextField* sitePostalCode;
@property (weak, nonatomic) IBOutlet UITextField* siteCountry;
@property (weak, nonatomic) IBOutlet UITextField* siteClient;

@end


@implementation RNSiteDetailsViewController

- (void) viewDidLoad
{
    [super viewDidLoad];
    [self updateFields];
}

- (void) updateFields
{
    if (self.site) {
    
        // Update title
        self.navigationItem.title = [NSString stringWithFormat:@"Site %@", self.site.siteName];
        
        // Update fields
        self.siteName.text = self.site.siteName;
        self.siteReference.text = self.site.siteReference;
        self.siteAddress1.text = self.site.address.postalAddress1;
        self.siteAddress2.text = self.site.address.postalAddress2;
        self.siteTown.text = self.site.address.town;
        self.sitePostalCode.text = self.site.address.postalCode;
        self.siteCountry.text = self.site.address.country;
        self.siteClient.text = self.site.client.displayName;
    }
    
    self.tableView.hidden = (self.site == nil);
}


#pragma mark - RNSiteTableViewControllerDelegate implementation

- (void) setSite:(RNSite *)site
{
    _site = site;
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
    //[self performSegueWithIdentifier:@"editSite" sender:self.site];
    [[NSNotificationCenter defaultCenter] postNotificationName:RN_ON_ROTATE_NOTIFICATION object:self.site userInfo:nil];
}


#pragma mark - segue management

- (void) prepareForSegue:(UIStoryboardSegue*)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"editSite"]) {
        UINavigationController* navigationController = (UINavigationController*)segue.destinationViewController;
        RNSiteEditViewController* siteEditViewController = (RNSiteEditViewController*)navigationController.viewControllers[0];
        siteEditViewController.site = (RNSite*)sender;
        
        // Configure action on leftButton (Cancel)
        siteEditViewController.leftButtonBlock = ^(RNSite* site) {
            [self dismissViewControllerAnimated:YES completion:nil];
        };
        
        // Configure action on rightButton (Done)
        siteEditViewController.rightButtonBlock = ^(RNSite* site) {
            [[RNStore instance] saveContext];
            self.site = site;
            [self updateFields];
            [self dismissViewControllerAnimated:YES completion:nil];
        };

    }
}

@end
