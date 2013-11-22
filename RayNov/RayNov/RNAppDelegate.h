//
//  RNAppDelegate.h
//  RayNov
//
//  Created by Mathieu Cordebard on 22/11/2013.
//  Copyright (c) 2013 Mathieu Cordebard. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RNAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow* window;
@property (readonly, strong, nonatomic) NSManagedObjectContext* managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel* managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator* persistentStoreCoordinator;

@end
