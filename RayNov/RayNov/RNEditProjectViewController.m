//
//  RNEditProjectViewController.m
//  RayNov
//
//  Created by Mathieu Cordebard on 27/11/2013.
//  Copyright (c) 2013 Mathieu Cordebard. All rights reserved.
//

#import "RNEditProjectViewController.h"
#import "RNRoomsLayout.h"
#import "RNRoomItem.h"
#import "RNSiteEditViewController.h"

@interface RNEditProjectViewController () <NSFetchedResultsControllerDelegate>

@end

@implementation RNEditProjectViewController

#pragma mark - lifecycle

- (void) viewDidLoad
{
    [super viewDidLoad];
    
    // Configure the collectionView
    self.collectionView.collectionViewLayout = [[RNRoomsLayout alloc] init];
    [self.collectionView registerClass:[RNRoomItem class] forCellWithReuseIdentifier:@"RoomCell"];
    
    // Create and initialize the fetchedResultController
    NSError *error;
    /*self.fetchedResultsController = [[RNStore instance] createRoomsFetchedResultControllerForProject:self.project andDelegate:self];
	if (![self.fetchedResultsController performFetch:&error]) {
		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
		exit(-1);  // Fail
	}*/
}

- (void) viewWillAppear:(BOOL)animated
{
    self.navigationItem.title = self.site.siteName;
}

#pragma mark - UICollectionViewDataSource implementation

- (UICollectionViewCell*)collectionView:(UICollectionView*)collectionView cellForItemAtIndexPath:(NSIndexPath*)indexPath
{
    RNRoomItem* cell = (RNRoomItem*)[collectionView dequeueReusableCellWithReuseIdentifier:@"RoomCell" forIndexPath:indexPath];
    RNSite* site = [self.fetchedResultsController objectAtIndexPath:indexPath];
    [cell.deleteButton addTarget:self action:@selector(delete:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}


#pragma mark - Handle user actions

- (IBAction) cancel:(id)sender
{
    // Hide the modal view
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - segue management

- (void) prepareForSegue:(UIStoryboardSegue*)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"ProjectInfo"]) {
        UINavigationController* navigationController = segue.destinationViewController;
        RNSiteEditViewController* siteInfoViewController = (RNSiteEditViewController*)[navigationController viewControllers][0];
        siteInfoViewController.site = self.site;
    }
}


@end
