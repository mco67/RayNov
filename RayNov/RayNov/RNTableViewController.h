//
//  RNTableViewController.h
//  RayNov
//
//  Created by Mathieu Cordebard on 07/12/2013.
//  Copyright (c) 2013 Mathieu Cordebard. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol RNTableViewControllerDelegate <NSObject>

- (void) onCellSelected:(id)object;

@end


@interface RNTableViewController : UITableViewController

@property (strong, nonatomic) id<RNTableViewControllerDelegate> delegate;
@property (weak, nonatomic) IBOutlet UISearchBar* searchBar;
@property (strong, nonatomic) NSFetchedResultsController* fetchedResultsController;
@property (strong, nonatomic) NSFetchedResultsController* searchFetchedResultsController;

- (NSFetchedResultsController*) fetchedResultsControllerForTableView:(UITableView*)tableView;

@end
