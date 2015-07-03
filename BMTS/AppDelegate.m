//
//  AppDelegate.m
//  BMTS
//
//  Created by JD Hatton on 11/5/14.
//  Copyright (c) 2014 Homeroom Technologies. All rights reserved.
//

#import "AppDelegate.h"
#import "UserRoleEnums.h"
#import "Classroom.h"
#import "ClassroomBehaviors.h"
#import "Behaviors.h"
#import "PaidEnum.h"
#import "User.h"
#import "Status.h"
#import "StatusEnums.h"
#import "UserCookie.h"
#import "IntervalEnum.h"
#import "ClassroomStudents.h"
#import "TeacherMainViewController.h"
#import "RestController.h"
#import "TeacherIpadMainViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

#define IDIOM    UI_USER_INTERFACE_IDIOM()
#define IPAD     UIUserInterfaceIdiomPad

@synthesize window = _window, zipCode, behaviorListData, intervalListData ;
@synthesize managedObjectContext = __managedObjectContext;
@synthesize managedObjectModel = __managedObjectModel;
@synthesize persistentStoreCoordinator = __persistentStoreCoordinator;
@synthesize userRemoteId, userPassword, teacherUser;


AppDelegate *appDelegate = nil;


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    NSLog(@"DEBUG:  >>   Loading AppDelegate. ::didFinishLaunchingWithOptions ");
    
    BOOL hasUserCookie = false;
    BOOL hasUser = FALSE;
    
    //
    // CoreData Setup
    //
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"AppDataModel" withExtension:@"momd"];
    __managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    NSManagedObjectContext *context = [self managedObjectContext];
  
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    
    teacherUser = [NSEntityDescription insertNewObjectForEntityForName:@"User" inManagedObjectContext:context];
    
    //
    // On App Startup lets check for the UserCookie, if found proceed to the main view.
    //
    NSError *error;
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"UserCookie" inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    for (UserCookie *info in fetchedObjects) {
        hasUserCookie = TRUE;
        NSLog(@"--------------------------------------------");
        NSLog(@" Found UserCookie : %@", info.userId);
        NSLog(@" Found UserCookie : %@", info.email);
        NSLog(@" Found UserCookie : %@", info.password);
        NSLog(@"--------------------------------------------");
        
    }
    
    NSFetchRequest *fetchRequest2 = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity2 = [NSEntityDescription entityForName:@"User" inManagedObjectContext:context];
    [fetchRequest2 setEntity:entity2];
    NSArray *fetchedObjects2 = [context executeFetchRequest:fetchRequest2 error:&error];
    for (User *user in fetchedObjects2) {
        hasUser = TRUE;
        NSLog(@"--------------------------------------------");
        NSLog(@" Found User : userId      :  %@", user.id);
        NSLog(@" Found User : email       :  %@", user.email);
        NSLog(@" Found User : role        :  %@", user.role);
        NSLog(@" Found User : zipcode     :  %@", user.zipCode);
        NSLog(@" Found User : district    :  %@", user.schoolDistrict);
        NSLog(@" Found User : grade       :  %@", user.schoolGrade);
        NSLog(@" Found User : firstName   :  %@", user.firstName);
        NSLog(@" Found User : lastName    :  %@", user.lastName);
        NSLog(@" Found User : gender      :  %@", user.gender);
        NSLog(@" Found User : schoolName  :  %@", user.schoolName);
        NSLog(@"--------------------------------------------");
        userRemoteId = user.remoteId;
        
    }
 
    NSFetchRequest *fetchRequest3 = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity3 = [NSEntityDescription entityForName:@"ClassroomBehaviors" inManagedObjectContext:context];
    [fetchRequest3 setEntity:entity3];
    NSArray *fetchedObjects3 = [context executeFetchRequest:fetchRequest3 error:&error];
    for (ClassroomBehaviors *crb in fetchedObjects3) {
        NSLog(@" AddStudentController:Exiting() ");
        NSLog(@" ----------------------------------------");
        NSLog(@" Found CRB : Id          : %@", crb.id);
        NSLog(@" Found CRB : studentId   : %@", crb.studentId );
        NSLog(@" Found CRB : status      : %@", crb.statusId);
        NSLog(@" Found CRB : behaviorId  : %@", crb.behaviorId);
        NSLog(@" Found CRB : intervalId  : %@", crb.trackingInterval);
        NSLog(@" ----------------------------------------");
        
    }
  
    //
    // Load the behaviors.
    //
    NSFetchRequest *fetchRequest4 = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity4 = [NSEntityDescription entityForName:@"Behaviors" inManagedObjectContext:context];
    [fetchRequest4 setEntity:entity4];
    NSArray *fetchedObjects4 = [context executeFetchRequest:fetchRequest4 error:&error];
    for (Behaviors *behavior in fetchedObjects4) {
        NSLog(@"   ");
        NSLog(@" ----------------------------------------");
        NSLog(@" Found Behavior : Id       : %@", behavior.id);
        NSLog(@" Found Behavior : name     : %@", behavior.name);
        NSLog(@" Found Behavior : descr    : %@", behavior.descr );
        NSLog(@" Found Behavior : synced   : %@", behavior.synced );
        NSLog(@" ----------------------------------------");
        
        
    }

    //
    // TODO: move both of these array data elements to a NSDefault List to be read in from disk synced to WS.
    //
    behaviorListData = [[NSMutableArray alloc] initWithObjects:
                        @"off task",
                        @"blurting out",
                        @"defiance",
                        @"out of seat",
                        @"work completion",
                        @"homework",
                        @"disruptive",
                        @"unsafe",
                        @"independent work",
                        @"group work",
                        @"partner work",
                        @"transitions",
                        @"specials classes",
                        @"recess",
                        @"hitting",
                        @"inappropriate language",
                        @"bully behavior",
                        @"talking back",
                        @"following directions",
                        @"hands to self",
                        @"hallway behavior",
                        @"lunchroom behavior",
                        @"manners",
                        @"showing patience",
                        nil];
                        

    
    
    intervalListData = [[NSArray alloc] initWithObjects:@"15 Minutes",
             @"30 Minutes", @"45 Minutes", @"1 Hour",
             @"2 Hours", @"3 Hours",
             @"4 Hours", @"5 Hours",
             @"6 Hours", @"Once a Day",
             @"Every Other Day", @"Once a Week",
             @"Every Other Week",@"Once a Month",@"Other",
             nil];
    
    
    //
    // Perform the data syncs on load up of the app.
    //
    if (appDelegate.userRemoteId == nil || appDelegate.userRemoteId == (id)[NSNull null]) {
        NSLog(@"\n >>>>  ..2A..    appDelegate.userRemoteId  is NULL  ");
        
    } else {
        NSLog(@"\n >>>>  ..2B..    appDelegate.userRemoteId  =   %@ ", appDelegate.userRemoteId);
        RestController *restCntrlr  = [RestController alloc];
        [restCntrlr syncComments: teacherUser];
        [restCntrlr syncBehaviors: teacherUser];
    }
    

    
    
    //
    // Goto Main View.
    //
    if(hasUser == TRUE && hasUserCookie == TRUE) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        
        //
        // TODO: once we have the other views completed we need to check the User.Role to determine the view to go to here.
        //
        
