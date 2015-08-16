//
//  RegisterTwoViewController.h
//  BMTS
//
//  Created by JD Hatton on 11/13/14.
//  Copyright (c) 2014 Homeroom Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegisterTwoViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource ,UITextFieldDelegate>


@property (weak, nonatomic) IBOutlet UIPickerView *districtPicker;

@property (strong, nonatomic) IBOutletCollection(UIPickerView) NSArray *districts;




@property (weak, nonatomic) IBOutlet UIButton *saveData;

@property (weak, nonatomic) IBOutlet UITextField *schoolName;

- (IBAction)saveFormData:(id)sender;

@property (strong, nonatomic) UIWindow *window;

@property (weak, nonatomic)  NSString *zipCode;

@end
