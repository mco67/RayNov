//
//  RNGridLayout.h
//  RayNov
//
//  Created by Mathieu Cordebard on 29/11/2013.
//  Copyright (c) 2013 Mathieu Cordebard. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol RNGridLayoutDelegate

@required
- (BOOL) isDeletionModeActiveForCollectionView:(UICollectionView*)collectionView layout:(UICollectionViewLayout*)collectionViewLayout;

@end

@interface RNGridLayout : UICollectionViewFlowLayout

@end
