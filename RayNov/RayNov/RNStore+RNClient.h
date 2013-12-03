//
//  RNStore+RNClient.h
//  RayNov
//
//  Created by Mathieu Cordebard on 30/11/2013.
//  Copyright (c) 2013 Mathieu Cordebard. All rights reserved.
//

#import "RNStore.h"
#import "RNClient.h"

#define ERROR_DUPLICATE_CLIENTNAME 1

@interface RNStore (RNClient)

- (RNClient*) createClientWithLastName:(NSString*)lastName andFirstName:(NSString*)firstName andError:(NSError**)error;

- (NSFetchedResultsController*) getSearchFetchedResultsCtrlWithSearch:(NSString*)searchString andDelegate:(id<NSFetchedResultsControllerDelegate>)delegate;

@end
