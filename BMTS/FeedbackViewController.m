//
//  FeedbackViewController.m
//  BMTS
//
//  Created by JD Hatton on 3/21/15.
//  Copyright (c) 2015 Homeroom Technologies. All rights reserved.
//

#import "FeedbackViewController.h"

@interface FeedbackViewController ()

@end

@implementation FeedbackViewController

@synthesize student, feedback;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)textFieldShouldReturn:(UITextField *)commentTextField
{
    
    NSLog(@"DEBUG: saving the comment.");
    NSLog(@"DEBUG: hiding the keyboard.");
    NSLog(@"DEBUG: done.");
    
    [self.feedback resignFirstResponder];
    return YES;
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)saveComment:(id)sender {
    
     NSLog(@"DEBUG: Saving Feedback... ");
}

- (IBAction)saveFormData:(id)sender {
    
    
    NSLog(@"DEBUG: Saving Feedback... ");
    
//    
//    if( self.student != nil) {
//        
//        
//        
//        NSError *error;
//        NSManagedObjectContext *context = [appDelegate managedObjectContext];
//        
//        //
//        // Create a new classroomBehavior record for the student-behavior-interval
//        //
//        NSLog(@" Creating a new StudentBehaviors");
//        StudentBehaviors *newStudentBehavior = [NSEntityDescription  insertNewObjectForEntityForName:@"StudentBehaviors" inManagedObjectContext:context];
//        newStudentBehavior.createdDate =  [NSDate date];
//        newStudentBehavior.studentId = self.student.id;
//        newStudentBehavior.statusId = [NSNumber numberWithInt:selectedStatus];
//        NSLog(@" Createing a new StudentBehaviors - 2  ");
//        
//        //        NSString *selBehavior = [self.behaviorArray objectAtIndex:selectedBehavior];
//        //        NSLog(@" AddStudent String BEHAVIOR : %@", selBehavior);
//        //        newCRB.behaviorId = [NSNumber numberWithInteger: selectedBehavior];
//        //        NSLog(@" AddStudent Added behavior : %@", newCRB.behaviorId);
//        
//        NSLog(@" AddStudent SAVING ");
//        if (![context save:&error]) {
//            NSLog(@"\n\n ERROR!!!    Whoops, couldn't save: %@", [error localizedDescription]);
//        } else {
//            
//            
//            
//            //
//            // Dump the saved behaviors for this student
//            //
//            NSError *error;
//            NSManagedObjectContext *context = [appDelegate managedObjectContext];
//            
//            NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
//            NSEntityDescription *entity = [NSEntityDescription entityForName:@"StudentBehaviors" inManagedObjectContext:context];
//            
//            [fetchRequest setEntity:entity];
//            NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
//            for (StudentBehaviors *behavior in fetchedObjects) {
//                NSLog(@" StudentStatusViewController::Exiting() ");
//                NSLog(@" ----------------------------------------");
//                NSLog(@" Found StudentBehaviors : studentId      :  %@", behavior.studentId);
//                NSLog(@" Found StudentBehaviors : statusId       :  %@", behavior.statusId);
//                NSLog(@" Found StudentBehaviors : createdDate    :  %@", behavior.createdDate);
//                NSLog(@" ----------------------------------------");
//            }
//            
//            
//            
//            //
//            // savedStatusSegue to the TeacherMainView
//            //
//            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//            TeacherMainViewController *teacherMainViewController = [storyboard instantiateViewControllerWithIdentifier:@"teacherMainView"];
//            [self.window makeKeyAndVisible];
//            [self.window.rootViewController presentViewController:teacherMainViewController animated:YES completion:NULL];
//            
//        }
//        
//    }
    
 
}


@end