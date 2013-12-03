//
//  RNRoomsLayout.m
//  RayNov
//
//  Created by Mathieu Cordebard on 29/11/2013.
//  Copyright (c) 2013 Mathieu Cordebard. All rights reserved.
//

#import "RNRoomsLayout.h"

@implementation RNRoomsLayout

- (id) init
{
    if (self = [super init]) {
        self.itemSize = CGSizeMake(144, 144);
        self.minimumInteritemSpacing = 8;
        self.minimumLineSpacing = 8;
        self.scrollDirection = UICollectionViewScrollDirectionVertical;
        self.sectionInset = UIEdgeInsetsMake(32, 32, 32, 32);
    }
    return self;
}

@end
