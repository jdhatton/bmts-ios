//
//  IPhone5MainViewController.m
//  Homeroom
//
//  Created by JD Hatton on 8/13/15.
//  Copyright (c) 2015 Homeroom Technologies. All rights reserved.
//

#import "IPhone5MainViewController.h"
#import "AppDelegate.h"
#import "User.h"
#import "StudentStatusViewController.h"
#import "UserUIBarButtonItem.h"
#import "StudentStatusViewController.h"
#import "AvatarViewController.h"
#import "CommentViewController.h"
#import "ManageStudentViewController.h"
#import "StudentMainView.h"

@interface IPhone5MainViewController ()

@end

@implementation IPhone5MainViewController
@synthesize teacherHeader, window = _window, addStudentButton;
@synthesize toolBarOne, toolBarTwo, toolBarThree, toolBarFour, toolBarFive, toolBarSix, studentOneName, studentOneStatus, studentOneNote, studentOneSettings,
 studentTwoName, studentTwoStatus, studentTwoNote, studentTwoSettings,
 studentThreeName, studentThreeStatus, studentThreeNote, studentThreeSettings,
 studentFourName, studentFourStatus, studentFourNote, studentFourSettings,
 studentFiveName, studentFiveStatus, studentFiveNote, studentFiveSettings,
 studentSixName, studentSixStatus, studentSixNote, studentSixSettings;

User *selectedStudent;

User *userOne;
User *userTwo;
User *userThree;
User *userFour;
User *userFive;
User *userSix;



