//
//  TeacherMainViewController.m
//  BMTS
//
//  Created by JD Hatton on 1/3/15.
//  Copyright (c) 2015 Homeroom Technologies. All rights reserved.
//

#import "AppDelegate.h"
#import "User.h"
#import "TeacherMainViewController.h"
#import "StudentStatusViewController.h"
#import "UserUIBarButtonItem.h"
#import "StudentStatusViewController.h"

@interface TeacherMainViewController ()

@end

@implementation TeacherMainViewController

@synthesize teacherHeader, addStudentButton, toolBarOne, toolBarTwo, toolBarThree, toolBarFour, toolBarFive, toolBarSix, toolBarSeven, toolBarEight, studentOneAvatar, studentOneName, studentOneStatus, studentOneNote, studentOneSettings,
studentTwoAvatar, studentTwoName, studentTwoStatus, studentTwoNote, studentTwoSettings,
studentThreeAvatar, studentThreeName, studentThreeStatus, studentThreeNote, studentThreeSettings,
studentFourAvatar, studentFourName, studentFourStatus, studentFourNote, studentFourSettings,
studentFiveAvatar, studentFiveName, studentFiveStatus, studentFiveNote, studentFiveSettings,
studentSixAvatar, studentSixName, studentSixStatus, studentSixNote, studentSixSettings,
studentSevenAvatar, studentSevenName, studentSevenStatus, studentSevenNote, studentSevenSettings,
studentEightAvatar, studentEightName, studentEightStatus, studentEightNote, studentEightSettings,window = _window;

User *selectedStudent;

User *userOne;
User *userTwo;
User *userThree;
User *userFour;
User *userFive;
User *userSix;
User *userSeven;
User *userEight;


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSLog(@"DEBUG: TeacherMainViewController::viewDidLoad()   --   LOADING...");
    
    NSString *userName = @"";
    //
    // Get the User = 1 for the teacher who installed app.
    //
    NSError *error;
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"User" inManagedObjectContext:context];
    
    [fetchRequest setEntity:entity];
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    for (User *user in fetchedObjects) {
        NSLog(@" RTeacherMainViewController::Exiting() ");
        NSLog(@" ----------------------------------------");
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
        NSLog(@" ----------------------------------------");
        
        if([user.id integerValue] == 1 ){
            userName = [NSString stringWithFormat:@"%@%@%@%@", user.firstName,@" ", user.lastName, @"'s Class Room "];
        }
        
    }

    
    //
    // Set the header label
    //
    
    teacherHeader.text = userName;
    [teacherHeader setFont:[UIFont fontWithName:@"Helvetica" size:17.0]];
    teacherHeader.textColor = [UIColor colorWithRed:(11/255.0) green:(11/255.0) blue:(11/255.0) alpha:1];
    
    
    //
    // Hide the toolbars, then show them for each student in the DB.
    //
    NSLog(@"DEBUG: TeacherMainViewController - Hiding the toolbars. ");
    
    toolBarOne.hidden = YES;
    toolBarTwo.hidden = YES;
    toolBarThree.hidden = YES;
    toolBarFour.hidden = YES;
    toolBarFive.hidden = YES;
    toolBarSix.hidden = YES;
    toolBarSeven.hidden = YES;
    toolBarEight.hidden = YES;
    
    //
    // For each student - show the toolbar and hookup the items.
    //
    NSInteger studentCount = 0;
    
    for (User *user in fetchedObjects) {
        NSLog(@" TeacherMainView ->  ");
        NSLog(@" ----------------------------------------");
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
        NSLog(@" ----------------------------------------");
        
        if([user.role integerValue] == 2 ){
            studentCount ++;
            NSLog(@" Found Student - [%ld]  : %@", (long)studentCount, user.firstName);
            
            if(studentCount == 1){
                toolBarOne.hidden = NO;
                studentOneStatus.title = @"studentOne";
                studentOneStatus.student = user;
                studentOneNote.student = user;
               // studentOneAvatar = user.avatar;
                studentOneName.title = user.firstName;
                
                userOne = user;
                
            }
            else if(studentCount == 2){
                toolBarTwo.hidden = NO;
                studentTwoStatus.student = user;
                studentTwoNote.student = user;
                // studentTwoAvatar = user.avatar;
                studentTwoName.title = user.firstName;
            }
            else if(studentCount == 3){
                toolBarThree.hidden = NO;
                studentThreeStatus.student = user;
                studentThreeNote.student = user;
                // studentThreeAvatar = user.avatar;
                studentThreeName.title = user.firstName;
            }
            else if(studentCount == 4){
                toolBarFour.hidden = NO;
                studentFourStatus.student = user;
                studentFourNote.student = user;
                // studentFourAvatar = user.avatar;
                studentFourName.title = user.firstName;
            }
            else if(studentCount == 5){
                toolBarFive.hidden = NO;
                studentFiveStatus.student = user;
                studentFiveNote.student = user;
                // studentFiveAvatar = user.avatar;
                studentFiveName.title = user.firstName;
            }
            else if(studentCount == 6){
                toolBarSix.hidden = NO;
                studentSixStatus.student = user;
                studentSixNote.student = user;
                // studentSixAvatar = user.avatar;
                studentSixName.title = user.firstName;
            }
            else if(studentCount == 7){
                toolBarSeven.hidden = NO;
                studentSevenStatus.student = user;
                studentSevenNote.student = user;
                // studentSevenAvatar = user.avatar;
                studentSevenName.title = user.firstName;
            }
            else if(studentCount == 8){
                toolBarEight.hidden = NO;
                studentEightStatus.student = user;
                studentEightNote.student = user;
                // studentEightAvatar = user.avatar;
                studentEightName.title = user.firstName;
            }
            else {
              NSLog(@" TOO MANY STUDENTS !!!  Fix!");
            }
        }
    }
 
    
    //
    // Currently we are capping the list of students at 8 so if we have eight lets hide the button.
    //
    if(studentCount > 7) {
        addStudentButton.hidden = YES;
    }
    
    
    NSLog(@"DEBUG: TeacherMainViewController LOADING COMPLETE...");
    
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
     NSLog(@"DEBUG:  TeacherMainView:: prepareForSegue()   ");
    
        if([segue.identifier isEqualToString:@"showStudentStatusSegue"]){
            StudentStatusViewController *controller = (StudentStatusViewController *)segue.destinationViewController;
            
            UserUIBarButtonItem *selected = sender;
            
            if( [selected.title  isEqual: @"studentOne"]  ){
                selectedStudent = userOne;  //studentOneStatus.student;
            }
            
            controller.student = selectedStudent;
        }
    
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


