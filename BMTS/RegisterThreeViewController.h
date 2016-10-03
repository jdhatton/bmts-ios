//
//  RegisterThreeViewController.h
//  BMTS
//
//  Created by JD Hatton on 11/13/14.
//  Copyright (c) 2014 Homeroom Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegisterThreeViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource ,UITextFieldDelegate>


- (IBAction)zipCode:(id)sender;

- (IBAction)saveFormData:(id)sender;

@property (weak, nonatomic) IBOutlet UITextField *emailAddressTextBox;

@property (weak, nonatomic) IBOutlet UITextField *firstName;

@property (weak, nonatomic) IBOutlet UITextField *lastName;

@property (weak, nonatomic) IBOutlet UISegmentedControl *gender;

@property (weak, nonatomic) IBOutlet UITextField *zipCode;

@property (weak, nonatomic) IBOutlet UIPickerView *gradePicker;
@property (strong, nonatomic) IBOutletCollection(UIPickerView) NSArray *grades;

@property (strong, nonatomic) UIWindow *window;

@property (weak, nonatomic) IBOutlet UIButton *buttonNext;

@end
