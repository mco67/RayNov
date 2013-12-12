//
//  RNCreateProjectViewController.h
//  RayNov
//
//  Created by Mathieu Cordebard on 25/11/2013.
//  Copyright (c) 2013 Mathieu Cordebard. All rights reserved.
//

#import <UIKit/UIKit.h>


@class RNSiteEditViewController;


@protocol RNSiteEditViewControllerDelegate <NSObject>

- (void) onSiteModified:(RNSite*)site;

@end

@interface RNSiteEditViewController : UITableViewController

@property (weak, nonatomic) id<RNSiteEditViewControllerDelegate> delegate;
@property (strong, nonatomic) RNSite* site;

@end
