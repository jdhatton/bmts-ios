//
//  TeacherMainViewController.m
//  BMTS
//
//  Created by JD Hatton on 1/3/15.
//  Copyright (c) 2015 Homeroom Technologies. All rights reserved.
//

#import "TeacherMainViewController.h"

@interface TeacherMainViewController ()

@end

@implementation TeacherMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
     NSLog(@"DEBUG: TeacherMainViewController LOADING..");
    
    
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

-(IBAction) buttonClicked
{
    NSLog(@"DEBUG: you touched the button");
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Hello world"
                                                    message:@"You clicked the button"
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
}




- (IBAction)studentAvatar:(id)sender {
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Hello world "
                                                    message:@"You clicked the student avatar"
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
}


- (IBAction)studentName:(id)sender {
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Hello world"
                                                    message:@"You clicked the student name "
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
    
}


- (IBAction)studentStatus:(id)sender {
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Hello world"
                                                    message:@"You clicked the student status - RED, GREEN, YELLOW"
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
    
}


- (IBAction)studentComment:(id)sender {
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Hello world"
                                                    message:@"You clicked the student comment"
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
    
}


- (IBAction)studentSettings:(id)sender {
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Hello world"
                                                    message:@"You clicked the student settings"
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
    
}





@end