//        if ( IDIOM == IPAD ) {
//            /* do something specifically for iPad. */
//            TeacherIpadMainViewController *teacherIpadMainViewController = [storyboard instantiateViewControllerWithIdentifier:@"teacherIpadMainView"];
//            [self.window makeKeyAndVisible];
//            [self.window.rootViewController presentViewController:teacherIpadMainViewController animated:YES completion:NULL];
//        } else {
            /* do something specifically for iPhone or iPod touch. */
            TeacherMainViewController *teacherMainViewController = [storyboard instantiateViewControllerWithIdentifier:@"teacherMainView"];
            [self.window makeKeyAndVisible];
            [self.window.rootViewController presentViewController:teacherMainViewController animated:YES completion:NULL];
//        }
        

    } else {
        NSLog(@" FAILED TO FIND THE USERCOOKIE and USER to forward to main view - Showing Login/CreateAccount flow........ ");
    }
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}


#pragma mark - Core Data stack

// Returns the managed object context for the application.
// If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
- (NSManagedObjectContext *)managedObjectContext
{
    if (__managedObjectContext != nil) {
        return __managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        __managedObjectContext = [[NSManagedObjectContext alloc] init];
        [__managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return __managedObjectContext;
}

// Returns the managed object model for the application.
// If the model doesn't already exist, it is created from the application's model.
- (NSManagedObjectModel *)managedObjectModel
{
    if (__managedObjectModel != nil) {
        return __managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"AppDataModel" withExtension:@"momd"];
    __managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return __managedObjectModel;
}

// Returns the persistent store coordinator for the application.
// If the coordinator doesn't already exist, it is created and the application's store added to it.
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (__persistentStoreCoordinator != nil) {
        return __persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"AppDataModel.sqlite"];
    
    NSError *error = nil;
    __persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![__persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
         
         Typical reasons for an error here include:
         * The persistent store is not accessible;
         * The schema for the persistent store is incompatible with current managed object model.
         Check the error message to determine what the actual problem was.
         
         
         If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.
         
         If you encounter schema incompatibility errors during development, you can reduce their frequency by:
         * Simply deleting the existing store:
         [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil]
         
         * Performing automatic lightweight migration by passing the following dictionary as the options parameter:
         [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:YES], NSMigratePersistentStoresAutomaticallyOption, [NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption, nil];
         
         Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.
         
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return __persistentStoreCoordinator;
}

#pragma mark - Application's Documents directory

// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

@end
