//
//  RNStore+RNSite.h
//  RayNov
//
//  Created by Mathieu Cordebard on 30/11/2013.
//  Copyright (c) 2013 Mathieu Cordebard. All rights reserved.
//

#import "RNStore.h"
#import "RNSite.h"

#define ERROR_DUPLICATE_SITE_NAME 1
#define ERROR_DUPLICATE_SITE_REFERENCE 2

@interface RNStore (RNSite)

- (RNSite*) createSite;
- (void) deleteSite:(RNSite*)project;

- (BOOL) checkSiteNameUnicity:(NSString*)siteName;
- (BOOL) checkSiteReferenceUnicity:(NSString*)siteReference;


- (NSFetchedResultsController*) createFetchedResultControllerWithDelegate:(id<NSFetchedResultsControllerDelegate>)delegate;
- (NSFetchedResultsController*) getSiteFetchedResultsCtrlWithSearch:(NSString*)searchString;

@end
