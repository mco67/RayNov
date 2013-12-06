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

@property (strong, nonatomic) UIView* menuView;
@property (strong, nonatomic) UIView* separatorView;
@property (strong, nonatomic) UIView* detailsView;

@end


@implementation RNSplitContentView

- (id) initWithMenuView:(UIView*)menuView andDetailsView:(UIView*)detailsView
{
    if (self = [super initWithFrame:CGRectNull]) {
        
        // Store subViews
        _menuView = menuView;
        _detailsView = detailsView;
        _separatorView = [[UIView alloc] initWithFrame:CGRectNull];
        _separatorView.backgroundColor = [UIColor lightGrayColor];
        
        // Append subViews
        [self addSubview:_menuView];
        [self addSubview:_detailsView];
        [self addSubview:_separatorView];
        [self setupConstraints];
    }
    return self;
}

- (void) setupConstraints
{
    UIView* mainView = self;
    
    [_menuView makeConstraints:^(MASConstraintMaker* make){
        make.top.equalTo(mainView.top).with.offset(TOP_OFFSET);
        make.left.equalTo(mainView.left);
        make.width.equalTo(@300);
        make.bottom.equalTo(mainView.bottom);
    }];
    
    [_separatorView makeConstraints:^(MASConstraintMaker* make){
        make.top.equalTo(mainView.top).with.offset(TOP_OFFSET);
        make.left.equalTo(_menuView.right);
        make.width.equalTo(@1);
        make.bottom.equalTo(mainView.bottom);
    }];

    [_detailsView makeConstraints:^(MASConstraintMaker* make){
        make.top.equalTo(mainView.top).with.offset(TOP_OFFSET);
        make.left.equalTo(_separatorView.right);
        make.right.equalTo(mainView.right);
        make.bottom.equalTo(mainView.bottom);
    }];
}


@end
