//
//  AppDelegate.h
//  BMTS
//
//  Created by JD Hatton on 11/5/14.
//  Copyright (c) 2014 Homeroom Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "User.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (strong, nonatomic) NSString *zipCode;
@property (strong, nonatomic) NSString *userRemoteId;
@property (strong, nonatomic) NSString *userPassword;
@property (strong, nonatomic) NSMutableArray *behaviorListData;
@property (strong, nonatomic) NSArray *intervalListData;

@property (strong, nonatomic) User *teacherUser;

extern AppDelegate *appDelegate;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end

