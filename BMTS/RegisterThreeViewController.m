//
//  RegisterThreeViewController.m
//  BMTS
//
//  Created by JD Hatton on 11/13/14.
//  Copyright (c) 2014 Homeroom Technologies. All rights reserved.
//

#import "RegisterThreeViewController.h"

@interface RegisterThreeViewController ()

@property (strong, nonatomic) NSArray *schoolsArray;
@property (strong, nonatomic) NSArray *gradesArray;

@end

@implementation RegisterThreeViewController

@synthesize schoolPicker;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    NSArray *data1;
    NSArray *data2;
   
    
    data1 = [[NSArray alloc] initWithObjects:@"School-001",
            @"School-002", @"School-003", @"School-004",
            @"School-005", @"School-006",
            @"School-007", @"School-008",
            @"School-009",
            nil];
    
    self.schoolsArray = data1;
    
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


-(NSInteger) numberOfComponentsInPickerView:(UIPickerView *)schoolPicker {
    return 1; // 1 column in the picker.
}

-(NSInteger) pickerView:(UIPickerView *)schoolPicker numberOfRowsInComponent:(NSInteger)component {
    return [_schoolsArray count];
}

-(NSString *) pickerView:(UIPickerView *)schoolPicker titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [_schoolsArray objectAtIndex:row];
    
}

 







@end
