//
//  StudentStatusViewController.m
//  BMTS
//
//  Created by JD Hatton on 3/22/15.
//  Copyright (c) 2015 Homeroom Technologies. All rights reserved.
//

#import "StudentStatusViewController.h"
#import "AppDelegate.h"
#import "User.h"
#import "TeacherMainViewController.h"
#import "StudentBehaviors.h"
#import <QuartzCore/QuartzCore.h>
#import "App.h"
#import "IPhone5MainViewController.h"

@interface StudentStatusViewController ()

@end


@implementation StudentStatusViewController

@synthesize student, window = _window, greenButton, yellowButon, redButton, statusHeaderLabel;


int selectedStatus;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // NSLog(@"DEBUG: StudentStatusViewController::loading...   student = %@", student);
    
    
    NSString *headerText = [NSString stringWithFormat:@"%@%@%@", @"Select ", student.firstName, @"'s current status."];
    statusHeaderLabel.text = headerText;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)clickedGreenStatus:(id)sender {
    
    // NSLog(@"DEBUG: StudentStatusViewController::clickedGreenStatus()  setting selectedStatus");
    selectedStatus = 1; //App.STATUS_GREEN
    
    greenButton.layer.borderWidth=2.0f;
    greenButton.layer.borderColor=[[UIColor blackColor] CGColor];
    
    yellowButon.layer.borderWidth=0.0f;
    yellowButon.layer.borderColor=[[UIColor blackColor] CGColor];
    
    redButton.layer.borderWidth=0.0f;
    redButton.layer.borderColor=[[UIColor blackColor] CGColor];
}


- (IBAction)clickedYellowStatus:(id)sender {
    
    // NSLog(@"DEBUG: StudentStatusViewController::clickedYellowStatus()  setting selectedStatus");
    selectedStatus = 2;
    
    greenButton.layer.borderWidth=0.0f;
    greenButton.layer.borderColor=[[UIColor blackColor] CGColor];
    
    yellowButon.layer.borderWidth=2.0f;
    yellowButon.layer.borderColor=[[UIColor blackColor] CGColor];
    
    redButton.layer.borderWidth=0.0f;
    redButton.layer.borderColor=[[UIColor blackColor] CGColor];

}



- (IBAction)clickedRedStatus:(id)sender {
    // NSLog(@"DEBUG: StudentStatusViewController::clickedRedStatus()  setting selectedStatus");
    selectedStatus = 3;
    
    greenButton.layer.borderWidth=0.0f;
    greenButton.layer.borderColor=[[UIColor blackColor] CGColor];
    
    yellowButon.layer.borderWidth=0.0f;
    yellowButon.layer.borderColor=[[UIColor blackColor] CGColor];
    
    redButton.layer.borderWidth=2.0f;
    redButton.layer.borderColor=[[UIColor blackColor] CGColor];

}


- (IBAction)save:(id)sender {
    
    if( self.student != nil) {
        
        NSError *error;
        NSManagedObjectContext *context = [appDelegate managedObjectContext];
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"YYYY-MM-dd\'T\'HH:mm:ss"];
        NSString *stringFromDate = [formatter stringFromDate:[NSDate date]];
        
        // NSLog(@" Creating a new StudentBehaviors");
        StudentBehaviors *newStudentBehavior = [NSEntityDescription  insertNewObjectForEntityForName:@"StudentBehaviors" inManagedObjectContext:context];
        newStudentBehavior.createdDate =  stringFromDate;
        newStudentBehavior.studentId = self.student.id;
        newStudentBehavior.statusId = [NSNumber numberWithInt:selectedStatus];
        newStudentBehavior.synced = false;
      
//        
//                NSString *selBehavior = [self.behaviorArray objectAtIndex:selectedBehavior];
//                // NSLog(@" AddStudent String BEHAVIOR : %@", selBehavior);
//                newCRB.behaviorId = [NSNumber numberWithInteger: selectedBehavior];
//                // NSLog(@" AddStudent Added behavior : %@", newCRB.behaviorId);
        
        
        // NSLog(@"\n >>>> Add Student Behavior SAVING ");
        if (![context save:&error]) {
            // NSLog(@"\n\n ERROR!!!    Whoops, couldn't save: %@", [error localizedDescription]);
        } else {
        
 
            NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
            NSEntityDescription *entity = [NSEntityDescription entityForName:@"StudentBehaviors" inManagedObjectContext:context];
            
            [fetchRequest setEntity:entity];
            NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
            for (StudentBehaviors *behavior in fetchedObjects) {
                 NSLog(@" StudentStatusViewController::Exiting() ");
                 NSLog(@" ----------------------------------------");
                 NSLog(@" SAVED StudentBehaviors : studentId      :  %@", behavior.studentId);
                 NSLog(@" SAVED StudentBehaviors : statusId       :  %@", behavior.statusId);
                 NSLog(@" SAVED StudentBehaviors : createdDate    :  %@", behavior.createdDate);
                 NSLog(@" ----------------------------------------");
            }
        }
        
        
        //
        // Segue to the TeacherMainView
        //
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//        if( IS_IPHONE_5 ) {
//            //
//            // Segue to iphone5 view
//            //
//            NSLog(@"\n\n  FOUND iPHONE 5 !!!  \n\n  ");
//            
//            IPhone5MainViewController *teacherMainViewController = [storyboard instantiateViewControllerWithIdentifier:@"iPhone5MainView"];
//            [self.window makeKeyAndVisible];
//            [self.window.rootViewController presentViewController:teacherMainViewController animated:YES completion:NULL];
//        }
//        else {
            //
            // Segway to the TeacherMainView
            //
            TeacherMainViewController *teacherMainViewController = [storyboard instantiateViewControllerWithIdentifier:@"teacherMainView"];
            [self.window makeKeyAndVisible];
            [self.window.rootViewController presentViewController:teacherMainViewController animated:YES completion:NULL];
//        }
        

    }

 
    
}

- (IBAction)cancel:(id)sender {
    
        //
        // Segue to the TeacherMainView
        //
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//        if( IS_IPHONE_5 ) {
//            //
//            // Segue to iphone5 view
//            //
//            NSLog(@"\n\n  FOUND iPHONE 5 !!!  \n\n  ");
//            
//            IPhone5MainViewController *teacherMainViewController = [storyboard instantiateViewControllerWithIdentifier:@"iPhone5MainView"];
//            [self.window makeKeyAndVisible];
//            [self.window.rootViewController presentViewController:teacherMainViewController animated:YES completion:NULL];
//        }
//        else {
            //
            // Segway to the TeacherMainView
            //
            TeacherMainViewController *teacherMainViewController = [storyboard instantiateViewControllerWithIdentifier:@"teacherMainView"];
            [self.window makeKeyAndVisible];
            [self.window.rootViewController presentViewController:teacherMainViewController animated:YES completion:NULL];
//        }
}


@end
