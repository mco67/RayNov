//
//  RNProjectStore.h
//  RayNov
//
//  Created by Mathieu Cordebard on 26/11/2013.
//  Copyright (c) 2013 Mathieu Cordebard. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RNProject.h"

@interface RNProjectStore : NSObject

+ (RNProjectStore*) instance;

- (RNProject*) createProjectWithName:(NSString*)projectName andError:(NSError**)error;
- (void) deleteProject:(RNProject*)project;

- (NSFetchedResultsController*) createFetchedResultControllerWithDelegate:(id<NSFetchedResultsControllerDelegate>)delegate;
- (void) saveContext;

@end
