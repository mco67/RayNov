//
//  RNSplitViewController.h
//  RayNov
//
//  Created by Mathieu Cordebard on 05/12/2013.
//  Copyright (c) 2013 Mathieu Cordebard. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RNSplitViewController : UIViewController

@end


#pragma mark - RNSplitViewControllerSegue

@interface RNSplitViewControllerSegue : UIStoryboardSegue

@property (strong) void(^performBlock)(RNSplitViewControllerSegue* segue, UIViewController* svc, UIViewController* dvc);

@end
