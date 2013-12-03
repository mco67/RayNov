//
//  NSString+RNString.m
//  RayNov
//
//  Created by Mathieu Cordebard on 03/12/2013.
//  Copyright (c) 2013 Mathieu Cordebard. All rights reserved.
//

#import "NSString+RNString.h"

@implementation NSString (RNString)

- (NSString*) stringGroupByFirstInitial
{
    NSString* temp = [self uppercaseString];
    if (!temp.length || temp.length == 1) return self;
    return [temp substringToIndex:1];
}

@end