- (void)viewDidLoad {
    [super viewDidLoad];
    
    // //NSLog(@"DEBUG: TeacherMainViewController::viewDidLoad()   --   LOADING...");
    
    NSNumber *STATUS_GREEN = [NSNumber numberWithInt:1];
    NSNumber *STATUS_YELLOW = [NSNumber numberWithInt:2];
    NSNumber *STATUS_RED = [NSNumber numberWithInt:3];
    
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
        // //NSLog(@" RTeacherMainViewController::Exiting() ");
        // //NSLog(@" ----------------------------------------");
        // //NSLog(@" Found User : userId      :  %@", user.id);
        // //NSLog(@" Found User : email       :  %@", user.email);
        // //NSLog(@" Found User : role        :  %@", user.role);
        // //NSLog(@" Found User : zipcode     :  %@", user.zipCode);
        // //NSLog(@" Found User : district    :  %@", user.schoolDistrict);
        // //NSLog(@" Found User : grade       :  %@", user.schoolGrade);
        // //NSLog(@" Found User : firstName   :  %@", user.firstName);
        // //NSLog(@" Found User : lastName    :  %@", user.lastName);
        // //NSLog(@" Found User : gender      :  %@", user.gender);
        // //NSLog(@" Found User : schoolName  :  %@", user.schoolName);
        // //NSLog(@" Found User : remoteId    :  %@", user.remoteId);
        // //NSLog(@" ----------------------------------------");
        
        if([user.id integerValue] == 1 ){
            userName = [NSString stringWithFormat:@"%@%@%@%@", user.firstName,@" ", user.lastName, @"'s Class Room "];
            appDelegate.teacherUser.remoteId = user.remoteId;
            appDelegate.userRemoteId = user.remoteId;
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
    // //NSLog(@"DEBUG: TeacherMainViewController - Hiding the toolbars. ");
    
    toolBarOne.hidden = YES;
    toolBarTwo.hidden = YES;
    toolBarThree.hidden = YES;
    toolBarFour.hidden = YES;
    toolBarFive.hidden = YES;
    toolBarSix.hidden = YES;

    
    //
    // For each student - show the toolbar and hookup the items.
    //
    NSInteger studentCount = 0;
    
    for (User *user in fetchedObjects) {
        // //NSLog(@" TeacherMainView ->  ");
        // //NSLog(@" ----------------------------------------");
        // //NSLog(@" Found User : userId      :  %@", user.id);
        // //NSLog(@" Found User : email       :  %@", user.email);
        // //NSLog(@" Found User : role        :  %@", user.role);
        // //NSLog(@" Found User : zipcode     :  %@", user.zipCode);
        // //NSLog(@" Found User : district    :  %@", user.schoolDistrict);
        // //NSLog(@" Found User : grade       :  %@", user.schoolGrade);
        // //NSLog(@" Found User : firstName   :  %@", user.firstName);
        // //NSLog(@" Found User : lastName    :  %@", user.lastName);
        // //NSLog(@" Found User : gender      :  %@", user.gender);
        // //NSLog(@" Found User : schoolName  :  %@", user.schoolName);
        // //NSLog(@" Found User : status      :  %@", user.status);
        // //NSLog(@" ----------------------------------------");
        
        if([user.role integerValue] == 2 ){
            studentCount ++;
            // //NSLog(@" Found Student - [%ld]  : %@", (long)studentCount, user.firstName);
            
            // studentOneAvatar, studentOneName, studentOneStatus, studentOneNote, studentOneSettings
            
            if(studentCount == 1){
                toolBarOne.hidden = NO;
                studentOneStatus.accessibilityIdentifier = @"studentOneStatus";
                //studentOneAvatar.accessibilityIdentifier = @"studentOneAvatar";
                studentOneNote.accessibilityIdentifier = @"studentOneNote";
                studentOneName.accessibilityIdentifier = @"studentOneName";
                studentOneSettings.accessibilityIdentifier = @"studentOneSettings";
                studentOneName.title = user.firstName;
                userOne = user;
                
                // //NSLog(@"  Student Status - [%ld]  : %@", (long)studentCount, user.status);
                if([user.status intValue] == [STATUS_GREEN intValue]){
                    studentOneStatus.tintColor = [UIColor greenColor];
                    //   [[ self.studentOneStatus.class appearance] setImage:greenCircle] ;
                } else if( [user.status intValue] == [STATUS_YELLOW intValue]){
                    studentOneStatus.tintColor = [UIColor yellowColor];
                    //  [[ self.studentOneStatus.class appearance] setImage:yellowCircle] ;
                    
                } else if( [user.status intValue] == [STATUS_RED intValue]){
                    studentOneStatus.tintColor = [UIColor redColor];
                    //  [[ self.studentOneStatus.class appearance] setImage:redCircle] ;
                }
                
            }
            else if(studentCount == 2){
                toolBarTwo.hidden = NO;
                studentTwoStatus.accessibilityIdentifier = @"studentTwoStatus";
               // studentTwoAvatar.accessibilityIdentifier = @"studentTwoAvatar";
                studentTwoNote.accessibilityIdentifier = @"studentTwoNote";
                studentTwoName.accessibilityIdentifier = @"studentTwoName";
                studentTwoSettings.accessibilityIdentifier = @"studentTwoSettings";
                studentTwoName.title = user.firstName;
                userTwo = user;
                
                if( [user.status intValue] == [STATUS_GREEN intValue]){
                    studentTwoStatus.tintColor = [UIColor greenColor];
                    //   [[ self.studentOneStatus.class appearance] setImage:greenCircle] ;
                } else if( [user.status intValue] == [STATUS_YELLOW intValue]){
                    studentTwoStatus.tintColor = [UIColor yellowColor];
                    //  [[ self.studentOneStatus.class appearance] setImage:yellowCircle] ;
                    
                } else if( [user.status intValue] == [STATUS_RED intValue]){
                    studentTwoStatus.tintColor = [UIColor redColor];
                    //  [[ self.studentOneStatus.class appearance] setImage:redCircle] ;
                }
            }
            else if(studentCount == 3){
                toolBarThree.hidden = NO;
                studentThreeStatus.accessibilityIdentifier = @"studentThreeStatus";
              //  studentThreeAvatar.accessibilityIdentifier = @"studentThreeAvatar";
                studentThreeNote.accessibilityIdentifier = @"studentThreeNote";
                studentThreeName.accessibilityIdentifier = @"studentThreeName";
                studentThreeSettings.accessibilityIdentifier = @"studentThreeSettings";
                studentThreeName.title = user.firstName;
                userThree = user;
                
                if( [user.status intValue] == [STATUS_GREEN intValue]){
                    studentThreeStatus.tintColor = [UIColor greenColor];
                    //   [[ self.studentOneStatus.class appearance] setImage:greenCircle] ;
                } else if( [user.status intValue] == [STATUS_YELLOW intValue]){
                    studentThreeStatus.tintColor = [UIColor yellowColor];
                    //  [[ self.studentOneStatus.class appearance] setImage:yellowCircle] ;
                    
                } else if( [user.status intValue] == [STATUS_RED intValue]){
                    studentThreeStatus.tintColor = [UIColor redColor];
                    //  [[ self.studentOneStatus.class appearance] setImage:redCircle] ;
                }
            }
            else if(studentCount == 4){
                toolBarFour.hidden = NO;
                studentFourStatus.accessibilityIdentifier = @"studentFourStatus";
              //  studentFourAvatar.accessibilityIdentifier = @"studentFourAvatar";
                studentFourNote.accessibilityIdentifier = @"studentFourNote";
                studentFourName.accessibilityIdentifier = @"studentFourName";
                studentFourSettings.accessibilityIdentifier = @"studentFourSettings";
                studentFourName.title = user.firstName;
                userFour = user;
                
                if( [user.status intValue] == [STATUS_GREEN intValue]){
                    studentFourStatus.tintColor = [UIColor greenColor];
                    //   [[ self.studentOneStatus.class appearance] setImage:greenCircle] ;
                } else if( [user.status intValue] == [STATUS_YELLOW intValue]){
                    studentFourStatus.tintColor = [UIColor yellowColor];
                    //  [[ self.studentOneStatus.class appearance] setImage:yellowCircle] ;
                    
                } else if( [user.status intValue] == [STATUS_RED intValue]){
                    studentFourStatus.tintColor = [UIColor redColor];
                    //  [[ self.studentOneStatus.class appearance] setImage:redCircle] ;
                }
            }
            else if(studentCount == 5){
                toolBarFive.hidden = NO;
                studentFiveStatus.accessibilityIdentifier = @"studentFiveStatus";
               // studentFiveAvatar.accessibilityIdentifier = @"studentFiveAvatar";
                studentFiveNote.accessibilityIdentifier = @"studentFiveNote";
                studentFiveName.accessibilityIdentifier = @"studentFiveName";
                studentFiveSettings.accessibilityIdentifier = @"studentFiveSettings";
                studentFiveName.title = user.firstName;
                userFive = user;
                
                if( [user.status intValue] == [STATUS_GREEN intValue]){
                    studentFiveStatus.tintColor = [UIColor greenColor];
                    //   [[ self.studentOneStatus.class appearance] setImage:greenCircle] ;
                } else if( [user.status intValue] == [STATUS_YELLOW intValue]){
                    studentFiveStatus.tintColor = [UIColor yellowColor];
                    //  [[ self.studentOneStatus.class appearance] setImage:yellowCircle] ;
                    
                } else if( [user.status intValue] == [STATUS_RED intValue]){
                    studentFiveStatus.tintColor = [UIColor redColor];
                    //  [[ self.studentOneStatus.class appearance] setImage:redCircle] ;
                }
            }
            else if(studentCount == 6){
                toolBarSix.hidden = NO;
                studentSixStatus.accessibilityIdentifier = @"studentSixStatus";
            //    studentSixAvatar.accessibilityIdentifier = @"studentSixAvatar";
                studentSixNote.accessibilityIdentifier = @"studentSixNote";
                studentSixName.accessibilityIdentifier = @"studentSixName";
                studentSixSettings.accessibilityIdentifier = @"studentSixSettings";
                studentSixName.title = user.firstName;
                userSix = user;
                
                if( [user.status intValue] == [STATUS_GREEN intValue]){
                    studentSixStatus.tintColor = [UIColor greenColor];
                    //   [[ self.studentOneStatus.class appearance] setImage:greenCircle] ;
                } else if( [user.status intValue] == [STATUS_YELLOW intValue]){
                    studentSixStatus.tintColor = [UIColor yellowColor];
                    //  [[ self.studentOneStatus.class appearance] setImage:yellowCircle] ;
                    
                } else if( [user.status intValue] == [STATUS_RED intValue]){
                    studentSixStatus.tintColor = [UIColor redColor];
                    //  [[ self.studentOneStatus.class appearance] setImage:redCircle] ;
                }
            }
           
            else {
                // //NSLog(@" TOO MANY STUDENTS !!!  Fix!");
            }
        }
    }
    
    
    //
    // Currently we are capping the list of students at 8 so if we have eight lets hide the button.
    //
    if(studentCount > 7) {
        addStudentButton.hidden = YES;
    }
    
    
    // //NSLog(@"DEBUG: TeacherMainViewController LOADING COMPLETE...");
    
}

- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender {
    
    return YES;
    
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    // //NSLog(@"DEBUG:  TeacherMainView:: prepareForSegue()   ");
    
    //
    // TODO: when tapping AddStudent we need to know that here and skip the processing here..
    //
    if([segue.identifier isEqualToString:@"addStudentSegueIphone5"]) {
        
        // //NSLog(@"DEBUG:  TeacherMainView:: prepareForSegue() TO ADD_STUDENT    ");
    } else {
        
        StudentStatusViewController *controller = (StudentStatusViewController *)segue.destinationViewController;
        CommentViewController *commentCtrl = (CommentViewController *)segue.destinationViewController;
        AvatarViewController *avatarCtrl = (AvatarViewController *)segue.destinationViewController;
        ManageStudentViewController *settingsCtrl = (ManageStudentViewController *)segue.destinationViewController;
        
        StudentMainView *studentMainCtrl = (StudentMainView *)segue.destinationViewController;
        
        UserUIBarButtonItem *selected = sender;
        
        
        if( [selected.accessibilityIdentifier  rangeOfString: @"studentOne" options: NSCaseInsensitiveSearch].location != NSNotFound  ){
            selectedStudent = userOne;
        } else if( [selected.accessibilityIdentifier  rangeOfString: @"studentTwo" options: NSCaseInsensitiveSearch].location != NSNotFound   ){
            selectedStudent = userTwo;
        } else if( [selected.accessibilityIdentifier  rangeOfString: @"studentThree" options: NSCaseInsensitiveSearch].location != NSNotFound  ){
            selectedStudent = userThree;
        } else if( [selected.accessibilityIdentifier  rangeOfString: @"studentFour" options: NSCaseInsensitiveSearch].location != NSNotFound  ){
            selectedStudent = userFour;
        } else if( [selected.accessibilityIdentifier  rangeOfString: @"studentFive" options: NSCaseInsensitiveSearch].location != NSNotFound  ){
            selectedStudent = userFive;
        } else if( [selected.accessibilityIdentifier  rangeOfString: @"studentSix" options: NSCaseInsensitiveSearch].location != NSNotFound  ){
            selectedStudent = userSix;
        }
        controller.student = selectedStudent;
        commentCtrl.student = selectedStudent;
        avatarCtrl.student = selectedStudent;
        settingsCtrl.student = selectedStudent;
        studentMainCtrl.student = selectedStudent;
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
    
    // //NSLog(@"DEBUG:  TeacherMainView:: you clicked the STUDENT-1 status icon.   .");
    
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
    
    // //NSLog(@"DEBUG: TeacherMainViewController  ---   RELOADING VIEW CONTROLLER --- BBBB - 1   - ");
    [self.view setNeedsDisplay];
    [self viewDidLoad];
    // //NSLog(@"DEBUG: TeacherMainViewController  ---   RELOADING VIEW CONTROLLER --- BBBB  - 2  - ");
    
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