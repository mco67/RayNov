//
//  RNSiteClientTableViewController.m
//  RayNov
//
//  Created by Mathieu Cordebard on 15/12/2013.
//  Copyright (c) 2013 Mathieu Cordebard. All rights reserved.
//

#import "RNSiteClientTableViewController.h"
#import "RNClient.h"
#import "RNStore+RNClient.h"


@implementation RNSiteClientTableViewController

#pragma mark - Lifecycle stuff

- (void) viewDidAppear:(BOOL)animated
{
    // To avoid the automatic selection of the first cell
}

#pragma mark - UItableViewDatasource implementation

- (UITableViewCell*) tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
    static NSString* CellIdentifier = @"SiteClientCell";
    UITableViewCell* cell = (UITableViewCell*)[self.tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    [self fetchedResultsController:[self fetchedResultsControllerForTableView:tableView] configureCell:cell atIndexPath:indexPath];
    return cell;
}

- (BOOL) tableView:(UITableView*)tableView canEditRowAtIndexPath:(NSIndexPath*)indexPath
{
    return NO;
}

#pragma mark - Overrided RNTableViewController methods

- (void) fetchedResultsController:(NSFetchedResultsController*)fetchedResultsController configureCell:(UITableViewCell*)cell atIndexPath:(NSIndexPath*)indexPath
{
    RNClient* client = (RNClient*)[fetchedResultsController objectAtIndexPath:indexPath];
    cell.textLabel.text = client.displayName;
    
}

- (NSFetchedResultsController*) getFetchedResultControllerWithSearch:(NSString*)search
{
    return [[RNStore instance] getSearchFetchedResultsCtrlWithSearch:self.searchDisplayController.searchBar.text];
}

@end
