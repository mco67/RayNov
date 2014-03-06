//
//  RNTestViewController.m
//  RayNov
//
//  Created by Mathieu Cordebard on 30/12/2013.
//  Copyright (c) 2013 Mathieu Cordebard. All rights reserved.
//

#import "RNTestViewController.h"
#import "RNMainRotateViewController.h"

@interface RNTestViewController ()

@end

@implementation RNTestViewController

- (IBAction) onBackAction
{
    [[NSNotificationCenter defaultCenter] postNotificationName:RN_ON_ROTATE_NOTIFICATION object:nil userInfo:nil];
}

@end
