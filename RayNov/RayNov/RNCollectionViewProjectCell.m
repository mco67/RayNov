//
//  RNCollectionViewProjectCell.m
//  RayNov
//
//  Created by Mathieu Cordebard on 27/11/2013.
//  Copyright (c) 2013 Mathieu Cordebard. All rights reserved.
//

#import "RNCollectionViewProjectCell.h"
#define MAS_SHORTHAND
#import <Masonry/Masonry.h>

@interface RNCollectionViewProjectCell ()

@property (retain, nonatomic) UILabel* nameLabel;

@end


@implementation RNCollectionViewProjectCell

- (id) initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectNull];
        
        // Append subViews
        [self addSubview:_nameLabel];
        [self setupConstraints];
        
        // Handle look&feel
        self.backgroundColor = [UIColor blueColor];
        _nameLabel.textColor = [UIColor whiteColor];
    }
    return self;
}

- (void) setupConstraints
{
    UIView* mainView = self;
    
    [_nameLabel makeConstraints:^(MASConstraintMaker* make){
        make.left.equalTo(mainView.left);
        make.right.equalTo(mainView.right);
        make.bottom.equalTo(mainView.bottom);
        make.width.equalTo(mainView.width);
        make.height.equalTo(@40);
    }];
}

- (void) setProjectName:(NSString*)projectName
{
    _projectName = projectName;
    _nameLabel.text = projectName;
}

@end
