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

@interface StudentStatusViewController ()

@end


@implementation StudentStatusViewController

@synthesize student, window = _window, greenButton, yellowButon, redButton;



int selectedStatus;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"DEBUG: StudentStatusViewController::loading...   student = %@", student);
    
   
    
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
    
    NSLog(@"DEBUG: StudentStatusViewController::clickedGreenStatus()  setting selectedStatus");
    selectedStatus = 1;
    
    greenButton.layer.borderWidth=2.0f;
    greenButton.layer.borderColor=[[UIColor blackColor] CGColor];
    
    yellowButon.layer.borderWidth=0.0f;
    yellowButon.layer.borderColor=[[UIColor blackColor] CGColor];
    
    redButton.layer.borderWidth=0.0f;
    redButton.layer.borderColor=[[UIColor blackColor] CGColor];
}


- (IBAction)clickedYellowStatus:(id)sender {
    
    NSLog(@"DEBUG: StudentStatusViewController::clickedYellowStatus()  setting selectedStatus");
    selectedStatus = 2;
    
    greenButton.layer.borderWidth=0.0f;
    greenButton.layer.borderColor=[[UIColor blackColor] CGColor];
    
    yellowButon.layer.borderWidth=2.0f;
    yellowButon.layer.borderColor=[[UIColor blackColor] CGColor];
    
    redButton.layer.borderWidth=0.0f;
    redButton.layer.borderColor=[[UIColor blackColor] CGColor];

}



- (IBAction)clickedRedStatus:(id)sender {
    NSLog(@"DEBUG: StudentStatusViewController::clickedRedStatus()  setting selectedStatus");
    selectedStatus = 3;
    
    greenButton.layer.borderWidth=0.0f;
    greenButton.layer.borderColor=[[UIColor blackColor] CGColor];
    
    yellowButon.layer.borderWidth=0.0f;
    yellowButon.layer.borderColor=[[UIColor blackColor] CGColor];
    
    redButton.layer.borderWidth=2.0f;
    redButton.layer.borderColor=[[UIColor blackColor] CGColor];

}






- (IBAction)save:(id)sender {
    
    NSLog(@"DEBUG: you touched the createAccount button");
    
    NSLog(@"DEBUG: validating the form when clicking create account.");
    
    
    if( self.student != nil) {
        
        
        
        NSError *error;
        NSManagedObjectContext *context = [appDelegate managedObjectContext];
        
        //
        // Create a new classroomBehavior record for the student-behavior-interval
        //
        NSLog(@" Creating a new StudentBehaviors");
        StudentBehaviors *newStudentBehavior = [NSEntityDescription  insertNewObjectForEntityForName:@"StudentBehaviors" inManagedObjectContext:context];
        newStudentBehavior.createdDate =  [NSDate date];
        newStudentBehavior.studentId = self.student.id;
        newStudentBehavior.statusId = [NSNumber numberWithInt:selectedStatus];
        NSLog(@" Createing a new StudentBehaviors - 2  ");
        
        //        NSString *selBehavior = [self.behaviorArray objectAtIndex:selectedBehavior];
        //        NSLog(@" AddStudent String BEHAVIOR : %@", selBehavior);
        //        newCRB.behaviorId = [NSNumber numberWithInteger: selectedBehavior];
        //        NSLog(@" AddStudent Added behavior : %@", newCRB.behaviorId);
        
        NSLog(@" AddStudent SAVING ");
        if (![context save:&error]) {
            NSLog(@"\n\n ERROR!!!    Whoops, couldn't save: %@", [error localizedDescription]);
        } else {
            
            
            
            //
            // Dump the saved behaviors for this student
            //
            NSError *error;
            NSManagedObjectContext *context = [appDelegate managedObjectContext];
            
            NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
            NSEntityDescription *entity = [NSEntityDescription entityForName:@"StudentBehaviors" inManagedObjectContext:context];
            
            [fetchRequest setEntity:entity];
            NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
            for (StudentBehaviors *behavior in fetchedObjects) {
                NSLog(@" StudentStatusViewController::Exiting() ");
                NSLog(@" ----------------------------------------");
                NSLog(@" Found StudentBehaviors : studentId      :  %@", behavior.studentId);
                NSLog(@" Found StudentBehaviors : statusId       :  %@", behavior.statusId);
                NSLog(@" Found StudentBehaviors : createdDate    :  %@", behavior.createdDate);
                NSLog(@" ----------------------------------------");
            }
            
            
            
            //
            // savedStatusSegue to the TeacherMainView
            //
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            TeacherMainViewController *teacherMainViewController = [storyboard instantiateViewControllerWithIdentifier:@"teacherMainView"];
            [self.window makeKeyAndVisible];
            [self.window.rootViewController presentViewController:teacherMainViewController animated:YES completion:NULL];
            
        }

    }

 
    
}


@end
