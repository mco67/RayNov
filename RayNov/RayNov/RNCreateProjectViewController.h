//
//  RNCreateProjectViewController.h
//  RayNov
//
//  Created by Mathieu Cordebard on 25/11/2013.
//  Copyright (c) 2013 Mathieu Cordebard. All rights reserved.
//

#import <UIKit/UIKit.h>


@class RNCreateProjectViewController;


@protocol RNCreateProjectViewControllerDelegate <NSObject>

- (void) createProjectViewControllerDidCancel:(RNCreateProjectViewController*)controller;
- (void) createProjectViewControllerDidApply:(RNCreateProjectViewController*)controller;

@end


@interface RNCreateProjectViewController : UITableViewController

@property (weak, nonatomic) id<RNCreateProjectViewControllerDelegate> delegate;

@end
