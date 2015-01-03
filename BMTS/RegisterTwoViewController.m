//
//  RegisterTwoViewController.m
//  BMTS
//
//  Created by JD Hatton on 11/13/14.
//  Copyright (c) 2014 Homeroom Technologies. All rights reserved.
//

#import "RegisterTwoViewController.h"

@interface RegisterTwoViewController ()

@property (strong, nonatomic) NSArray *districtArray;
@property (strong, nonatomic) NSArray *gradesArray;

@end

@implementation RegisterTwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSArray *data;
    NSArray *data2;
    data = [[NSArray alloc] initWithObjects:@"District 001",
                   @"District 022", @"Blue Valley", @"Shawnee Mission",
                   @"Kansas City", @"Wyandotte",
                   @"Kansas City Missouri", @"Turner",
                   @"Cherokee Hills", @"Cucumber Roll",
                   @"Yellowtail Roll", @"Spicy Tuna Roll",
                   @"Avocado Roll", @"Scallop Roll",
                   nil];
    
    self.districtArray = data;
    
    data2 = [[NSArray alloc] initWithObjects:@"Kindergarten",
             @"First Grade", @"Second Grade", @"Third Grade",
             @"Fourth Grade", @"Fifth Grade",
             @"Sixth grade", @"Seventh Grade",
             @"Eight Grade", @"Ninth Grade",
             @"Tenth Grade", @"Eleventh Grade",
             @"Twelth Grade",
             nil];
    
    self.gradesArray = data2;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)zipCode:(id)sender {
    
//    NSString *select = [_districtArray objectAtIndex:[_districtPicker selectedRowInComponent:0] ];
//    
//    NSString *title = [[NSString alloc] initWithFormat:@"You selected %", select];
//    
//    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:@"Yay!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
//    [alert show];
}

-(NSInteger) numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1; // 1 column in the picker.
}

-(NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    
    if (pickerView == self.districtPicker ) {
        return [_districtArray  count];
    }
    else if (pickerView == self.gradePicker) {
        return [_gradesArray  count];
    }
    return [_districtArray  count];
}

-(NSString *) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    if (pickerView == self.districtPicker ) {
        return [_districtArray  objectAtIndex:row];
    }
    else if (pickerView == self.gradePicker) {
        return [_gradesArray  objectAtIndex:row];
    }
    return [_districtArray  objectAtIndex:row];
    
}


@end
