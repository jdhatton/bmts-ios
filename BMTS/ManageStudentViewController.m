//
//  ManageStudentViewController.m
//  BMTS
//
//  Created by JD Hatton on 4/9/15.
//  Copyright (c) 2015 Homeroom Technologies. All rights reserved.
//

#import "ManageStudentViewController.h"

@interface ManageStudentViewController ()

@end

@implementation ManageStudentViewController

@synthesize student, window = _window, studentHeaderLabel, behaviorUpdatePicker, intervalUpdatePicker, studentNameTextField ;

NSInteger selectedStudentBehavior = 0;
NSInteger selectedStudentInterval = 0;

BOOL isCancelledUpdate = false;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"DEBUG: ManageStudentViewController::loading...   student = %@", student);
    
    
    NSString *headerText = [NSString stringWithFormat:@"%@%@", @"Manage ", student.firstName];
    studentHeaderLabel.text = headerText;

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
