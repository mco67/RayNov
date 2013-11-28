//
//  RNViewController.m
//  RayNov
//
//  Created by Mathieu Cordebard on 22/11/2013.
//  Copyright (c) 2013 Mathieu Cordebard. All rights reserved.
//

#import "RNProjectsViewController.h"
#import "RNCreateProjectViewController.h"
#import "RNEditProjectViewController.h"
#import "RNProjectStore.h"
#import "RNProject.h"
#import "RNCollectionViewProjectCell.h"
#import <SWRevealViewController/SWRevealViewController.h>

@interface RNProjectsViewController () <RNCreateProjectViewControllerDelegate, RNEditProjectViewControllerDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) NSFetchedResultsController* fetchedResultsController;
@property (strong, nonatomic) NSMutableArray* objectChanges;
@property (strong, nonatomic) NSMutableArray* sectionChanges;
@property (weak, nonatomic) IBOutlet UIBarButtonItem* revealButtonItem;

@end


@implementation RNProjectsViewController


#pragma mark - lifecycle

- (void) viewDidLoad
{
    [super viewDidLoad];
    
    
    self.objectChanges = [NSMutableArray array];
    self.sectionChanges = [NSMutableArray array];
    
    [self.collectionView registerClass:[RNCollectionViewProjectCell class] forCellWithReuseIdentifier:@"ProjectCell"];
    
    // Create the fetchedResultController
    self.fetchedResultsController = [[RNProjectStore instance] createFetchedResultControllerWithDelegate:self];
    
    // Initialize it
    NSError *error;
	if (![[self fetchedResultsController] performFetch:&error]) {
		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
		exit(-1);  // Fail
	}
    
    [self.revealButtonItem setTarget: self.revealViewController];
    [self.revealButtonItem setAction: @selector( revealToggle: )];
    [self.navigationController.navigationBar addGestureRecognizer: self.revealViewController.panGestureRecognizer];
}

- (void) didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


#pragma mark - segue management

- (void) prepareForSegue:(UIStoryboardSegue*)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"AddProject"]) {
        UINavigationController* navigationController = segue.destinationViewController;
        RNCreateProjectViewController* createProjectViewController = [navigationController viewControllers][0];
        createProjectViewController.delegate = self;
    }
    
    if ([segue.identifier isEqualToString:@"EditProject"]) {
        UINavigationController* navigationController = segue.destinationViewController;
        RNEditProjectViewController* editProjectViewController = [navigationController viewControllers][0];
        editProjectViewController.delegate = self;
    }
}


#pragma mark - RNCreateprojectViewControllerDelegate implementation

- (void) createProjectViewControllerDidCancel:(RNCreateProjectViewController*)controller
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void) createProjectViewControllerDidApply:(RNCreateProjectViewController*)controller
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - RNEditprojectViewControllerDelegate implementation

- (void) editProjectViewControllerDidCancel:(RNCreateProjectViewController*)controller
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UICollectionViewDataSource implementation
- (NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return [[self.fetchedResultsController sections] count];
}

- (NSInteger) collectionView:(UICollectionView*)collectionView numberOfItemsInSection:(NSInteger)section
{
    id sectionInfo = [[self.fetchedResultsController sections] objectAtIndex:section];
    return [sectionInfo numberOfObjects];
}

- (UICollectionViewCell*)collectionView:(UICollectionView*)collectionView cellForItemAtIndexPath:(NSIndexPath*)indexPath
{
    RNCollectionViewProjectCell* cell = (RNCollectionViewProjectCell*)[collectionView dequeueReusableCellWithReuseIdentifier:@"ProjectCell" forIndexPath:indexPath];
    RNProject* project = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    cell.projectName = project.name;
    
    return cell;
}




#pragma mark - UICollectionViewDelegate implementation

- (void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"EditProject" sender:self];

}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
}



- (CGSize)collectionView:(UICollectionView*)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath*)indexPath
{
    CGSize retval = CGSizeMake(100, 100);
    retval.height += 35; retval.width += 35;
    return retval;
}


- (UIEdgeInsets)collectionView:(UICollectionView*)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(50, 20, 50, 20);
}


#pragma mark - NSFetchedResultsControllerDelegate implementation

