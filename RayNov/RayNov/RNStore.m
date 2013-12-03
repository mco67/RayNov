//
//  RNProjectStore.m
//  RayNov
//
//  Created by Mathieu Cordebard on 26/11/2013.
//  Copyright (c) 2013 Mathieu Cordebard. All rights reserved.
//

#import "RNStore.h"
#import "RNProject.h"
#import "RNRoom.h"

@interface  RNStore ()



@end


@implementation RNStore

#pragma mark - Singleton implementation

+ (RNStore*) instance
{
    static RNStore* store = nil;
    if (!store) store = [[RNStore alloc] init];
    return store;
}

- (id) init
{
    if (self = [super init]) {
        
        // Create the managedObjectModel
        NSURL* modelURL = [[NSBundle mainBundle] URLForResource:@"ProjectModel" withExtension:@"momd"];
        self.managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
        
        // Create the persistentStoreCoordinator
        NSURL* appliDirectoryURL = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
        NSURL* storeURL = [appliDirectoryURL URLByAppendingPathComponent:@"ProjectModel.sqlite"];
        NSError* error = nil;
        self.persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
        if (![self.persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }

        // Create the managedObjectContext
        self.managedObjectContext = [[NSManagedObjectContext alloc] init];
        [self.managedObjectContext setPersistentStoreCoordinator:self.persistentStoreCoordinator];
    }
    return self;
}


- (void) saveContext
{
    NSError *error = nil;
    if (self.managedObjectContext != nil) {
        if ([self.managedObjectContext hasChanges] && ![self.managedObjectContext save:&error]) {
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}



- (NSFetchedResultsController*) createRoomsFetchedResultControllerForProject:(RNProject*)project andDelegate:(id<NSFetchedResultsControllerDelegate>)delegate
{
    NSFetchRequest* fetchRequest = [[NSFetchRequest alloc] init];
    [fetchRequest setEntity:[RNRoom entityInManagedObjectContext:self.managedObjectContext]];
    [fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"project.siteName like %@", project.siteName]];
    [fetchRequest setFetchBatchSize:20];
    NSSortDescriptor* sort = [[NSSortDescriptor alloc] initWithKey:@"creationDate" ascending:NO];
    [fetchRequest setSortDescriptors:@[sort]];
    NSFetchedResultsController* fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
                                                                                               managedObjectContext:self.managedObjectContext
                                                                                                 sectionNameKeyPath:nil
                                                                                                          cacheName:@"Root"];
    fetchedResultsController.delegate = delegate;
    
    return fetchedResultsController;
}






@end
