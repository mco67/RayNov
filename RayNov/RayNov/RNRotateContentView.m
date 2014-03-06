//
//  RNRotateContentView.m
//  RayNov
//
//  Created by Mathieu Cordebard on 30/12/2013.
//  Copyright (c) 2013 Mathieu Cordebard. All rights reserved.
//

#import "RNRotateContentView.h"

#define MAS_SHORTHAND
#import <Masonry/Masonry.h>

@interface RNRotateContentView ()

@property (strong, nonatomic) UIView* frontView;
@property (strong, nonatomic) UIView* rearView;
@property (nonatomic) BOOL front;

@end

@implementation RNRotateContentView

- (id) initWithFrontView:(UIView*)frontView andRearView:(UIView*)rearView
{
    if (self = [super initWithFrame:CGRectMake(0,0,1,1)]) {
        
        // Store subViews
        _frontView = frontView;
        _rearView = rearView;
        _front = YES;
    
        
        // Append subViews
        [self addSubview:_rearView];
        [self addSubview:_frontView];
        [self setupConstraints];
        
        // Set background color
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void) setupConstraints
{
    UIView* mainView = self;
    _frontView.frame = mainView.frame;
    _rearView.frame = mainView.frame;
}

- (void) rotateViews
{
    UIView* fromView = self.front?self.frontView:self.rearView;
    UIView* toView = self.front?self.rearView:self.frontView;
    UIViewAnimationOptions animation = self.front?UIViewAnimationOptionTransitionFlipFromBottom:UIViewAnimationOptionTransitionFlipFromTop;
    [UIView transitionFromView:fromView toView:toView duration:0.8 options: animation completion: ^(BOOL inFinished) {self.front = !self.front;}];
}

@end
