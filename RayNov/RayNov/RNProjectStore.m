//
//  RNProjectStore.m
//  RayNov
//
//  Created by Mathieu Cordebard on 26/11/2013.
//  Copyright (c) 2013 Mathieu Cordebard. All rights reserved.
//

#import "RNProjectStore.h"
#import "RNProject.h"

@interface  RNProjectStore ()

@property (strong, nonatomic) NSManagedObjectContext* managedObjectContext;
@property (strong, nonatomic) NSManagedObjectModel* managedObjectModel;
@property (strong, nonatomic) NSPersistentStoreCoordinator* persistentStoreCoordinator;

@end


@implementation RNProjectStore

#pragma mark - Singleton implementation

+ (RNProjectStore*) instance
{
    static RNProjectStore* store = nil;
    if (!store) store = [[RNProjectStore alloc] init];
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

- (RNProject*) createProjectWithName:(NSString*)projectName andError:(NSError**)error
{
    // Check the projectName unicity
    if (![self checkProjectNameUnicity:projectName]) {
        *error = [NSError errorWithDomain:@"RNStore" code:1 userInfo:nil];
        return nil;
    }
    
    // Create the new project object
    RNProject* project = [RNProject insertInManagedObjectContext:self.managedObjectContext];
    project.name = projectName;
    project.creationDate = [NSDate date];
    
    return project;
}

- (void) deleteProject:(RNProject*)project
{
    [self.managedObjectContext deleteObject:project];
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



- (BOOL) checkProjectNameUnicity:(NSString*)projectName
{
    // Create the request
    NSFetchRequest* request = [[NSFetchRequest alloc] init];
    [request setEntity:[RNProject entityInManagedObjectContext:self.managedObjectContext]];
    [request setPredicate:[NSPredicate predicateWithFormat:@"name like %@", projectName]];
    
    // Execute request
    NSError* error = nil;
    NSArray* fetchedProjects = [self.managedObjectContext executeFetchRequest:request error:&error];
    return !(fetchedProjects && [fetchedProjects count]>0);
}



@end
