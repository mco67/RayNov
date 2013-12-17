//
//  RNCreateProjectViewController.h
//  RayNov
//
//  Created by Mathieu Cordebard on 25/11/2013.
//  Copyright (c) 2013 Mathieu Cordebard. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^RNSiteEditButtonBlock)(RNSite* site);

@interface RNSiteEditViewController : UITableViewController

@property (copy, nonatomic) RNSiteEditButtonBlock leftButtonBlock;
@property (copy, nonatomic) RNSiteEditButtonBlock rightButtonBlock;
@property (strong, nonatomic) RNSite* site;

@end
