//
//  RNClientTableViewCell.h
//  RayNov
//
//  Created by Mathieu Cordebard on 03/12/2013.
//  Copyright (c) 2013 Mathieu Cordebard. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RNClientTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel* displayName;
@property (weak, nonatomic) IBOutlet UILabel* displayAddress;

@end
