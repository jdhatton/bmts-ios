//
//  RegisterFourViewController.h
//  BMTS
//
//  Created by JD Hatton on 12/30/14.
//  Copyright (c) 2014 Homeroom Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegisterFourViewController :  UIViewController <UIPickerViewDataSource, UIPickerViewDelegate>

@property (strong, nonatomic) IBOutlet UIPickerView *gradePicker;
@property (strong, nonatomic) IBOutletCollection(UIPickerView) NSArray *grades;

@end
