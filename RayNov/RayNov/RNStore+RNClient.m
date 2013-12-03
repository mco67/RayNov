//
//  RNStore+RNClient.m
//  RayNov
//
//  Created by Mathieu Cordebard on 30/11/2013.
//  Copyright (c) 2013 Mathieu Cordebard. All rights reserved.
//

#import "RNStore+RNClient.h"
#import "RNClient.h"
#import "RNAddress.h"
#import "NSString+RNString.h"

@implementation RNStore (RNClient)

- (RNClient*) createClientWithLastName:(NSString*)lastName andFirstName:(NSString*)firstName andError:(NSError**)error
{
    
    // Check the clientName unicity
    if (![self checkClientNameUnicityWithLastName:lastName andFirstName:firstName]) {
        *error = [NSError errorWithDomain:@"RNStore+RNClient" code:ERROR_DUPLICATE_CLIENTNAME userInfo:nil];
        return nil;
    }
    
    // Create and fill the new client object
    RNClient* client = [RNClient insertInManagedObjectContext:self.managedObjectContext];
    client.firstName = firstName;
    client.lastName = lastName;
    
    // Create the associate address object
    RNAddress* clientAddress = [RNAddress insertInManagedObjectContext:self.managedObjectContext];
    client.address = clientAddress;
    
    return client;
}

- (NSFetchedResultsController*) getClientFetchedResultsCtrlWithDelegate:(id<NSFetchedResultsControllerDelegate>)delegate
{
    NSFetchRequest* fetchRequest = [[NSFetchRequest alloc] init];
    [fetchRequest setEntity:[RNClient entityInManagedObjectContext:self.managedObjectContext]];
    NSSortDescriptor* sort = [[NSSortDescriptor alloc] initWithKey:@"lastName" ascending:NO];
    [fetchRequest setSortDescriptors:@[sort]];
    [fetchRequest setFetchBatchSize:20];
    
    NSFetchedResultsController* fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
                                                                                               managedObjectContext:self.managedObjectContext
                                                                                                 sectionNameKeyPath:@"lastName.stringGroupByFirstInitial"
                                                                                                          cacheName:@"Root"];
    fetchedResultsController.delegate = delegate;
    
    return fetchedResultsController;
}


- (NSFetchedResultsController*) getSearchFetchedResultsCtrlWithSearch:(NSString*)searchString andDelegate:(id<NSFetchedResultsControllerDelegate>)delegate
{
    NSArray* sortDescriptors = @[[[NSSortDescriptor alloc] initWithKey:@"lastName" ascending:NO]];
    NSPredicate* filterPredicate = nil;
    
    // Create the fetchRequest for the entity.
    NSFetchRequest* fetchRequest = [[NSFetchRequest alloc] init];
    [fetchRequest setEntity:[RNClient entityInManagedObjectContext:self.managedObjectContext]];
    
    // Compute predicate array
    NSMutableArray* predicateArray = [NSMutableArray array];
    if (searchString.length) {
        // your search predicate(s) are added to this array
        [predicateArray addObject:[NSPredicate predicateWithFormat:@"firstName CONTAINS[cd] %@", searchString]];
        [predicateArray addObject:[NSPredicate predicateWithFormat:@"lastName CONTAINS[cd] %@", searchString]];

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
    fetchedResultsController.delegate = delegate;
    
    NSError *error = nil;
    if (![fetchedResultsController performFetch:&error])
    {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    return fetchedResultsController;
}

#pragma mark - Private methods

- (BOOL) checkClientNameUnicityWithLastName:(NSString*)clientLastName andFirstName:(NSString*)clientFirstName
{
    // Create the request
    NSFetchRequest* request = [[NSFetchRequest alloc] init];
    [request setEntity:[RNClient entityInManagedObjectContext:self.managedObjectContext]];
    [request setPredicate:[NSPredicate predicateWithFormat:@"(lastName like %@) AND (firstName like %@)", clientLastName, clientFirstName]];
    
    // Execute request
    NSError* error = nil;
    NSArray* fetchedProjects = [self.managedObjectContext executeFetchRequest:request error:&error];
    return !(fetchedProjects && [fetchedProjects count]>0);
}


@end
