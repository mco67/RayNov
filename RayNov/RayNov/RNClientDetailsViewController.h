//
//  RNClientInfoViewController.h
//  RayNov
//
//  Created by Mathieu Cordebard on 02/12/2013.
//  Copyright (c) 2013 Mathieu Cordebard. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RNClient.h"
#import "RNClientTableViewController.h"

@interface RNClientDetailsViewController : UITableViewController

@property (strong, nonatomic) RNClient* client;

@end
