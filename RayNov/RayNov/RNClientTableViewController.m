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

@interface RNClientTableViewController () <NSFetchedResultsControllerDelegate, UISearchBarDelegate, UISearchDisplayDelegate>

@property (weak, nonatomic) IBOutlet UISearchBar* searchBar;
@property (strong, nonatomic) NSFetchedResultsController* clientsFetchedResultsController;
@property (strong, nonatomic) NSFetchedResultsController* searchFetchedResultsController;
@property (strong, nonatomic) UISearchDisplayController* mySearchDisplayController;
@property (copy, nonatomic) NSString* savedSearchTerm;
@property (nonatomic) NSInteger savedScopeButtonIndex;
@property (nonatomic) BOOL searchWasActive;

@end

@implementation RNClientTableViewController


#pragma mark - Initialization stuff

- (void) loadView
{
    [super loadView];
    
    self.mySearchDisplayController = [[UISearchDisplayController alloc] initWithSearchBar:self.searchBar contentsController:self];
    self.mySearchDisplayController.delegate = self;
    self.mySearchDisplayController.searchResultsDataSource = self;
    self.mySearchDisplayController.searchResultsDelegate = self;
}

- (void) didReceiveMemoryWarning
{
    self.searchWasActive = [self.searchDisplayController isActive];
    self.savedSearchTerm = [self.searchDisplayController.searchBar text];
    self.savedScopeButtonIndex = [self.searchDisplayController.searchBar selectedScopeButtonIndex];
    
    self.clientsFetchedResultsController.delegate = nil;
    self.searchFetchedResultsController.delegate = nil;
    [super didReceiveMemoryWarning];
}

- (void) viewDidDisappear:(BOOL)animated
{
    self.searchWasActive = [self.searchDisplayController isActive];
    self.savedSearchTerm = [self.searchDisplayController.searchBar text];
    self.savedScopeButtonIndex = [self.searchDisplayController.searchBar selectedScopeButtonIndex];
}

- (void) viewDidLoad
{
    // restore search settings if they were saved in didReceiveMemoryWarning.
    if (self.savedSearchTerm)
    {
        [self.searchDisplayController setActive:self.searchWasActive];
        [self.searchDisplayController.searchBar setSelectedScopeButtonIndex:self.savedScopeButtonIndex];
        [self.searchDisplayController.searchBar setText:self.savedSearchTerm];
        self.savedSearchTerm = nil;
    }
}


- (NSFetchedResultsController*) clientsFetchedResultsController
{
    if (_clientsFetchedResultsController != nil)
    {
        return _clientsFetchedResultsController;
    }
    _clientsFetchedResultsController = [[RNStore instance] getSearchFetchedResultsCtrlWithSearch:nil andDelegate:self];
    return _clientsFetchedResultsController;
}

- (NSFetchedResultsController*) searchFetchedResultsController
{
    if (_searchFetchedResultsController != nil)
    {
        return _searchFetchedResultsController;
    }
    _searchFetchedResultsController = [[RNStore instance] getSearchFetchedResultsCtrlWithSearch:self.searchDisplayController.searchBar.text andDelegate:self];
    return _searchFetchedResultsController;
}

#pragma mark - UItableViewDatasource implementation

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return [[self fetchedResultsControllerForTableView:tableView] sections].count;
}

- (NSInteger) tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{
    id sectionInfo = [[[self fetchedResultsControllerForTableView:tableView] sections] objectAtIndex:section];
    return [sectionInfo numberOfObjects];
}

- (void) fetchedResultsController:(NSFetchedResultsController*)fetchedResultsController configureCell:(RNClientTableViewCell*)cell atIndexPath:(NSIndexPath*)indexPath
{
    RNClient* client = (RNClient*)[fetchedResultsController objectAtIndexPath:indexPath];
    cell.displayName.text = client.displayName;
    cell.displayAddress.text = client.displayAddress;
}

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* CellIdentifier = @"ClientCell";
    RNClientTableViewCell* cell = (RNClientTableViewCell*)[self.tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    [self fetchedResultsController:[self fetchedResultsControllerForTableView:tableView] configureCell:cell atIndexPath:indexPath];
    return cell;
}

#pragma mark - Content Filtering

- (void) filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{
    self.searchFetchedResultsController.delegate = nil;
    self.searchFetchedResultsController = nil;
}

#pragma mark - Search Bar

- (void) searchDisplayController:(UISearchDisplayController*)controller willUnloadSearchResultsTableView:(UITableView*)tableView;
{
    self.searchFetchedResultsController.delegate = nil;
    self.searchFetchedResultsController = nil;
}

- (BOOL) searchDisplayController:(UISearchDisplayController*)controller shouldReloadTableForSearchString:(NSString*)searchString
{
    [self filterContentForSearchText:searchString
                               scope:[NSString stringWithFormat:@"%d", [self.searchDisplayController.searchBar selectedScopeButtonIndex]]];
    return YES;
}


- (BOOL) searchDisplayController:(UISearchDisplayController*)controller shouldReloadTableForSearchScope:(NSInteger)searchOption
{
    [self filterContentForSearchText:[self.searchDisplayController.searchBar text]
                               scope:[NSString stringWithFormat:@"%d", [self.searchDisplayController.searchBar selectedScopeButtonIndex]]];
    return YES;
}



- (void) controllerWillChangeContent:(NSFetchedResultsController*)controller
{
    [[self tableViewForFetchedResultsController:controller] beginUpdates];
}

- (void) controller:(NSFetchedResultsController*)controller didChangeSection:(id<NSFetchedResultsSectionInfo>)sectionInfo
            atIndex:(NSUInteger)sectionIndex
      forChangeType:(NSFetchedResultsChangeType)type
{
    UITableView* tableView = [self tableViewForFetchedResultsController:controller];
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
        case NSFetchedResultsChangeDelete:
            [tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}

- (void) controller:(NSFetchedResultsController*)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath*)theIndexPath
     forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath*)newIndexPath
{
    UITableView* tableView = [self tableViewForFetchedResultsController:controller];
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:theIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeUpdate:
            [self fetchedResultsController:controller configureCell:[tableView cellForRowAtIndexPath:theIndexPath] atIndexPath:theIndexPath];
            break;
            
        case NSFetchedResultsChangeMove:
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:theIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath]withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}

- (void)controllerDidChangeContent:(NSFetchedResultsController*)controller
{
    [[self tableViewForFetchedResultsController:controller] endUpdates];
}



- (IBAction) cancel:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - Private methods

- (NSFetchedResultsController*) fetchedResultsControllerForTableView:(UITableView*)tableView
{
    return (tableView == self.tableView)?self.clientsFetchedResultsController:self.searchFetchedResultsController;
}

- (UITableView*) tableViewForFetchedResultsController:(NSFetchedResultsController*)controller
{
    return (controller==self.clientsFetchedResultsController)?self.tableView:self.searchDisplayController.searchResultsTableView;
}


@end
