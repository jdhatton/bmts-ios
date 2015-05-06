//
//  ManageStudentViewController.h
//  BMTS
//
//  Created by JD Hatton on 4/9/15.
//  Copyright (c) 2015 Homeroom Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"

@interface ManageStudentViewController : UIViewController < UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate>

@property (weak, nonatomic) User *student;
@property (strong, nonatomic) UIWindow *window;

@property (weak, nonatomic) IBOutlet UILabel *studentHeaderLabel;


@property (weak, nonatomic) IBOutlet UIPickerView *behaviorUpdatePicker;

@property (weak, nonatomic) IBOutlet UIPickerView *intervalUpdatePicker;

@property (weak, nonatomic) IBOutlet UITextField *studentNameTextField;

@property (weak, nonatomic) IBOutlet UITextField *studentIDNumber;

@property (weak, nonatomic) IBOutlet UIButton *inviteStudentBtn;

@property (weak, nonatomic) IBOutlet UIButton *deleteStudentBtn;
@end
