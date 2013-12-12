//
//  RNSiteTableViewController.m
//  RayNov
//
//  Created by Mathieu Cordebard on 11/12/2013.
//  Copyright (c) 2013 Mathieu Cordebard. All rights reserved.
//

#import "RNSiteTableViewController.h"
#import "RNStore+RNSite.h"
#import "RNSiteTableViewCell.h"


@implementation RNSiteTableViewController

#pragma mark - UItableViewDatasource implementation

- (UITableViewCell*) tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
    static NSString* CellIdentifier = @"SiteCell";
    RNSiteTableViewCell* cell = (RNSiteTableViewCell*)[self.tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    [self fetchedResultsController:[self fetchedResultsControllerForTableView:tableView] configureCell:cell atIndexPath:indexPath];
    return cell;
}


#pragma mark - Overrided RNTableViewController methods

- (void) fetchedResultsController:(NSFetchedResultsController*)fetchedResultsController configureCell:(UITableViewCell*)cell atIndexPath:(NSIndexPath*)indexPath
{
    RNSite* site = (RNSite*)[fetchedResultsController objectAtIndexPath:indexPath];
    RNSiteTableViewCell* siteCell = (RNSiteTableViewCell*)cell;
    siteCell.siteDisplayName.text = site.siteName;
    //siteCell.displayAddress.text = client.displayAddress;
}

- (NSFetchedResultsController*) getFetchedResultControllerWithSearch:(NSString*)search
{
    return [[RNStore instance] getSiteFetchedResultsCtrlWithSearch:self.searchDisplayController.searchBar.text];
}

- (void) deleteObject:(id)object
{
    RNSite* site = (RNSite*)object;
    [[RNStore instance] deleteSite:site];
    [[RNStore instance] saveContext];
}

@end
