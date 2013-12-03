//
//  RNViewController.m
//  RayNov
//
//  Created by Mathieu Cordebard on 22/11/2013.
//  Copyright (c) 2013 Mathieu Cordebard. All rights reserved.
//

#import "RNProjectsViewController.h"
#import "RNProjectInfoViewController.h"
#import "RNEditProjectViewController.h"
#import "RNStore+RNProject.h"
#import "RNProject.h"
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
        RNEditProjectViewController* editProjectViewController = [navigationController viewControllers][0];
        editProjectViewController.project = (RNProject*)sender;
    }
}


#pragma mark - RNCreateprojectViewControllerDelegate implementation

- (void) createProjectViewControllerDidCancel:(RNProjectInfoViewController*)controller
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void) createProjectViewControllerDidApply:(RNProjectInfoViewController*)controller
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - RNEditprojectViewControllerDelegate implementation

- (void) editProjectViewControllerDidCancel:(RNProjectInfoViewController*)controller
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UICollectionViewDataSource implementation


- (UICollectionViewCell*)collectionView:(UICollectionView*)collectionView cellForItemAtIndexPath:(NSIndexPath*)indexPath
{
    RNCollectionViewProjectCell* cell = (RNCollectionViewProjectCell*)[collectionView dequeueReusableCellWithReuseIdentifier:@"ProjectCell" forIndexPath:indexPath];
    RNProject* project = [self.fetchedResultsController objectAtIndexPath:indexPath];
    [cell.deleteButton addTarget:self action:@selector(delete:) forControlEvents:UIControlEventTouchUpInside];
    cell.projectName = project.siteName;
    
    return cell;
}

- (void) delete:(UIButton*)sender
{
    NSIndexPath* indexPath = [self.collectionView indexPathForCell:(RNCollectionViewProjectCell*)sender.superview.superview];
    RNProject* project = [self.fetchedResultsController objectAtIndexPath:indexPath];
    [[RNStore instance] deleteProject:project];
}


#pragma mark - UICollectionViewDelegate implementation

- (void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    RNProject* project = [self.fetchedResultsController objectAtIndexPath:indexPath];
    [self performSegueWithIdentifier:@"EditProject" sender:project];

}








@end
