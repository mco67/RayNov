//
//  RNClientEditViewController.h
//  RayNov
//
//  Created by Mathieu Cordebard on 06/12/2013.
//  Copyright (c) 2013 Mathieu Cordebard. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RNClientTableViewController.h"
#import "RNClient.h"

@protocol RNClientEditViewControllerDelegate <NSObject>

- (void) onClientModified:(RNClient*)client;

@end

@interface RNClientEditViewController : UITableViewController 

@property (weak, nonatomic) id<RNClientEditViewControllerDelegate> delegate;
@property (strong, nonatomic) RNClient* client;

@end
