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
#import "AvatarViewController.h"
#import "CommentViewController.h"

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
            
            // studentOneAvatar, studentOneName, studentOneStatus, studentOneNote, studentOneSettings
            
            if(studentCount == 1){
                toolBarOne.hidden = NO;
                studentOneStatus.title = @"studentOneStatus";
                studentOneAvatar.title = @"studentOneAvatar";
                studentOneNote.title = @"studentOneNote";
                studentOneName.title = @"studentOneName";
                studentOneSettings.title = @"studentOneSettings";
                studentOneName.title = user.firstName;
                userOne = user;
                
            }
            else if(studentCount == 2){
                toolBarTwo.hidden = NO;
                studentTwoStatus.title = @"studentTwoStatus";
                studentTwoAvatar.title = @"studentTwoAvatar";
                studentTwoNote.title = @"studentTwoNote";
                studentTwoName.title = @"studentTwoName";
                studentTwoSettings.title = @"studentTwoSettings";
                studentTwoName.title = user.firstName;
                userTwo = user;
            }
            else if(studentCount == 3){
                toolBarThree.hidden = NO;
                studentThreeStatus.title = @"studentThreeStatus";
                studentThreeAvatar.title = @"studentThreeAvatar";
                studentThreeNote.title = @"studentThreeNote";
                studentThreeName.title = @"studentThreeName";
                studentThreeSettings.title = @"studentThreeSettings";
                studentThreeName.title = user.firstName;
                userThree = user;
            }
            else if(studentCount == 4){
                toolBarFour.hidden = NO;
                studentFourStatus.title = @"studentFourStatus";
                studentFourAvatar.title = @"studentFourAvatar";
                studentFourNote.title = @"studentFourNote";
                studentFourName.title = @"studentFourName";
                studentFourSettings.title = @"studentFourSettings";
                studentFourName.title = user.firstName;
                userFour = user;
            }
            else if(studentCount == 5){
                toolBarFive.hidden = NO;
                studentFiveStatus.title = @"studentFiveStatus";
                studentFiveAvatar.title = @"studentFiveAvatar";
                studentFiveNote.title = @"studentFiveNote";
                studentFiveName.title = @"studentFiveName";
                studentFiveSettings.title = @"studentFiveSettings";
                studentFiveName.title = user.firstName;
                userFive = user;
            }
            else if(studentCount == 6){
                toolBarSix.hidden = NO;
                studentSixStatus.title = @"studentSixStatus";
                studentSixAvatar.title = @"studentSixAvatar";
                studentSixNote.title = @"studentSixNote";
                studentSixName.title = @"studentSixName";
                studentSixSettings.title = @"studentSixSettings";
                studentSixName.title = user.firstName;
                userSix = user;
            }
            else if(studentCount == 7){
                toolBarSeven.hidden = NO;
                studentSevenStatus.title = @"studentSevenStatus";
                studentSevenAvatar.title = @"studentSevenAvatar";
                studentSevenNote.title = @"studentSevenNote";
                studentSevenName.title = @"studentSevenName";
                studentSevenSettings.title = @"studentSevenSettings";
                studentSevenName.title = user.firstName;
                userSeven = user;
            }
            else if(studentCount == 8){
                toolBarEight.hidden = NO;
                studentEightStatus.title = @"studentEightStatus";
                studentEightAvatar.title = @"studentEightAvatar";
                studentEightNote.title = @"studentEightNote";
                studentEightName.title = @"studentEightName";
                studentEightSettings.title = @"studentEightSettings";
                studentEightName.title = user.firstName;
                userEight = user;
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

- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender {
    
    return YES;
    
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
     NSLog(@"DEBUG:  TeacherMainView:: prepareForSegue()   ");
    
    //
    //
    // TODO: currently this is setup to use the status view controller only
    //       this method needs to add the selectedUse to the comment view controller
    //       and the settings view controller so this use is set on those when we segue.
    //
    //
    
    //
    // TODO: when tapping AddStudent we need to know that here and skip the processing here..
    //
    if([segue.identifier isEqualToString:@"addStudentSegue"]) {
        
        NSLog(@"DEBUG:  TeacherMainView:: prepareForSegue() TO ADD_STUDENT    ");
    } else {
    
        StudentStatusViewController *controller = (StudentStatusViewController *)segue.destinationViewController;
        CommentViewController *commentCtrl = (CommentViewController *)segue.destinationViewController;
        AvatarViewController *avatarCtrl = (AvatarViewController *)segue.destinationViewController;
        
        UserUIBarButtonItem *selected = sender;
        
        
        if( [selected.title  rangeOfString: @"studentOne" options: NSCaseInsensitiveSearch].location != NSNotFound  ){
            selectedStudent = userOne;
        } else if( [selected.title  rangeOfString: @"studentTwo" options: NSCaseInsensitiveSearch].location != NSNotFound   ){
            selectedStudent = userTwo;
        } else if( [selected.title  rangeOfString: @"studentThree" options: NSCaseInsensitiveSearch].location != NSNotFound  ){
            selectedStudent = userThree;
        } else if( [selected.title  rangeOfString: @"studentFour" options: NSCaseInsensitiveSearch].location != NSNotFound  ){
            selectedStudent = userFour;
        } else if( [selected.title  rangeOfString: @"studentFive" options: NSCaseInsensitiveSearch].location != NSNotFound  ){
            selectedStudent = userFive;
        } else if( [selected.title  rangeOfString: @"studentSix" options: NSCaseInsensitiveSearch].location != NSNotFound  ){
            selectedStudent = userSix;
        } else if( [selected.title  rangeOfString: @"studentSeven" options: NSCaseInsensitiveSearch].location != NSNotFound  ){
            selectedStudent = userSeven;
        } else if( [selected.title  rangeOfString: @"studentEight" options: NSCaseInsensitiveSearch].location != NSNotFound  ){
            selectedStudent = userEight;
        }
        
        controller.student = selectedStudent;
        commentCtrl.student = selectedStudent;
        avatarCtrl.student = selectedStudent;
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
