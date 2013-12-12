//
//  RNStore+RNSite.m
//  RayNov
//
//  Created by Mathieu Cordebard on 30/11/2013.
//  Copyright (c) 2013 Mathieu Cordebard. All rights reserved.
//

#import "RNStore+RNSite.h"
#import "RNRoom.h"
#import "RNAddress.h"

@implementation RNStore (RNSite)

- (RNSite*) createSiteWithSiteName:(NSString*)siteName andSiteReference:(NSString*)siteRef andError:(NSError**)error
{
    // Check the sitetName unicity
    if (![self checkSiteNameUnicity:siteName]) {
        *error = [NSError errorWithDomain:@"RNStore+RNSite" code:ERROR_DUPLICATE_SITE_NAME userInfo:nil];
        return nil;
    }
    
    // Check the siteReference unicity
    if (![self checkSiteReferenceUnicity:siteRef]) {
        *error = [NSError errorWithDomain:@"RNStore+RNSite" code:ERROR_DUPLICATE_SITE_REFERENCE userInfo:nil];
        return nil;
    }
    
    // Create and fill the new project object
    RNSite* project = [RNSite insertInManagedObjectContext:self.managedObjectContext];
    project.siteName = siteName;
    project.siteReference = siteRef;
    project.creationDate = [NSDate date];
    
    // Create the associated RNAddress object
    RNAddress* projectAddress = [RNAddress insertInManagedObjectContext:self.managedObjectContext];
    project.address = projectAddress;
    
    // Create the dummy room object
    RNRoom* room = [RNRoom insertInManagedObjectContext:self.managedObjectContext];
    room.dummyValue = YES;
    [project addRoomsObject:room];
    
    return project;
}

- (void) deleteSite:(RNSite*)site
{
    [self.managedObjectContext deleteObject:site];
}

- (NSFetchedResultsController*) createFetchedResultControllerWithDelegate:(id<NSFetchedResultsControllerDelegate>)delegate
{
    NSFetchRequest* fetchRequest = [[NSFetchRequest alloc] init];
    [fetchRequest setEntity:[RNSite entityInManagedObjectContext:self.managedObjectContext]];
    NSSortDescriptor* sort = [[NSSortDescriptor alloc] initWithKey:@"creationDate" ascending:NO];
    [fetchRequest setSortDescriptors:@[sort]];
    [fetchRequest setFetchBatchSize:20];
    
    NSFetchedResultsController* fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
                                                                                               managedObjectContext:self.managedObjectContext
                                                                                                 sectionNameKeyPath:nil
                                                                                                          cacheName:@"Root"];
    fetchedResultsController.delegate = delegate;
    
    return fetchedResultsController;
}

- (NSFetchedResultsController*) getSiteFetchedResultsCtrlWithSearch:(NSString*)searchString;
{
    NSArray* sortDescriptors = @[[[NSSortDescriptor alloc] initWithKey:@"siteName" ascending:YES]];
    NSPredicate* filterPredicate = nil;
    
    // Create the fetchRequest for the entity.
    NSFetchRequest* fetchRequest = [[NSFetchRequest alloc] init];
    [fetchRequest setEntity:[RNSite entityInManagedObjectContext:self.managedObjectContext]];
    
    // Compute predicate array
    NSMutableArray* predicateArray = [NSMutableArray array];
    if (searchString.length) {
        // your search predicate(s) are added to this array
        [predicateArray addObject:[NSPredicate predicateWithFormat:@"siteName CONTAINS[cd] %@", searchString]];
        
        if (filterPredicate) {
            filterPredicate = [NSCompoundPredicate andPredicateWithSubpredicates:[NSArray arrayWithObjects:filterPredicate, [NSCompoundPredicate orPredicateWithSubpredicates:predicateArray], nil]];
        }
        else {
            filterPredicate = [NSCompoundPredicate orPredicateWithSubpredicates:predicateArray];
        }
    }
    [fetchRequest setPredicate:filterPredicate];
    [fetchRequest setFetchBatchSize:20];
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    NSFetchedResultsController* fetchedResultsController =[[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
                                                                                              managedObjectContext:self.managedObjectContext
                                                                                                sectionNameKeyPath:nil
                                                                                                         cacheName:nil];
    NSError *error = nil;
    if (![fetchedResultsController performFetch:&error])
    {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    return fetchedResultsController;
}

#pragma mark - Private methods

- (BOOL) checkSiteNameUnicity:(NSString*)siteName
{
    // Create the request
    NSFetchRequest* request = [[NSFetchRequest alloc] init];
    [request setEntity:[RNSite entityInManagedObjectContext:self.managedObjectContext]];
    [request setPredicate:[NSPredicate predicateWithFormat:@"siteName like %@", siteName]];
    
    // Execute request
    NSError* error = nil;
    NSArray* fetchedProjects = [self.managedObjectContext executeFetchRequest:request error:&error];
    return !(fetchedProjects && [fetchedProjects count]>0);
}

- (BOOL) checkSiteReferenceUnicity:(NSString*)siteReference
{
    // Create the request
    NSFetchRequest* request = [[NSFetchRequest alloc] init];
    [request setEntity:[RNSite entityInManagedObjectContext:self.managedObjectContext]];
    [request setPredicate:[NSPredicate predicateWithFormat:@"siteReference like %@", siteReference]];
    
    // Execute request
    NSError* error = nil;
    NSArray* fetchedProjects = [self.managedObjectContext executeFetchRequest:request error:&error];
    return !(fetchedProjects && [fetchedProjects count]>0);
}


@end
