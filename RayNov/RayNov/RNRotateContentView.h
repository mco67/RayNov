//
//  RNRotateContentView.h
//  RayNov
//
//  Created by Mathieu Cordebard on 30/12/2013.
//  Copyright (c) 2013 Mathieu Cordebard. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RNRotateContentView : UIView

- (id) initWithFrontView:(UIView*)frontView andRearView:(UIView*)rearView;
- (void) rotateViews;

@end
