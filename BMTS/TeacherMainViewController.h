//
//  TeacherMainViewController.h
//  BMTS
//
//  Created by JD Hatton on 1/3/15.
//  Copyright (c) 2015 Homeroom Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserUIBarButtonItem.h"

@interface TeacherMainViewController : UIViewController  <UITableViewDelegate, UITableViewDataSource>

- (IBAction)studentAvatar:(id)sender;
- (IBAction)studentName:(id)sender;
- (IBAction)studentStatus:(id)sender;
- (IBAction)studentComment:(id)sender;
- (IBAction)studentSettings:(id)sender;

@property (weak, nonatomic) IBOutlet UIToolbar *studentToolbar;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *studentAvatar;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *studentName;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *studentStatus;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *studentComment;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *studentSettings;

@property (weak, nonatomic) IBOutlet UITextField *teacherHeader;

@property (weak, nonatomic) IBOutlet UIButton *addStudentButton;

-(void)refreshView:(NSNotification *) notification;


@property (strong, nonatomic) UIWindow *window;


@property (retain, nonatomic) NSMutableArray *students;

@property (weak, nonatomic) User *selectedStudent;


@property (weak, nonatomic) IBOutlet UITableView *studentListTableView;


@end
