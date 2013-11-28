//
//  RNProjectsLayoutAttributes.m
//  RayNov
//
//  Created by Mathieu Cordebard on 28/11/2013.
//  Copyright (c) 2013 Mathieu Cordebard. All rights reserved.
//

#import "RNProjectsLayoutAttributes.h"

@implementation RNProjectsLayoutAttributes

- (id) copyWithZone:(NSZone *)zone
{
    RNProjectsLayoutAttributes* attributes = [super copyWithZone:zone];
    attributes.deleteButtonHidden = _deleteButtonHidden;
    return attributes;
}

- (BOOL) isEqual:(id)other {
    return NO;
}
@end;