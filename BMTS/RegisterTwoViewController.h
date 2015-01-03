//
//  RegisterTwoViewController.h
//  BMTS
//
//  Created by JD Hatton on 11/13/14.
//  Copyright (c) 2014 Homeroom Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegisterTwoViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource>


- (IBAction)zipCode:(id)sender;

@property (weak, nonatomic) IBOutlet UIPickerView *districtPicker;

@property (strong, nonatomic) IBOutletCollection(UIPickerView) NSArray *districts;


@property (weak, nonatomic) IBOutlet UIPickerView *gradePicker;
@property (strong, nonatomic) IBOutletCollection(UIPickerView) NSArray *grades;


@end
