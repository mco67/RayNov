//
//  RNTableViewController.m
//  RayNov
//
//  Created by Mathieu Cordebard on 07/12/2013.
//  Copyright (c) 2013 Mathieu Cordebard. All rights reserved.
//

#import "RNTableViewController.h"


@interface RNTableViewController () <NSFetchedResultsControllerDelegate, UISearchBarDelegate, UISearchDisplayDelegate, UIAlertViewDelegate>


@property (strong, nonatomic) UISearchDisplayController* mySearchDisplayController;
@property (strong, nonatomic) id selectedObject;
@property (strong, nonatomic) id toDeleteObject;
@property (copy, nonatomic) NSString* savedSearchTerm;
@property (nonatomic) NSInteger savedScopeButtonIndex;
@property (nonatomic) BOOL searchWasActive;

@end


@implementation RNTableViewController


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
    
    self.fetchedResultsController.delegate = nil;
    self.searchFetchedResultsController.delegate = nil;
    [super didReceiveMemoryWarning];
}

- (void) viewDidAppear:(BOOL)animated
{
    // Select the first item (if any)
    if (self.tableView.numberOfSections > 0 && [self.tableView numberOfRowsInSection:0]) {
        NSIndexPath* indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
        [self.tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionBottom];
        self.selectedObject = [[self fetchedResultsControllerForTableView:self.tableView] objectAtIndexPath:indexPath];
        [self.delegate onCellSelected:self.selectedObject];
    }
}

- (void) viewDidDisappear:(BOOL)animated
{
    self.searchWasActive = [self.searchDisplayController isActive];
    self.savedSearchTerm = [self.searchDisplayController.searchBar text];
    self.savedScopeButtonIndex = [self.searchDisplayController.searchBar selectedScopeButtonIndex];
}

- (void) viewDidLoad
{
    [super viewDidLoad];
    
    // restore search settings if they were saved in didReceiveMemoryWarning.
    if (self.savedSearchTerm)
    {
        [self.searchDisplayController setActive:self.searchWasActive];
        [self.searchDisplayController.searchBar setSelectedScopeButtonIndex:self.savedScopeButtonIndex];
        [self.searchDisplayController.searchBar setText:self.savedSearchTerm];
        self.savedSearchTerm = nil;
    }
    
    // iOS7 display issue
    self.edgesForExtendedLayout = UIRectEdgeNone;
}


#pragma mark - FetchedResultsControllers stuff

- (NSFetchedResultsController*) getFetchedResultControllerWithSearch:(NSString*)search
{
    @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                   reason:[NSString stringWithFormat:@"You must override %@ in a subclass", NSStringFromSelector(_cmd)]
                                 userInfo:nil];
}

- (NSFetchedResultsController*) fetchedResultsController
{
    if (_fetchedResultsController != nil) {
        return _fetchedResultsController;
    }
    _fetchedResultsController = [self getFetchedResultControllerWithSearch:nil];
    _fetchedResultsController.delegate = self;
    return _fetchedResultsController;
}

- (NSFetchedResultsController*) searchFetchedResultsController
{
    if (_searchFetchedResultsController != nil) {
        return _searchFetchedResultsController;
    }
    _searchFetchedResultsController = [self getFetchedResultControllerWithSearch:self.searchDisplayController.searchBar.text];
    _searchFetchedResultsController.delegate = self;
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

- (BOOL) tableView:(UITableView*)tableView canEditRowAtIndexPath:(NSIndexPath*)indexPath
{
    return YES;
}

- (void) tableView:(UITableView*)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath*)indexPath
{
    // Consider this candidat to deletion as selected client
    self.toDeleteObject = [[self fetchedResultsControllerForTableView:tableView] objectAtIndexPath:indexPath];
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        UIAlertView *errorAlert = [[UIAlertView alloc] initWithTitle:@"Warning"
                                                             message:@"Do you really want to delete this entry"
                                                            delegate:nil
                                                   cancelButtonTitle:@"Cancel"
                                                   otherButtonTitles:@"Delete", nil];
        errorAlert.tag = 0;
        errorAlert.delegate = self;
        [errorAlert show];
    }
}


- (void) fetchedResultsController:(NSFetchedResultsController*)fetchedResultsController configureCell:(UITableViewCell*)cell atIndexPath:(NSIndexPath*)indexPath
{
    @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                   reason:[NSString stringWithFormat:@"You must override %@ in a subclass", NSStringFromSelector(_cmd)]
                                 userInfo:nil];
}


#pragma mark - UItableViewDelegate implementation

- (void) tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath
{
    self.selectedObject = [[self fetchedResultsControllerForTableView:tableView] objectAtIndexPath:indexPath];
    [self.delegate onCellSelected:self.selectedObject];
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


#pragma mark - AlertViewDelegate implementation

- (void) alertView:(UIAlertView*)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        [self.tableView reloadData];
    }
    else {
        // Delete the object
        [self deleteObject:self.toDeleteObject];
    }
}

- (void) deleteObject:(id)object
{
    @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                   reason:[NSString stringWithFormat:@"You must override %@ in a subclass", NSStringFromSelector(_cmd)]
                                    userInfo:nil];
}


#pragma mark - Private methods

- (NSFetchedResultsController*) fetchedResultsControllerForTableView:(UITableView*)tableView
{
    return (tableView == self.tableView)?self.fetchedResultsController:self.searchFetchedResultsController;
}

- (UITableView*) tableViewForFetchedResultsController:(NSFetchedResultsController*)controller
{
    return (controller==self.fetchedResultsController)?self.tableView:self.searchDisplayController.searchResultsTableView;
}

// Permits to avoid the navigationBar display
- (UINavigationController*) navigationController
{
    return nil;
}


@end
