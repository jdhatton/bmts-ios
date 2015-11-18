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

#define IS_IPHONE_5 ( [ [ UIScreen mainScreen ] bounds ].size.height == 568 )
#define IS_WIDESCREEN_IOS7 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )
#define IS_WIDESCREEN_IOS8 ( fabs( ( double )[ [ UIScreen mainScreen ] nativeBounds ].size.height - ( double )1136 ) < DBL_EPSILON )
#define IS_WIDESCREEN      ( ( [ [ UIScreen mainScreen ] respondsToSelector: @selector( nativeBounds ) ] ) ? IS_WIDESCREEN_IOS8 : IS_WIDESCREEN_IOS7 )

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

@property (strong, nonatomic) NSString *deviceID;

extern AppDelegate *appDelegate;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end

