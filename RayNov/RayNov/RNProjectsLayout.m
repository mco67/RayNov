//
//  RNProjectsLayout.m
//  RayNov
//
//  Created by Mathieu Cordebard on 28/11/2013.
//  Copyright (c) 2013 Mathieu Cordebard. All rights reserved.
//

#import "RNProjectsLayout.h"
#import "RNProjectsLayoutAttributes.h"

@implementation RNProjectsLayout

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
    if ([[self.collectionView.delegate class] conformsToProtocol:@protocol(RNProjectsLayoutDelegate)])
    {
        return [(id)self.collectionView.delegate isDeletionModeActiveForCollectionView:self.collectionView layout:self];
    }
    return NO;
}

+ (Class) layoutAttributesClass
{
    return [RNProjectsLayoutAttributes class];
}

- (RNProjectsLayoutAttributes*) layoutAttributesForItemAtIndexPath:(NSIndexPath*)indexPath
{
    RNProjectsLayoutAttributes* attributes = (RNProjectsLayoutAttributes*) [super layoutAttributesForItemAtIndexPath:indexPath];
    if ([self isDeletionModeOn])
        attributes.deleteButtonHidden = NO;
    else
        attributes.deleteButtonHidden = YES;
    return attributes;
}

- (NSArray*)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSArray *attributesArrayInRect = [super layoutAttributesForElementsInRect:rect];
    for (RNProjectsLayoutAttributes* attribs in attributesArrayInRect)
    {
        if ([self isDeletionModeOn]) attribs.deleteButtonHidden = NO;
        else attribs.deleteButtonHidden = YES;
    }
    return attributesArrayInRect;
}

@end
