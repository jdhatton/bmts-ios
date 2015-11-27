//
//  StudentViewController.m
//  Homeroom
//
//  Created by JD Hatton on 11/17/15.
//  Copyright © 2015 Homeroom Technologies. All rights reserved.
//

#import "StudentViewController.h"
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


@implementation StudentViewController

@synthesize student, window;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //
    // Set data (student) on the tabbed view controllers.
    //
    
    NSArray *viewControllers = [self.tabBarController viewControllers];
    NSLog(@"DEBUG: TAB:viewControllers  %@",viewControllers);
    NSLog(@"DEBUG: self.student  %@",self.student);
    
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


-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    StudentStatusViewController *controller = (StudentStatusViewController *)segue.destinationViewController;
    CommentViewController *commentCtrl = (CommentViewController *)segue.destinationViewController;
    AvatarViewController *avatarCtrl = (AvatarViewController *)segue.destinationViewController;
    ManageStudentViewController *settingsCtrl = (ManageStudentViewController *)segue.destinationViewController;
    StudentMainView *studentMainCtrl = (StudentMainView *)segue.destinationViewController;
    StudentViewController *studentViewCtrl = (StudentViewController *)segue.destinationViewController;
    
    controller.student = self.student;
    commentCtrl.student = self.student;
    avatarCtrl.student = self.student;
    settingsCtrl.student = self.student;
    studentMainCtrl.student = self.student;
    studentViewCtrl.student = self.student;
    
}



@end
