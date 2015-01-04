//
//  TeacherMainViewController.h
//  BMTS
//
//  Created by JD Hatton on 1/3/15.
//  Copyright (c) 2015 Homeroom Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TeacherMainViewController : UIViewController

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

@end
