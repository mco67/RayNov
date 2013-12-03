//
//  RNProjectStore.h
//  RayNov
//
//  Created by Mathieu Cordebard on 26/11/2013.
//  Copyright (c) 2013 Mathieu Cordebard. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RNProject.h"

@interface RNStore : NSObject

@property (strong, nonatomic) NSManagedObjectContext* managedObjectContext;
@property (strong, nonatomic) NSManagedObjectModel* managedObjectModel;
@property (strong, nonatomic) NSPersistentStoreCoordinator* persistentStoreCoordinator;

+ (RNStore*) instance;

- (void) saveContext;
- (NSFetchedResultsController*) createRoomsFetchedResultControllerForProject:(RNProject*)project andDelegate:(id<NSFetchedResultsControllerDelegate>)delegate;
@end
