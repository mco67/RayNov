//
//  RNMainRotateViewController.m
//  RayNov
//
//  Created by Mathieu Cordebard on 30/12/2013.
//  Copyright (c) 2013 Mathieu Cordebard. All rights reserved.
//

#import "RNMainRotateViewController.h"

@interface RNMainRotateViewController ()

@end

@implementation RNMainRotateViewController

- (id) initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onReceiveRotateNotification:) name:RN_ON_ROTATE_NOTIFICATION object:nil];
    }
    return self;
}

- (void) onReceiveRotateNotification:(id)object
{
    [self rotateViews];
}

@end