- (IBAction)clickedStudentOneStatus:(id)sender {
    
    NSLog(@"DEBUG:  TeacherMainView:: you clicked the STUDENT-1 status icon.   .");
    
    //
    // Segway to the TeacherMainView
    //
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    StudentStatusViewController *studentStatusViewController = [storyboard instantiateViewControllerWithIdentifier:@"studentStatusView"];
    studentStatusViewController.student = studentOneStatus.student;
    [self.window makeKeyAndVisible];
    [self.window.rootViewController presentViewController:studentStatusViewController animated:YES completion:NULL];
    
//    StudentStatusViewController *studentStatusViewCtrl = [self.storyboard instantiateViewControllerWithIdentifier:@"studentStatusView"];
//    studentStatusViewCtrl.student = studentOneStatus.student;
//    studentStatusViewCtrl.isSomethingEnabled = YES;
////    [self presentModalViewController:studentStatusViewCtrl animated:YES];
//    [self presentModalViewController:studentStatusViewCtrl animated:YES];

    
}










-(void)viewWillAppear:(BOOL)animated {
    
     NSLog(@"DEBUG: TeacherMainViewController  ---   RELOADING VIEW CONTROLLER --- BBBB - 1   - ");
     [self.view setNeedsDisplay];
     [self viewDidLoad];
    NSLog(@"DEBUG: TeacherMainViewController  ---   RELOADING VIEW CONTROLLER --- BBBB  - 2  - ");
    
}


// showStudentStatusSegue
//
//-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
//    if([segue.identifier isEqualToString:@"showStudentStatusSegue"]){
//        StudentStatusViewController *controller = (StudentStatusViewController *)segue.destinationViewController;
//        controller.student = selectedStudent;
//    }
//}



@end
