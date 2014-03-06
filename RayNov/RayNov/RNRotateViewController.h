//
//  RNRotateViewController.h
//  RayNov
//
//  Created by Mathieu Cordebard on 30/12/2013.
//  Copyright (c) 2013 Mathieu Cordebard. All rights reserved.
//

#import <UIKit/UIKit.h>


#pragma mark - RNRotateViewController

@interface RNRotateViewController : UIViewController

@property (strong, nonatomic) UIViewController* frontViewController;
@property (strong, nonatomic) UIViewController* rearViewController;

- (void) rotateViews;

@end


#pragma mark - RNRotateViewControllerSegue

@interface RNRotateViewControllerSegue : UIStoryboardSegue

@property (strong) void(^performBlock)(RNRotateViewControllerSegue* segue, UIViewController* svc, UIViewController* dvc);

@end
