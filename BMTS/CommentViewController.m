//
//  CommentViewController.m
//  BMTS
//
//  Created by JD Hatton on 1/6/15.
//  Copyright (c) 2015 Homeroom Technologies. All rights reserved.
//

#import "CommentViewController.h"
#import "Comments.h"
#import "AppDelegate.h"
#import "TeacherMainViewController.h"


@interface CommentViewController ()

@end

@implementation CommentViewController

@synthesize student, commentTextField, headerLabel;


- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"DEBUG: CommentViewController::loading...   student = %@", student);
    
    
    NSString *headerText = [NSString stringWithFormat:@"%@%@", @"Comments for ", student.firstName];
    headerLabel.text = headerText;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
    
    self.commentTextField.autocapitalizationType = UITextAutocapitalizationTypeSentences;
    
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
    
    [commentTextField resignFirstResponder];
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
    
    
    NSLog(@"DEBUG: Saving Comment... ");
    
    
        if( self.student != nil) {
    
    
    
            NSError *error;
            NSManagedObjectContext *context = [appDelegate managedObjectContext];
    
            //
            // Create a new classroomBehavior record for the student-behavior-interval
            //
            NSLog(@" Creating a new StudentBehaviors");
            Comments *newComment = [NSEntityDescription  insertNewObjectForEntityForName:@"Comments" inManagedObjectContext:context];
            newComment.createdDate =  [NSDate date];
            newComment.studentId = self.student.id;
            newComment.comment = self.commentTextField.text;
            NSLog(@" Creating a new Comments - 2  ");
    
            NSLog(@" Add Comments SAVING ");
            if (![context save:&error]) {
                NSLog(@"\n\n ERROR!!!    Whoops, couldn't save: %@", [error localizedDescription]);
            } else {
    
    
    
                //
                // Dump the saved behaviors for this student
                //
                NSError *error;
                NSManagedObjectContext *context = [appDelegate managedObjectContext];
    
                NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
                NSEntityDescription *entity = [NSEntityDescription entityForName:@"Comments" inManagedObjectContext:context];
    
                [fetchRequest setEntity:entity];
                NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
                for (Comments *comment in fetchedObjects) {
                    NSLog(@" StudentStatusViewController::Exiting() ");
                    NSLog(@" ----------------------------------------");
                    NSLog(@" Found Comments : studentId      :  %@", comment.studentId);
                    NSLog(@" Found Comments : statusId       :  %@", comment.comment);
                    NSLog(@" Found Comments : createdDate    :  %@", comment.createdDate);
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
