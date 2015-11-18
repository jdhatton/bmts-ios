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
#import "ManageStudentViewController.h"
#import "StudentMainView.h"
#import "StudentViewController.h"
#include "Liquid.h"


@interface TeacherMainViewController ()

@end

@implementation TeacherMainViewController

@synthesize addStudentButton, toolBarOne, toolBarTwo, toolBarThree, toolBarFour, toolBarFive, toolBarSix, toolBarSeven, toolBarEight, studentOneAvatar, studentOneName, studentOneStatus, studentOneNote, studentOneSettings,
studentTwoAvatar, studentTwoName, studentTwoStatus, studentTwoNote, studentTwoSettings,
studentThreeAvatar, studentThreeName, studentThreeStatus, studentThreeNote, studentThreeSettings,
studentFourAvatar, studentFourName, studentFourStatus, studentFourNote, studentFourSettings,
studentFiveAvatar, studentFiveName, studentFiveStatus, studentFiveNote, studentFiveSettings,
studentSixAvatar, studentSixName, studentSixStatus, studentSixNote, studentSixSettings,
studentSevenAvatar, studentSevenName, studentSevenStatus, studentSevenNote, studentSevenSettings,
studentEightAvatar, studentEightName, studentEightStatus, studentEightNote, studentEightSettings,window = _window, students;


 NSMutableArray *behaviorList;



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
    
    // NSLog(@"DEBUG: TeacherMainViewController::viewDidLoad()   --   LOADING...");
    
