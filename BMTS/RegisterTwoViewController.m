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

@end

@implementation RegisterTwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
   // NSArray *data [[[NSArray alloc] initWithObjects: @"",@"", 2] ];
    
    NSArray *data;
    //[NSArray initWithObjects:@"District 001",@"District 002",@"District 003",@"District 004",@"District 005",@"District 006", nil];
    
    data = [[NSArray alloc] initWithObjects:@"District 001",
                   @"Tuna Roll", @"Salmon Roll", @"Unagi Roll",
                   @"Philadelphia Roll", @"Rainbow Roll",
                   @"Vegetable Roll", @"Spider Roll",
                   @"Shrimp Tempura Roll", @"Cucumber Roll",
                   @"Yellowtail Roll", @"Spicy Tuna Roll",
                   @"Avocado Roll", @"Scallop Roll",
                   nil];
    
    self.districtArray = data;
    
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
    
    NSString *select = [_districtArray objectAtIndex:[_districtPicker selectedRowInComponent:0] ];
    
    NSString *title = [[NSString alloc] initWithFormat:@"You selected %", select];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:@"Yay!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alert show];
}

-(NSInteger) numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1; // 1 column in the picker.
}

-(NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return [_districtArray count];
}

-(NSString *) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [_districtArray objectAtIndex:row];
    
}


@end
