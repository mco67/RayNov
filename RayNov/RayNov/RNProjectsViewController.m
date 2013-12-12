//
//  RNViewController.m
//  RayNov
//
//  Created by Mathieu Cordebard on 22/11/2013.
//  Copyright (c) 2013 Mathieu Cordebard. All rights reserved.
//

#import "RNProjectsViewController.h"
#import "RNSiteEditViewController.h"
#import "RNEditProjectViewController.h"
#import "RNStore+RNSite.h"
#import "RNSite.h"
#import "RNProjectsLayout.h"
#import "RNCollectionViewProjectCell.h"
#import "RNGridViewController.h"
#import <SWRevealViewController/SWRevealViewController.h>


@interface RNProjectsViewController () <NSFetchedResultsControllerDelegate>

@property (weak, nonatomic) IBOutlet UIBarButtonItem* revealButtonItem;

@end


@implementation RNProjectsViewController


#pragma mark - lifecycle


- (void) viewDidLoad
{
    [super viewDidLoad];

    // Configure the collectionView
    self.collectionView.collectionViewLayout = [[RNProjectsLayout alloc] init];
    [self.collectionView registerClass:[RNCollectionViewProjectCell class] forCellWithReuseIdentifier:@"ProjectCell"];
    
    // Create and iniialize the fetchedResultController
    NSError *error;
    self.fetchedResultsController = [[RNStore instance] createFetchedResultControllerWithDelegate:self];
	if (![self.fetchedResultsController performFetch:&error]) {
		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
		exit(-1);  // Fail
	}
    
    // Handle Button behavior
    [self.revealButtonItem setTarget: self.revealViewController];
    [self.revealButtonItem setAction: @selector(revealToggle:)];
    [self.navigationController.navigationBar addGestureRecognizer: self.revealViewController.panGestureRecognizer];
}

- (void) didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


#pragma mark - segue management

- (void) prepareForSegue:(UIStoryboardSegue*)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"EditProject"]) {
        UINavigationController* navigationController = segue.destinationViewController;
        RNEditProjectViewController* editSiteViewController = [navigationController viewControllers][0];
        //editSiteViewController.site = (RNSite*)self.site;
    }
}


#pragma mark - RNCreateprojectViewControllerDelegate implementation

- (void) createProjectViewControllerDidCancel:(RNSiteEditViewController*)controller
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void) createProjectViewControllerDidApply:(RNSiteEditViewController*)controller
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - RNEditprojectViewControllerDelegate implementation

- (void) editProjectViewControllerDidCancel:(RNSiteEditViewController*)controller
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UICollectionViewDataSource implementation


- (UICollectionViewCell*)collectionView:(UICollectionView*)collectionView cellForItemAtIndexPath:(NSIndexPath*)indexPath
{
    RNCollectionViewProjectCell* cell = (RNCollectionViewProjectCell*)[collectionView dequeueReusableCellWithReuseIdentifier:@"ProjectCell" forIndexPath:indexPath];
    RNSite* site = [self.fetchedResultsController objectAtIndexPath:indexPath];
    [cell.deleteButton addTarget:self action:@selector(delete:) forControlEvents:UIControlEventTouchUpInside];
    cell.projectName = site.siteName;
    
    return cell;
}

- (void) delete:(UIButton*)sender
{
    NSIndexPath* indexPath = [self.collectionView indexPathForCell:(RNCollectionViewProjectCell*)sender.superview.superview];
    RNSite* site = [self.fetchedResultsController objectAtIndexPath:indexPath];
    [[RNStore instance] deleteSite:site];
}


#pragma mark - UICollectionViewDelegate implementation

- (void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    RNSite* site = [self.fetchedResultsController objectAtIndexPath:indexPath];
    [self performSegueWithIdentifier:@"EditProject" sender:site];
}








@end
