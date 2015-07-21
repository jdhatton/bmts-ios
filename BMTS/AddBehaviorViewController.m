//
//  AddBehaviorViewController.m
//  Homeroom
//
//  Created by JD Hatton on 6/25/15.
//  Copyright (c) 2015 Homeroom Technologies. All rights reserved.
//

#import "AddBehaviorViewController.h"
#import "AddStudentViewController.h"
#import "AppDelegate.h"
#import "Behaviors.h"

@interface AddBehaviorViewController ()

@end

@implementation AddBehaviorViewController


@synthesize behavior, saveBehavior;
@synthesize window = _window;

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)save:(id)sender {
    
    // NSLog(@" SAVING a new Behavior   :   %@", behavior.text);
    //
    // Save the value of behavior to the list of behaviors then go back to
    //  Add Student view refreshing the list.
    //
    //[[appDelegate behaviorListData] addObject:behavior.text];
    if( [behavior.text length] > 0){
        NSError *error;
        NSManagedObjectContext *context = [appDelegate managedObjectContext];
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
        NSEntityDescription *entity = [NSEntityDescription entityForName:@"Behaviors" inManagedObjectContext:context];
        [fetchRequest setEntity:entity];
        NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
        
        NSUInteger count = [context countForFetchRequest:fetchRequest error:&error];
        if(count == NSNotFound) {
            //Handle error
        }
        // NSLog(@" Behavior count  :   %lu", (unsigned long)count);
        
        for (Behaviors *behavior in fetchedObjects) {
            // NSLog(@" ----------------------------------------");
            // NSLog(@" Behavior : Id        :  %@", behavior.id);
            // NSLog(@" Behavior : name      :  %@", behavior.name);
            // NSLog(@" Behavior : descr     :  %@", behavior.descr);
            // NSLog(@" Behavior : synced    :  %@", behavior.synced);
            // NSLog(@" ----------------------------------------");
        }
        
        //
        // save to the database?
        //
        Behaviors *newBehavior = [NSEntityDescription  insertNewObjectForEntityForName:@"Behaviors" inManagedObjectContext:context];
        count ++;
        newBehavior.id = [NSNumber numberWithInteger:count];
        newBehavior.name = behavior.text;
        newBehavior.descr = behavior.text;
        newBehavior.synced = false;
        // NSLog(@" Creating a new Behavior  ");
        
        // NSLog(@" AddBehavior SAVING ");
        if (![context save:&error]) {
            // NSLog(@"\n\n ERROR!!!    Whoops, couldn't save: %@", [error localizedDescription]);
        } else {
            // NSLog(@"\n SUCCESS  - Behavior - UPDATED  ");
        }
        
        //
        // Call the rest service to save the behaviors on the server.
        //
        //    RestController *restCntrlr  = [RestController alloc];
        //    [restCntrlr addStudent: newUser];
        
        //
        // Segue back to Add Student
        //
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        AddStudentViewController *addStudentViewController = [storyboard instantiateViewControllerWithIdentifier:@"AddStudent"];
        [self.window makeKeyAndVisible];
        [self.window.rootViewController presentViewController:addStudentViewController animated:YES completion:NULL];
    } else {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        AddStudentViewController *addStudentViewController = [storyboard instantiateViewControllerWithIdentifier:@"AddStudent"];
        [self.window makeKeyAndVisible];
        [self.window.rootViewController presentViewController:addStudentViewController animated:YES completion:NULL];
    }
    
}


@end
