//
//  RNGridLayout.m
//  RayNov
//
//  Created by Mathieu Cordebard on 29/11/2013.
//  Copyright (c) 2013 Mathieu Cordebard. All rights reserved.
//

#import "RNGridLayout.h"
#import "RNGridLayoutAttributes.h"

@implementation RNGridLayout

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


- (BOOL) isDeletionModeOn
{
    if ([[self.collectionView.delegate class] conformsToProtocol:@protocol(RNGridLayoutDelegate)]) {
        return [(id)self.collectionView.delegate isDeletionModeActiveForCollectionView:self.collectionView layout:self];
    }
    return NO;
}

+ (Class) layoutAttributesClass
{
    return [RNGridLayoutAttributes class];
}

- (RNGridLayoutAttributes*) layoutAttributesForItemAtIndexPath:(NSIndexPath*)indexPath
{
    RNGridLayoutAttributes* attributes = (RNGridLayoutAttributes*)[super layoutAttributesForItemAtIndexPath:indexPath];
    attributes.deleteButtonHidden = ![self isDeletionModeOn];
    return attributes;
}

- (NSArray*) layoutAttributesForElementsInRect:(CGRect)rect
{
    NSArray* attributesArrayInRect = [super layoutAttributesForElementsInRect:rect];
    for (RNGridLayoutAttributes* attribs in attributesArrayInRect) {
        attribs.deleteButtonHidden = ![self isDeletionModeOn];
    }
    return attributesArrayInRect;
}


@end
