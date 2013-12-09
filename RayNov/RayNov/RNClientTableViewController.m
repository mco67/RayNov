//
//  RNClientViewController.m
//  RayNov
//
//  Created by Mathieu Cordebard on 30/11/2013.
//  Copyright (c) 2013 Mathieu Cordebard. All rights reserved.
//

#import "RNClientTableViewController.h"
#import "RNStore+RNClient.h"
#import "RNClientTableViewCell.h"


@implementation RNClientTableViewController


#pragma mark - UItableViewDatasource implementation

- (UITableViewCell*) tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
    static NSString* CellIdentifier = @"ClientCell";
    RNClientTableViewCell* cell = (RNClientTableViewCell*)[self.tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    [self fetchedResultsController:[self fetchedResultsControllerForTableView:tableView] configureCell:cell atIndexPath:indexPath];
    return cell;
}


#pragma mark - Overrided RNTableViewController methods

- (void) fetchedResultsController:(NSFetchedResultsController*)fetchedResultsController configureCell:(UITableViewCell*)cell atIndexPath:(NSIndexPath*)indexPath
{
    RNClient* client = (RNClient*)[fetchedResultsController objectAtIndexPath:indexPath];
    RNClientTableViewCell* clientCell = (RNClientTableViewCell*)cell;
    clientCell.displayName.text = client.displayName;
    clientCell.displayAddress.text = client.displayAddress;
}

- (NSFetchedResultsController*) getFetchedResultControllerWithSearch:(NSString*)search
{
    return [[RNStore instance] getSearchFetchedResultsCtrlWithSearch:self.searchDisplayController.searchBar.text];
}

- (void) deleteObject:(id)object
{
    RNClient* client = (RNClient*)object;
    [[RNStore instance] deleteClient:client];
    [[RNStore instance] saveContext];
}



@end
