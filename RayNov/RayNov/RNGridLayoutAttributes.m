//
//  RNGridLayoutAttributes.m
//  RayNov
//
//  Created by Mathieu Cordebard on 29/11/2013.
//  Copyright (c) 2013 Mathieu Cordebard. All rights reserved.
//

#import "RNGridLayoutAttributes.h"

@implementation RNGridLayoutAttributes

- (id) copyWithZone:(NSZone *)zone
{
    RNGridLayoutAttributes* attributes = [super copyWithZone:zone];
    attributes.deleteButtonHidden = _deleteButtonHidden;
    return attributes;
}

- (BOOL) isEqual:(id)other {
    return NO;
}

@end
