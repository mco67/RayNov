//
//  RNCollectionViewProjectCell.m
//  RayNov
//
//  Created by Mathieu Cordebard on 27/11/2013.
//  Copyright (c) 2013 Mathieu Cordebard. All rights reserved.
//

#import "RNCollectionViewProjectCell.h"
#import <QuartzCore/QuartzCore.h>

#define MARGIN 2

@interface RNCollectionViewProjectCell ()

@property (strong, nonatomic) UIView* insetView;
@property (strong, nonatomic) UILabel* nameLabel;
@property (strong, nonatomic) UIImage* deleteButtonImage;

@end


@implementation RNCollectionViewProjectCell

- (id) initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.layer.shouldRasterize = YES;
        
        // Create the insetView
        self.insetView = [[UIView alloc] initWithFrame:CGRectInset(self.bounds, self.bounds.size.width/8, self.bounds.size.height/8)];
        [self.contentView addSubview:_insetView];
        
        // Create the nameLabel
        self.nameLabel = [[UILabel alloc] initWithFrame:[self.insetView bounds]];
        self.nameLabel.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleHeight;
        self.nameLabel.textAlignment = NSTextAlignmentCenter;
        self.nameLabel.numberOfLines = 3;
        self.nameLabel.lineBreakMode = NSLineBreakByWordWrapping;
        float dim = MIN(self.nameLabel.bounds.size.width, self.nameLabel.bounds.size.height);
        self.nameLabel.clipsToBounds = YES;
        self.nameLabel.layer.cornerRadius = dim/8;
        self.nameLabel.layer.opacity = 0.7;
        self.nameLabel.layer.borderColor = [UIColor darkGrayColor].CGColor;
        self.nameLabel.layer.borderWidth = 1.0;
        self.nameLabel.font = [UIFont systemFontOfSize:dim/6];
        self.nameLabel.backgroundColor = [UIColor lightGrayColor];
        [self.insetView addSubview:self.nameLabel];
        
        self.deleteButton = [[UIButton alloc] initWithFrame:CGRectMake(frame.size.width/16, frame.size.width/16, frame.size.width/4, frame.size.width/4)];
        if (!self.deleteButtonImage)
        {
            CGRect buttonFrame = self.deleteButton.frame;
            UIGraphicsBeginImageContext(buttonFrame.size);
            CGFloat sz = MIN(buttonFrame.size.width, buttonFrame.size.height);
            UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(buttonFrame.size.width/2, buttonFrame.size.height/2) radius:sz/2-MARGIN startAngle:0 endAngle:M_PI * 2 clockwise:YES];
            [path moveToPoint:CGPointMake(MARGIN, MARGIN)];
            [path addLineToPoint:CGPointMake(sz-MARGIN, sz-MARGIN)];
            [path moveToPoint:CGPointMake(MARGIN, sz-MARGIN)];
            [path addLineToPoint:CGPointMake(sz-MARGIN, MARGIN)];
            [[UIColor redColor] setFill];
            [[UIColor whiteColor] setStroke];
            [path setLineWidth:3.0];
            [path fill];
            [path stroke];
            self.deleteButtonImage = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
        }
        [self.deleteButton setImage:self.deleteButtonImage forState:UIControlStateNormal];
        [self.contentView addSubview:self.deleteButton];
    }
    return self;
}

- (void) setProjectName:(NSString*)projectName
{
    _projectName = projectName;
    _nameLabel.text = projectName;
}

@end
