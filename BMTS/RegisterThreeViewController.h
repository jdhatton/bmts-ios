//
//  RegisterThreeViewController.h
//  BMTS
//
//  Created by JD Hatton on 11/13/14.
//  Copyright (c) 2014 Homeroom Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegisterThreeViewController : UIViewController


- (IBAction)zipCode:(id)sender;

- (IBAction)saveFormData:(id)sender;

@property (weak, nonatomic) IBOutlet UITextField *firstName;

@property (weak, nonatomic) IBOutlet UITextField *lastName;

@property (weak, nonatomic) IBOutlet UISegmentedControl *gender;

@property (weak, nonatomic) IBOutlet UITextField *zipCode;

@property (strong, nonatomic) UIWindow *window;

@end
