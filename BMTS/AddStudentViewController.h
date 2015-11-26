//
//  AddStudentViewController.h
//  BMTS
//
//  Created by JD Hatton on 11/13/14.
//  Copyright (c) 2014 Homeroom Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddStudentViewController : UIViewController < UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate, UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UIPickerView *behaviorPicker;

@property (weak, nonatomic) IBOutlet UIPickerView *intervalPicker;

@property (weak, nonatomic) IBOutlet UITextField *studentName;

@property (weak, nonatomic) IBOutlet UITextField *studentIdNumber;

@property (strong, nonatomic) UIWindow *window;

@property (weak, nonatomic) IBOutlet UIImageView *imagePicker;

- (IBAction)takePicture:(id)sender;

- (IBAction)selectPicture:(id)sender;

- (void)saveFormData:(id)sender;

 
@end
