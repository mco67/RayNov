//
//  RNStore+RNProject.h
//  RayNov
//
//  Created by Mathieu Cordebard on 30/11/2013.
//  Copyright (c) 2013 Mathieu Cordebard. All rights reserved.
//

#import "RNStore.h"

#define ERROR_DUPLICATE_SITE_NAME 1
#define ERROR_DUPLICATE_SITE_REFERENCE 2

@interface RNStore (RNProject)

- (RNProject*) createProjectWithSiteName:(NSString*)siteName
                        andSiteReference:(NSString*)siteRef
                                andError:(NSError**)error;

- (void) deleteProject:(RNProject*)project;

- (NSFetchedResultsController*) createFetchedResultControllerWithDelegate:(id<NSFetchedResultsControllerDelegate>)delegate;

@end
