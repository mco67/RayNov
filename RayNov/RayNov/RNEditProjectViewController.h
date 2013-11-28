//
//  RNEditProjectViewController.h
//  RayNov
//
//  Created by Mathieu Cordebard on 27/11/2013.
//  Copyright (c) 2013 Mathieu Cordebard. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RNEditProjectViewController;

@protocol RNEditProjectViewControllerDelegate <NSObject>

- (void) editProjectViewControllerDidCancel:(RNEditProjectViewController*)controller;

@end


@interface RNEditProjectViewController : UIViewController

@property (weak, nonatomic) id<RNEditProjectViewControllerDelegate> delegate;
 
@end
