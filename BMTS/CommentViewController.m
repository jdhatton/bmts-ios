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
#import "IPhone5MainViewController.h"


@interface CommentViewController ()

@end

@implementation CommentViewController

@synthesize student, commentTextField, headerLabel;


- (void)viewDidLoad {
    [super viewDidLoad];
    // //NSLog(@"DEBUG: CommentViewController::loading...   student = %@", student);
    
    //
    // TODO: trying this to see if this is OK.
    //
    if(self.student == nil){
        //NSLog(@"DEBUG: StudentViewController::appDelegate.currentSelectedStudent    =    %@",appDelegate.currentSelectedStudent);
        self.student = appDelegate.currentSelectedStudent;
    }
    
    
    NSString *headerText = [NSString stringWithFormat:@"%@%@", @"Comments for ", student.firstName];
    headerLabel.text = headerText;
    
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
//                                   initWithTarget:self
//                                   action:@selector(dismissKeyboard)];
//    [self.view addGestureRecognizer:tap];
    
    self.commentTextField.autocapitalizationType = UITextAutocapitalizationTypeSentences;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)textFieldShouldReturn:(UITextField *)commentTextField
{
   
    // //NSLog(@"DEBUG: saving the comment.");
    // //NSLog(@"DEBUG: hiding the keyboard.");
    // //NSLog(@"DEBUG: done.");
    
    [self.commentTextField resignFirstResponder];
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
    
    if( self.student != nil) {
        
        NSError *error;
        NSManagedObjectContext *context = [appDelegate managedObjectContext];
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"YYYY-MM-dd\'T\'HH:mm:ss"];
        NSString *stringFromDate = [formatter stringFromDate:[NSDate date]];
        
        Comments *newComment = [NSEntityDescription  insertNewObjectForEntityForName:@"Comments" inManagedObjectContext:context];
        newComment.createdDate =  stringFromDate;
        newComment.studentId = [self.student.id stringValue]; 
        newComment.comment = self.commentTextField.text;
        newComment.synced = 0L;
 
        // //NSLog(@" Add Comments SAVING ");
        if (![context save:&error]) {
            // //NSLog(@"\n\n ERROR!!!    Whoops, couldn't save: %@", [error localizedDescription]);
        } else {
            //
            // Nothing to do here ??
            //
        }
        
//        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
//        NSEntityDescription *entity = [NSEntityDescription entityForName:@"Comments" inManagedObjectContext:context];
//        
//        [fetchRequest setEntity:entity];
//        NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
//        for (Comments *comment in fetchedObjects) {
//            // //NSLog(@" StudentStatusViewController::Exiting() ");
//            // //NSLog(@" ----------------------------------------");
//            // //NSLog(@" Saved Comments : studentId      :  %@", comment.studentId);
//            // //NSLog(@" Saved Comments : statusId       :  %@", comment.comment);
//            // //NSLog(@" Saved Comments : createdDate    :  %@", comment.createdDate);
//            // //NSLog(@" Saved Comments : synced         :  %@", comment.synced);
//            // //NSLog(@" ----------------------------------------");
//        }
        
        //
        // Segue to the TeacherMainView
        //
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//        if( IS_IPHONE_5 ) {
//            //
//            // Segue to iphone5 view
//            //
//            //NSLog(@"\n\n  FOUND iPHONE 5 !!!  \n\n  ");
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


@end
