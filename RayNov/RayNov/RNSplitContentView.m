//
//  RNSplitContentView.m
//  RayNov
//
//  Created by Mathieu Cordebard on 06/12/2013.
//  Copyright (c) 2013 Mathieu Cordebard. All rights reserved.
//

#import "RNSplitContentView.h"

#define MAS_SHORTHAND
#import <Masonry/Masonry.h>

#define TOP_OFFSET 64


@interface RNSplitContentView ()

@property (strong, nonatomic) UIView* leftView;
@property (strong, nonatomic) UIView* separatorView;
@property (strong, nonatomic) UIView* rightView;

@end


@implementation RNSplitContentView

- (id) initWithLeftView:(UIView*)leftView andRightView:(UIView*)rightView
{
    if (self = [super initWithFrame:CGRectNull]) {
        
        // Store subViews
        _leftView = leftView;
        _rightView = rightView;
        _separatorView = [[UIView alloc] initWithFrame:CGRectNull];
        _separatorView.backgroundColor = [UIColor lightGrayColor];
        
        // Append subViews
        [self addSubview:_leftView];
        [self addSubview:_rightView];
        [self addSubview:_separatorView];
        [self setupConstraints];
        
        // Set background color
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void) setupConstraints
{
    UIView* mainView = self;
    
    [_leftView makeConstraints:^(MASConstraintMaker* make){
        make.top.equalTo(mainView.top).with.offset(TOP_OFFSET);
        make.left.equalTo(mainView.left);
        make.width.equalTo(@300);
        make.bottom.equalTo(mainView.bottom);
    }];
    
    [_separatorView makeConstraints:^(MASConstraintMaker* make){
        make.top.equalTo(mainView.top).with.offset(TOP_OFFSET);
        make.left.equalTo(_leftView.right);
        make.width.equalTo(@1);
        make.bottom.equalTo(mainView.bottom);
    }];

    [_rightView makeConstraints:^(MASConstraintMaker* make){
        make.top.equalTo(mainView.top).with.offset(52);
        make.left.equalTo(_separatorView.right);
        make.right.equalTo(mainView.right);
        make.bottom.equalTo(mainView.bottom);
    }];
}


@end