//    [[Liquid sharedInstance] identifyUserWithIdentifier:appDelegate.deviceID
//                               attributes:@{ @"name": appDelegate.userRemoteId ,@"remoteId":appDelegate.userRemoteId }];
   
    behaviorList = [NSMutableArray new];
    
    self.students = @[@"Rupert Higgins",@"Caleb Worth", @"Monifa Jones", @"Anton Williams", @"Louis Lane", @"Harvey Milk", @"Jebadiah Bush", @"Shanae Reemes"];
    
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
        // NSLog(@" RTeacherMainViewController::Exiting() ");
        // NSLog(@" ----------------------------------------");
        // NSLog(@" Found User : userId      :  %@", user.id);
        // NSLog(@" Found User : email       :  %@", user.email);
        // NSLog(@" Found User : role        :  %@", user.role);
        // NSLog(@" Found User : zipcode     :  %@", user.zipCode);
        // NSLog(@" Found User : district    :  %@", user.schoolDistrict);
        // NSLog(@" Found User : grade       :  %@", user.schoolGrade);
        // NSLog(@" Found User : firstName   :  %@", user.firstName);
        // NSLog(@" Found User : lastName    :  %@", user.lastName);
        // NSLog(@" Found User : gender      :  %@", user.gender);
        // NSLog(@" Found User : schoolName  :  %@", user.schoolName);
        // NSLog(@" Found User : remoteId    :  %@", user.remoteId);
        // NSLog(@" ----------------------------------------");
        
        if([user.id integerValue] == 1 ){
            userName = [NSString stringWithFormat:@"%@%@%@%@", user.firstName,@" ", user.lastName, @"'s Class Room "];
            appDelegate.teacherUser.remoteId = user.remoteId;
            appDelegate.userRemoteId = user.remoteId;
        }
        
    }

    
    
    //
    // Hide the toolbars, then show them for each student in the DB.
    //
    // NSLog(@"DEBUG: TeacherMainViewController - Hiding the toolbars. ");
    
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
//         NSLog(@" TeacherMainView ->  ");
//         NSLog(@" ----------------------------------------");
//         NSLog(@" Found User : userId      :  %@", user.id);
//         NSLog(@" Found User : email       :  %@", user.email);
//         NSLog(@" Found User : role        :  %@", user.role);
//         NSLog(@" Found User : zipcode     :  %@", user.zipCode);
//         NSLog(@" Found User : district    :  %@", user.schoolDistrict);
//         NSLog(@" Found User : grade       :  %@", user.schoolGrade);
//         NSLog(@" Found User : firstName   :  %@", user.firstName);
//         NSLog(@" Found User : lastName    :  %@", user.lastName);
//         NSLog(@" Found User : gender      :  %@", user.gender);
//         NSLog(@" Found User : schoolName  :  %@", user.schoolName);
//         NSLog(@" Found User : status      :  %@", user.status);
//         NSLog(@" ----------------------------------------");
        
        if([user.role integerValue] == 2 ){
            studentCount ++;
            // NSLog(@" Found Student - [%ld]  : %@", (long)studentCount, user.firstName);
            
            // studentOneAvatar, studentOneName, studentOneStatus, studentOneNote, studentOneSettings
            
            if(studentCount == 1){
                toolBarOne.hidden = NO;
                studentOneStatus.accessibilityIdentifier = @"studentOneStatus";
                studentOneAvatar.accessibilityIdentifier = @"studentOneAvatar";
                studentOneNote.accessibilityIdentifier = @"studentOneNote";
                studentOneName.accessibilityIdentifier = @"studentOneName";
                studentOneSettings.accessibilityIdentifier = @"studentOneSettings";
                studentOneName.title = user.firstName;
                userOne = user;
                
                 // NSLog(@"  Student Status - [%ld]  : %@", (long)studentCount, user.status);
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
                studentTwoAvatar.accessibilityIdentifier = @"studentTwoAvatar";
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
                studentThreeAvatar.accessibilityIdentifier = @"studentThreeAvatar";
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
                studentFourAvatar.accessibilityIdentifier = @"studentFourAvatar";
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
                studentFiveAvatar.accessibilityIdentifier = @"studentFiveAvatar";
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
                studentSixAvatar.accessibilityIdentifier = @"studentSixAvatar";
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
            else if(studentCount == 7){
                toolBarSeven.hidden = NO;
                studentSevenStatus.accessibilityIdentifier = @"studentSevenStatus";
                studentSevenAvatar.accessibilityIdentifier = @"studentSevenAvatar";
                studentSevenNote.accessibilityIdentifier = @"studentSevenNote";
                studentSevenName.accessibilityIdentifier = @"studentSevenName";
                studentSevenSettings.accessibilityIdentifier = @"studentSevenSettings";
                studentSevenName.title = user.firstName;
                userSeven = user;
                
                if( [user.status intValue] == [STATUS_GREEN intValue]){  
                    studentSevenStatus.tintColor = [UIColor greenColor];
                    //   [[ self.studentOneStatus.class appearance] setImage:greenCircle] ;
                } else if( [user.status intValue] == [STATUS_YELLOW intValue]){  
                    studentSevenStatus.tintColor = [UIColor yellowColor];
                    //  [[ self.studentOneStatus.class appearance] setImage:yellowCircle] ;
                    
                } else if( [user.status intValue] == [STATUS_RED intValue]){  
                    studentSevenStatus.tintColor = [UIColor redColor];
                    //  [[ self.studentOneStatus.class appearance] setImage:redCircle] ;
                }
            }
            else if(studentCount == 8){
                toolBarEight.hidden = NO;
                studentEightStatus.accessibilityIdentifier = @"studentEightStatus";
                studentEightAvatar.accessibilityIdentifier = @"studentEightAvatar";
                studentEightNote.accessibilityIdentifier = @"studentEightNote";
                studentEightName.accessibilityIdentifier = @"studentEightName";
                studentEightSettings.accessibilityIdentifier = @"studentEightSettings";
                studentEightName.title = user.firstName;
                userEight = user;
                
                if( [user.status intValue] == [STATUS_GREEN intValue]){  
                    studentEightStatus.tintColor = [UIColor greenColor];
                    //   [[ self.studentOneStatus.class appearance] setImage:greenCircle] ;
                } else if( [user.status intValue] == [STATUS_YELLOW intValue]){  
                    studentEightStatus.tintColor = [UIColor yellowColor];
                    //  [[ self.studentOneStatus.class appearance] setImage:yellowCircle] ;
                    
                } else if( [user.status intValue] == [STATUS_RED intValue]){  
                    studentEightStatus.tintColor = [UIColor redColor];
                    //  [[ self.studentOneStatus.class appearance] setImage:redCircle] ;
                }
            }
            else {
              // NSLog(@" TOO MANY STUDENTS !!!  Fix!");
            }
        }
    }
 
    
    //
    // Currently we are capping the list of students at 8 so if we have eight lets hide the button.
    //
    if(studentCount > 7) {
        addStudentButton.hidden = YES;
    }
    
    
    // NSLog(@"DEBUG: TeacherMainViewController LOADING COMPLETE...");
    
}

- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender {
    
    return YES;
    
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
     // NSLog(@"DEBUG:  TeacherMainView:: prepareForSegue()   ");

    //
    // TODO: when tapping AddStudent we need to know that here and skip the processing here..
    //
    if([segue.identifier isEqualToString:@"addStudentSegue"] ) {  //|| [segue.identifier isEqualToString:@"studentViewSegue"]) {
        
        // NSLog(@"DEBUG:  TeacherMainView:: prepareForSegue() TO ADD_STUDENT    ");
    } else {
    
        StudentStatusViewController *controller = (StudentStatusViewController *)segue.destinationViewController;
        CommentViewController *commentCtrl = (CommentViewController *)segue.destinationViewController;
        AvatarViewController *avatarCtrl = (AvatarViewController *)segue.destinationViewController;
        ManageStudentViewController *settingsCtrl = (ManageStudentViewController *)segue.destinationViewController;
        
        StudentMainView *studentMainCtrl = (StudentMainView *)segue.destinationViewController;
        
        
        StudentViewController *studentViewCtrl = (StudentViewController *)segue.destinationViewController;
        
        
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
        } else if( [selected.accessibilityIdentifier  rangeOfString: @"studentSeven" options: NSCaseInsensitiveSearch].location != NSNotFound  ){
            selectedStudent = userSeven;
        } else if( [selected.accessibilityIdentifier  rangeOfString: @"studentEight" options: NSCaseInsensitiveSearch].location != NSNotFound  ){
            selectedStudent = userEight;
        }
        
        controller.student = selectedStudent;
        commentCtrl.student = selectedStudent;
        avatarCtrl.student = selectedStudent;
        settingsCtrl.student = selectedStudent;
        studentMainCtrl.student = selectedStudent;
        studentViewCtrl.student = selectedStudent;
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
    
    // NSLog(@"DEBUG:  TeacherMainView:: you clicked the STUDENT-1 status icon.   .");
    
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
    
     // NSLog(@"DEBUG: TeacherMainViewController  ---   RELOADING VIEW CONTROLLER --- BBBB - 1   - ");
     [self.view setNeedsDisplay];
     [self viewDidLoad];
    // NSLog(@"DEBUG: TeacherMainViewController  ---   RELOADING VIEW CONTROLLER --- BBBB  - 2  - ");
    
}


// showStudentStatusSegue
//
//-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
//    if([segue.identifier isEqualToString:@"showStudentStatusSegue"]){
//        StudentStatusViewController *controller = (StudentStatusViewController *)segue.destinationViewController;
//        controller.student = selectedStudent;
//    }
//}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.students count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SimpleTableCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:simpleTableIdentifier];
    }
    
//    cell.backgroundColor = [UIColor clearColor];
//    cell.textLabel.text = self.students[indexPath.row];
//    
//    cell.imageView.image = [UIImage imageNamed:@"user-26.jpg"];
//    cell.imageView.image = [UIImage imageNamed:@"full_moon-24.jpg"];
//    cell.imageView.image = [UIImage imageNamed:@"add_file-26.jpg"];
//    cell.imageView.image = [UIImage imageNamed:@"settings-24.jpg"];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    cell.backgroundColor = [UIColor clearColor];
    
    cell.imageView.image = [UIImage imageNamed:@"user-26.jpg"];
//    cell.imageView.image = [UIImage imageNamed:@"full_moon-24.jpg"];
//    cell.imageView.image = [UIImage imageNamed:@"add_file-26.jpg"];
//    cell.imageView.image = [UIImage imageNamed:@"settings-24.jpg"];
    
    cell.textLabel.text = [self.students objectAtIndex:indexPath.row];
    
    cell.detailTextLabel.text = @"Tracking:  Homework";
    
}

-(NSInteger)tableView:(UITableView *)tableView indentationLevelForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 2;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    NSString *cellText = cell.textLabel.text;
    
    UIAlertView *messageAlert = [[UIAlertView alloc]
                                 initWithTitle:@"Row Selected" message:cellText delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    
    // Display Alert Message
    [messageAlert show];
    
}



@end