- (void) controller:(NSFetchedResultsController*)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath*)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath*)newIndexPath {
    
    NSMutableDictionary *change = [NSMutableDictionary new];
    switch(type)
    {
        case NSFetchedResultsChangeInsert: change[@(type)] = newIndexPath; break;
        case NSFetchedResultsChangeDelete: change[@(type)] = indexPath;    break;
        case NSFetchedResultsChangeUpdate: change[@(type)] = indexPath;    break;
        case NSFetchedResultsChangeMove:   change[@(type)] = @[indexPath, newIndexPath]; break;
    }
    [_objectChanges addObject:change];
}

- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id)sectionInfo atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type
{
    NSMutableDictionary* change = [NSMutableDictionary new];
    switch(type)
    {
        case NSFetchedResultsChangeInsert: change[@(type)] = @(sectionIndex); break;
        case NSFetchedResultsChangeDelete: change[@(type)] = @(sectionIndex); break;
    }
    [_sectionChanges addObject:change];
}


- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    if ([_sectionChanges count] > 0)
    {
        [self.collectionView performBatchUpdates:^{
            
            for (NSDictionary *change in _sectionChanges)
            {
                [change enumerateKeysAndObjectsUsingBlock:^(NSNumber *key, id obj, BOOL *stop) {
                    
                    NSFetchedResultsChangeType type = [key unsignedIntegerValue];
                    switch (type)
                    {
                        case NSFetchedResultsChangeInsert:
                            [self.collectionView insertSections:[NSIndexSet indexSetWithIndex:[obj unsignedIntegerValue]]];
                            break;
                        case NSFetchedResultsChangeDelete:
                            [self.collectionView deleteSections:[NSIndexSet indexSetWithIndex:[obj unsignedIntegerValue]]];
                            break;
                        case NSFetchedResultsChangeUpdate:
                            [self.collectionView reloadSections:[NSIndexSet indexSetWithIndex:[obj unsignedIntegerValue]]];
                            break;
                    }
                }];
            }
        } completion:nil];
    }
    
    if ([_objectChanges count] > 0 && [_sectionChanges count] == 0) {
        if ([self shouldReloadCollectionViewToPreventKnownIssue] || self.collectionView.window == nil) {
            // This is to prevent a bug in UICollectionView from occurring.
            // The bug presents itself when inserting the first object or deleting the last object in a collection view.
            // http://stackoverflow.com/questions/12611292/uicollectionview-assertion-failure
            // This code should be removed once the bug has been fixed, it is tracked in OpenRadar
            // http://openradar.appspot.com/12954582
            [self.collectionView reloadData];
            
        }
        else {
            [self.collectionView performBatchUpdates:^{
                
                for (NSDictionary *change in _objectChanges) {
                    [change enumerateKeysAndObjectsUsingBlock:^(NSNumber *key, id obj, BOOL *stop) {
                        
                        NSFetchedResultsChangeType type = [key unsignedIntegerValue];
                        switch (type)
                        {
                            case NSFetchedResultsChangeInsert:
                                [self.collectionView insertItemsAtIndexPaths:@[obj]];
                                break;
                            case NSFetchedResultsChangeDelete:
                                [self.collectionView deleteItemsAtIndexPaths:@[obj]];
                                break;
                            case NSFetchedResultsChangeUpdate:
                                [self.collectionView reloadItemsAtIndexPaths:@[obj]];
                                break;
                            case NSFetchedResultsChangeMove:
                                [self.collectionView moveItemAtIndexPath:obj[0] toIndexPath:obj[1]];
                                break;
                        }
                    }];
                }
            } completion:nil];
        }
    }
    
    [_sectionChanges removeAllObjects];
    [_objectChanges removeAllObjects];
}


- (BOOL)shouldReloadCollectionViewToPreventKnownIssue {
    __block BOOL shouldReload = NO;
    for (NSDictionary *change in self.objectChanges) {
        [change enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
            NSFetchedResultsChangeType type = [key unsignedIntegerValue];
            NSIndexPath *indexPath = obj;
            switch (type)
            {
                case NSFetchedResultsChangeInsert:
                    shouldReload = ([self.collectionView numberOfItemsInSection:indexPath.section] == 0);
                    break;
                case NSFetchedResultsChangeDelete:
                    shouldReload = ([self.collectionView numberOfItemsInSection:indexPath.section] == 1);
                    break;
                case NSFetchedResultsChangeUpdate:
                    shouldReload = NO;
                    break;
                case NSFetchedResultsChangeMove:
                    shouldReload = NO;
                    break;
            }
        }];
    }
    return shouldReload;
}

@end
