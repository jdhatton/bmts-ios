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
#import "StudentBehaviors.h"
#import "ClassroomBehaviors.h"
#import "Behaviors.h"
#include "Liquid.h"


@interface TeacherMainViewController ()

@end

@implementation TeacherMainViewController

@synthesize addStudentButton,window = _window, students, selectedStudent;


NSMutableArray *behaviorList;
NSNumber *STATUS_GREEN;
NSNumber *STATUS_YELLOW;
NSNumber *STATUS_RED;



- (void)viewDidLoad {
    [super viewDidLoad];
    
    // NSLog(@"DEBUG: TeacherMainViewController::viewDidLoad()   --   LOADING...");
    
//    [[Liquid sharedInstance] identifyUserWithIdentifier:appDelegate.deviceID
//                               attributes:@{ @"name": appDelegate.userRemoteId ,@"remoteId":appDelegate.userRemoteId }];
   
    
//    STATUS_GREEN = [NSNumber numberWithInt:1];
//    STATUS_YELLOW = [NSNumber numberWithInt:2];
//    STATUS_RED = [NSNumber numberWithInt:3];
    
    behaviorList = [NSMutableArray new];
    self.students = [NSMutableArray new];
    

    
    NSString *userName = @"";
    
    //
    // Get the User = 1 for the teacher who installed app.
    //
    NSString *studentName = @"";
    NSError *error;
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"User" inManagedObjectContext:context];
    
    [fetchRequest setEntity:entity];
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    for (User *user in fetchedObjects) {
         NSLog(@" RTeacherMainViewController::Exiting() ");
         NSLog(@" ----------------------------------------");
         NSLog(@"User : userId      :  %@", user.id);
         NSLog(@"User : email       :  %@", user.email);
         NSLog(@"User : role        :  %@", user.role);
         NSLog(@"User : zipcode     :  %@", user.zipCode);
         NSLog(@"User : district    :  %@", user.schoolDistrict);
         NSLog(@"User : grade       :  %@", user.schoolGrade);
         NSLog(@"User : firstName   :  %@", user.firstName);
         NSLog(@"User : lastName    :  %@", user.lastName);
         NSLog(@"User : gender      :  %@", user.gender);
         NSLog(@"User : schoolName  :  %@", user.schoolName);
         NSLog(@"User : remoteId    :  %@", user.remoteId);
         NSLog(@"User : deviceId    :  %@", user.deviceId);
         NSLog(@" ----------------------------------------");
        
        if([user.id integerValue] == 1 ){
            userName = [NSString stringWithFormat:@"%@%@%@%@", user.firstName,@" ", user.lastName, @"'s Class Room "];
            NSLog(@"userName :  %@", userName);
            appDelegate.teacherUser.remoteId = user.remoteId;
            appDelegate.userRemoteId = user.remoteId;
        } else {
        
            if(user.firstName){
                studentName = [NSString stringWithFormat:@"%@", user.firstName];
                [self.students addObject: user];
                //[self.students addObject: studentName];
            }
        }
        
        NSLog(@"User : students   :  %@", students);
    }
    
    NSEntityDescription *entity2 = [NSEntityDescription entityForName:@"Behaviors" inManagedObjectContext:context];
    [fetchRequest setEntity:entity2];
    NSArray *fetchedObjects2 = [context executeFetchRequest:fetchRequest error:&error];
    
    NSUInteger count = [context countForFetchRequest:fetchRequest error:&error];
    if(count == NSNotFound) {
        //Handle error
    }
    NSLog(@" Behavior count  :   %lu", (unsigned long)count);
    
    for (Behaviors *behavior in fetchedObjects2) {
        NSLog(@" ----------------------------------------");
        NSLog(@" Behavior : Id        :  %@", behavior.id);
        NSLog(@" Behavior : name      :  %@", behavior.name);
        NSLog(@" Behavior : descr     :  %@", behavior.descr);
        NSLog(@" Behavior : synced    :  %@", behavior.synced);
        NSLog(@" ----------------------------------------");
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
    if([segue.identifier isEqualToString:@"addStudentSegue"] ) {           
        // NSLog(@"DEBUG:  TeacherMainView:: prepareForSegue() TO ADD_STUDENT    ");
    }
    
    // Make sure your segue name in storyboard is the same as this line
    if ([[segue identifier] isEqualToString:@"studentViewSegue"])
    {
        StudentStatusViewController *controller = (StudentStatusViewController *)segue.destinationViewController;
        CommentViewController *commentCtrl = (CommentViewController *)segue.destinationViewController;
        AvatarViewController *avatarCtrl = (AvatarViewController *)segue.destinationViewController;
        ManageStudentViewController *settingsCtrl = (ManageStudentViewController *)segue.destinationViewController;
        StudentMainView *studentMainCtrl = (StudentMainView *)segue.destinationViewController;
        StudentViewController *studentViewCtrl = (StudentViewController *)segue.destinationViewController;
        
        controller.student = self.selectedStudent;
        commentCtrl.student = self.selectedStudent;
        avatarCtrl.student = self.selectedStudent;
        settingsCtrl.student = self.selectedStudent;
        studentMainCtrl.student = self.selectedStudent;
        studentViewCtrl.student = self.selectedStudent;
        
        appDelegate.currentSelectedStudent = self.selectedStudent;
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
//    studentStatusViewController.student = studentOneStatus.student;
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
    
    NSNumber *currentStudentStatus = [NSNumber numberWithInt:1];
    User* student = [self.students objectAtIndex:indexPath.row];
    NSLog(@" STUDENT    :   %@", student);
    
    UIImage* image = [UIImage imageWithData:student.profileImg];
    cell.imageView.image = image;
    
    NSError *error;
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"studentId == %d",[student.id intValue]];
    fetchRequest.predicate = predicate;
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"StudentBehaviors" inManagedObjectContext:context];
    
    [fetchRequest setEntity:entity];
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    for (StudentBehaviors *behavior in fetchedObjects) {
        NSLog(@" --- LOADING --- ");
        NSLog(@" ----------------------------------------");
        NSLog(@"  StudentBehaviors : studentId      :  %@", behavior.studentId);
        NSLog(@"  StudentBehaviors : statusId       :  %@", behavior.statusId);
        NSLog(@"  StudentBehaviors : createdDate    :  %@", behavior.createdDate);
        NSLog(@" ----------------------------------------");
        currentStudentStatus = behavior.statusId;
    }
    
    if( [currentStudentStatus intValue] == 1){
        cell.backgroundColor = [UIColor greenColor];
        //cell.imageView.image = [UIImage imageNamed:@"statusCircleGREEN.jpg"];
    } else if( [currentStudentStatus intValue] == 2){
        cell.backgroundColor = [UIColor yellowColor];
        //cell.imageView.image = [UIImage imageNamed:@"statusCircleYELLOW.jpg"];
    } else if( [currentStudentStatus intValue] == 3){
        cell.backgroundColor = [UIColor redColor];
       //cell.imageView.image = [UIImage imageNamed:@"statusCircleRED-1.jpg"];
    } else {
        //cell.imageView.image = [UIImage imageNamed:@"statusCircleGREEN.jpg"];
    }
    
    NSFetchRequest *fetchRequest4 = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity4 = [NSEntityDescription entityForName:@"ClassroomBehaviors" inManagedObjectContext:context];
    fetchRequest.predicate = predicate;
    [fetchRequest4 setEntity:entity4];
    NSArray *fetchedObjects4 = [context executeFetchRequest:fetchRequest4 error:&error];
    for (ClassroomBehaviors *crb in fetchedObjects4) {
         NSLog(@" AddStudentController:Exiting() ");
         NSLog(@" ----------------------------------------");
         NSLog(@" Found CRB : Id          : %@", crb.id);
         NSLog(@" Found CRB : studentId   : %@", crb.studentId );
         NSLog(@" Found CRB : status      : %@", crb.statusId);
         NSLog(@" Found CRB : behaviorId  : %@", crb.behaviorId);
         NSLog(@" Found CRB : intervalId  : %@", crb.trackingInterval);
         NSLog(@" ----------------------------------------");
        
         cell.detailTextLabel.text = @"        Tracking:  [TODO: Set to the selected]";

    }


    cell.textLabel.text = student.firstName;
    
}

-(NSInteger)tableView:(UITableView *)tableView indentationLevelForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 2;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    User* student = [self.students objectAtIndex:indexPath.row];
    self.selectedStudent = student;
    [self performSegueWithIdentifier:@"studentViewSegue" sender:self];
}



@end
