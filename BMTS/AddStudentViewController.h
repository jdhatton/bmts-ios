//
//  AddStudentViewController.h
//  BMTS
//
//  Created by JD Hatton on 11/13/14.
//  Copyright (c) 2014 Homeroom Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddStudentViewController : UIViewController < UIPickerViewDelegate, UIPickerViewDataSource >

@property (weak, nonatomic) IBOutlet UIPickerView *behaviorPicker;

@property (weak, nonatomic) IBOutlet UIPickerView *intervalPicker;

@property (weak, nonatomic) IBOutlet UITextField *studentName;

@property (strong, nonatomic) UIWindow *window;


@end
