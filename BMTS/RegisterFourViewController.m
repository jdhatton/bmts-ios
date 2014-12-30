//
//  RegisterFourViewController.m
//  BMTS
//
//  Created by JD Hatton on 12/30/14.
//  Copyright (c) 2014 Homeroom Technologies. All rights reserved.
//

#import "RegisterFourViewController.h"

@interface RegisterFourViewController ()

@property (strong, nonatomic) NSArray *gradesArray;

@end

@implementation RegisterFourViewController

@synthesize gradePicker;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSArray *data2;
    
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

-(NSInteger) numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1; // 1 column in the picker.
}

-(NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return [_gradesArray count];
}

-(NSString *) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [_gradesArray objectAtIndex:row];
    
}

@end
