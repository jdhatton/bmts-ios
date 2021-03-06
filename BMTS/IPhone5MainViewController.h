//
//  IPhone5MainViewController.h
//  Homeroom
//
//  Created by JD Hatton on 8/13/15.
//  Copyright (c) 2015 Homeroom Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserUIBarButtonItem.h"

@interface IPhone5MainViewController : UIViewController

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


@property (weak, nonatomic) IBOutlet UIToolbar *toolBarOne;
@property (weak, nonatomic) IBOutlet UIToolbar *toolBarTwo;
@property (weak, nonatomic) IBOutlet UIToolbar *toolBarThree;
@property (weak, nonatomic) IBOutlet UIToolbar *toolBarFour;
@property (weak, nonatomic) IBOutlet UIToolbar *toolBarFive;
@property (weak, nonatomic) IBOutlet UIToolbar *toolBarSix;



@property (weak, nonatomic) IBOutlet UserUIBarButtonItem *studentOneName;
@property (weak, nonatomic) IBOutlet UserUIBarButtonItem *studentOneStatus;
@property (weak, nonatomic) IBOutlet UserUIBarButtonItem *studentOneNote;
@property (weak, nonatomic) IBOutlet UserUIBarButtonItem *studentOneSettings;

@property (weak, nonatomic) IBOutlet UserUIBarButtonItem *studentTwoName;
@property (weak, nonatomic) IBOutlet UserUIBarButtonItem *studentTwoStatus;
@property (weak, nonatomic) IBOutlet UserUIBarButtonItem *studentTwoNote;
@property (weak, nonatomic) IBOutlet UserUIBarButtonItem *studentTwoSettings;

@property (weak, nonatomic) IBOutlet UserUIBarButtonItem *studentThreeName;
@property (weak, nonatomic) IBOutlet UserUIBarButtonItem *studentThreeStatus;
@property (weak, nonatomic) IBOutlet UserUIBarButtonItem *studentThreeNote;
@property (weak, nonatomic) IBOutlet UserUIBarButtonItem *studentThreeSettings;

@property (weak, nonatomic) IBOutlet UserUIBarButtonItem *studentFourName;
@property (weak, nonatomic) IBOutlet UserUIBarButtonItem *studentFourStatus;
@property (weak, nonatomic) IBOutlet UserUIBarButtonItem *studentFourNote;
@property (weak, nonatomic) IBOutlet UserUIBarButtonItem *studentFourSettings;

@property (weak, nonatomic) IBOutlet UserUIBarButtonItem *studentFiveName;
@property (weak, nonatomic) IBOutlet UserUIBarButtonItem *studentFiveStatus;
@property (weak, nonatomic) IBOutlet UserUIBarButtonItem *studentFiveNote;
@property (weak, nonatomic) IBOutlet UserUIBarButtonItem *studentFiveSettings;


@property (weak, nonatomic) IBOutlet UserUIBarButtonItem *studentSixName;
@property (weak, nonatomic) IBOutlet UserUIBarButtonItem *studentSixStatus;
@property (weak, nonatomic) IBOutlet UserUIBarButtonItem *studentSixNote;
@property (weak, nonatomic) IBOutlet UserUIBarButtonItem *studentSixSettings;


@property (strong, nonatomic) UIWindow *window;



@end
