//
//  RegisterThreeViewController.h
//  BMTS
//
//  Created by JD Hatton on 11/13/14.
//  Copyright (c) 2014 Homeroom Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegisterThreeViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource>



@property (strong, nonatomic) IBOutlet UIPickerView *schoolPicker;
@property (strong, nonatomic) IBOutletCollection(UIPickerView) NSArray *schools;

//@property (weak, nonatomic) IBOutlet UIPickerView *gradePicker;
//@property (strong, nonatomic) IBOutletCollection(UIPickerView) NSArray *grades;


@end
