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


typedef void(^RNClientEditButtonBlock)(RNClient* client);

@interface RNClientEditViewController : UITableViewController 

@property (copy, nonatomic) RNClientEditButtonBlock leftButtonBlock;
@property (copy, nonatomic) RNClientEditButtonBlock rightButtonBlock;
@property (strong, nonatomic) RNClient* client;

@end
