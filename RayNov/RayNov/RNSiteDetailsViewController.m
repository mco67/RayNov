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

@interface RNSiteDetailsViewController () <RNSiteEditViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UITextField* siteName;
@property (weak, nonatomic) IBOutlet UITextField* siteReference;
@property (weak, nonatomic) IBOutlet UITextField* siteAddress1;
@property (weak, nonatomic) IBOutlet UITextField* siteAddress2;
@property (weak, nonatomic) IBOutlet UITextField* siteTown;
@property (weak, nonatomic) IBOutlet UITextField* sitePostalCode;
@property (weak, nonatomic) IBOutlet UITextField* siteCountry;

@end

@implementation RNSiteDetailsViewController

- (void) viewDidLoad
{
    [self updateFromSite:self.site];
    [super viewDidLoad];
}

- (void) updateFromSite:(RNSite*)site
{
    if (site) {
        
        // Update self client
        self.site = site;
        
        // Update title
        self.navigationItem.title = @"";[NSString stringWithFormat:@"Site %@", self.site.siteName];
        
        // Update fields
        self.siteName.text = self.site.siteName;
        self.siteReference.text = self.site.siteReference;
        self.siteAddress1.text = self.site.address.postalAddress1;
        self.siteAddress2.text = self.site.address.postalAddress2;
        self.siteTown.text = self.site.address.town;
        self.sitePostalCode.text = self.site.address.postalCode;
        self.siteCountry.text = self.site.address.country;
    }
    
    self.tableView.hidden = (site == nil);
}


#pragma mark - RNSiteTableViewControllerDelegate implementation

- (void) onCellSelected:(id)object
{
    [self updateFromSite:(RNSite*)object];
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
    [self performSegueWithIdentifier:@"siteModif" sender:self.site];
}


#pragma mark - segue management

- (void) prepareForSegue:(UIStoryboardSegue*)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"siteModif"]) {
        UINavigationController* navigationController = segue.destinationViewController;
        RNSiteEditViewController* siteEditViewController = (RNSiteEditViewController*)[navigationController viewControllers][0];
        siteEditViewController.site = (RNSite*)sender;
        siteEditViewController.delegate = self;
    }
}


#pragma mark - RNClientEditViewControllerDelegate implementation

- (void) onSiteModified:(RNSite*)site;
{
    [self updateFromSite:site];
}


@end
