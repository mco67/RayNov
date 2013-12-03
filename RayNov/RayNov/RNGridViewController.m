//
//  RNGridViewController.m
//  RayNov
//
//  Created by Mathieu Cordebard on 29/11/2013.
//  Copyright (c) 2013 Mathieu Cordebard. All rights reserved.
//

#import "RNGridViewController.h"
#import "RNGridLayout.h"
#import "RNGridItemCell.h"

@interface RNGridViewController () <UIGestureRecognizerDelegate, NSFetchedResultsControllerDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, RNGridLayoutDelegate>

@property (strong, nonatomic) NSMutableArray* objectChanges;
@property (strong, nonatomic) NSMutableArray* sectionChanges;
@property (nonatomic) BOOL isDeletionModeActive;

@end

@implementation RNGridViewController

#pragma mark - Initialization stuff

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
    }
    return self;
}

- (void) viewDidLoad
{
    [super viewDidLoad];
    
    // Initialize local variables
    self.isDeletionModeActive = NO;
    self.objectChanges = [NSMutableArray array];
    self.sectionChanges = [NSMutableArray array];
    
    // Add grid specific gestureRecognizers
    UILongPressGestureRecognizer* longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(activateDeletionMode:)];
    longPress.delegate = self;
    [self.collectionView addGestureRecognizer:longPress];
    UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(endDeletionMode:)];
    tap.delegate = self;
    [self.collectionView addGestureRecognizer:tap];
}

- (void) didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


#pragma mark - UICollectionViewDataSource implementation

- (NSInteger) numberOfSectionsInCollectionView:(UICollectionView*)collectionView
{
    return [[self.fetchedResultsController sections] count];
}

- (NSInteger) collectionView:(UICollectionView*)collectionView numberOfItemsInSection:(NSInteger)section
{
    id sectionInfo = [[self.fetchedResultsController sections] objectAtIndex:section];
    return [sectionInfo numberOfObjects];
}


- (void) delete:(UIButton*)sender
{
    NSIndexPath* indexPath = [self.collectionView indexPathForCell:(RNGridItemCell*)sender.superview.superview];
    // TODO Call delegate here
}


#pragma mark - UICollectionViewDelegate implementation

- (void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"EditProject" sender:self];
    
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
}

- (BOOL)collectionView:(UICollectionView*)collectionView shouldSelectItemAtIndexPath:(NSIndexPath*)indexPath
{
    return !self.isDeletionModeActive;
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


- (BOOL) shouldReloadCollectionViewToPreventKnownIssue {
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

#pragma mark - deletionMode methods
- (BOOL) isDeletionModeActiveForCollectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout
{
    return self.isDeletionModeActive;
}



#pragma mark - gesture-recognition action methods

- (BOOL) gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch*)touch
{
    CGPoint touchPoint = [touch locationInView:self.collectionView];
    NSIndexPath *indexPath = [self.collectionView indexPathForItemAtPoint:touchPoint];
    if (indexPath && [gestureRecognizer isKindOfClass:[UITapGestureRecognizer class]]) {
        return NO;
    }
    return YES;
}

- (void) activateDeletionMode:(UILongPressGestureRecognizer*)gr
{
    if (gr.state == UIGestureRecognizerStateBegan) {
        NSIndexPath* indexPath = [self.collectionView indexPathForItemAtPoint:[gr locationInView:self.collectionView]];
        if (indexPath) {
            self.isDeletionModeActive = YES;
            RNGridLayout* layout = (RNGridLayout*)self.collectionView.collectionViewLayout;
            [layout invalidateLayout];
        }
    }
}

- (void) endDeletionMode:(UITapGestureRecognizer*)gr
{
    if (self.isDeletionModeActive) {
        NSIndexPath* indexPath = [self.collectionView indexPathForItemAtPoint:[gr locationInView:self.collectionView]];
        if (!indexPath) {
            self.isDeletionModeActive = NO;
            RNGridLayout* layout = (RNGridLayout*)self.collectionView.collectionViewLayout;
            [layout invalidateLayout];
        }
    }
}

@end
