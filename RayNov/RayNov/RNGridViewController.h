//
//  RNGridViewController.h
//  RayNov
//
//  Created by Mathieu Cordebard on 29/11/2013.
//  Copyright (c) 2013 Mathieu Cordebard. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RNGridLayout.h"

@interface RNGridViewController : UICollectionViewController

@property (strong, nonatomic) NSFetchedResultsController* fetchedResultsController;

@end
