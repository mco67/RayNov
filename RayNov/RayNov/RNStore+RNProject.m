//
//  RNStore+RNProject.m
//  RayNov
//
//  Created by Mathieu Cordebard on 30/11/2013.
//  Copyright (c) 2013 Mathieu Cordebard. All rights reserved.
//

#import "RNStore+RNProject.h"
#import "RNRoom.h"
#import "RNAddress.h"

@implementation RNStore (RNProject)

- (RNProject*) createProjectWithSiteName:(NSString*)siteName andSiteReference:(NSString*)siteRef andError:(NSError**)error
{
    // Check the projectName unicity
    if (![self checkSiteNameUnicity:siteName]) {
        *error = [NSError errorWithDomain:@"RNStore+RNProject" code:ERROR_DUPLICATE_SITE_NAME userInfo:nil];
        return nil;
    }
    
    // Check the projectReference unicity
    if (![self checkSiteReferenceUnicity:siteRef]) {
        *error = [NSError errorWithDomain:@"RNStore+RNProject" code:ERROR_DUPLICATE_SITE_REFERENCE userInfo:nil];
        return nil;
    }
    
    // Create and fill the new project object
    RNProject* project = [RNProject insertInManagedObjectContext:self.managedObjectContext];
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

- (void) deleteProject:(RNProject*)project
{
    [self.managedObjectContext deleteObject:project];
}

- (NSFetchedResultsController*) createFetchedResultControllerWithDelegate:(id<NSFetchedResultsControllerDelegate>)delegate
{
    NSFetchRequest* fetchRequest = [[NSFetchRequest alloc] init];
    [fetchRequest setEntity:[RNProject entityInManagedObjectContext:self.managedObjectContext]];
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



#pragma mark - Private methods

- (BOOL) checkSiteNameUnicity:(NSString*)siteName
{
    // Create the request
    NSFetchRequest* request = [[NSFetchRequest alloc] init];
    [request setEntity:[RNProject entityInManagedObjectContext:self.managedObjectContext]];
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
    [request setEntity:[RNProject entityInManagedObjectContext:self.managedObjectContext]];
    [request setPredicate:[NSPredicate predicateWithFormat:@"siteReference like %@", siteReference]];
    
    // Execute request
    NSError* error = nil;
    NSArray* fetchedProjects = [self.managedObjectContext executeFetchRequest:request error:&error];
    return !(fetchedProjects && [fetchedProjects count]>0);
}


@end
