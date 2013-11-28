//
//  RNProjectsLayout.h
//  RayNov
//
//  Created by Mathieu Cordebard on 28/11/2013.
//  Copyright (c) 2013 Mathieu Cordebard. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol RNProjectsLayoutDelegate

@required
- (BOOL) isDeletionModeActiveForCollectionView:(UICollectionView*)collectionView layout:(UICollectionViewLayout*)collectionViewLayout;

@end


@interface RNProjectsLayout : UICollectionViewFlowLayout

@end
