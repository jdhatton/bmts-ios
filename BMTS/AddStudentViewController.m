//
//  AddStudentViewController.m
//  BMTS
//
//  Created by JD Hatton on 11/13/14.
//  Copyright (c) 2014 Homeroom Technologies. All rights reserved.
//

#import "AddStudentViewController.h"

@interface AddStudentViewController ()

@property (strong, nonatomic) NSArray *districtArray;
@end

@implementation AddStudentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSString *select = [_districtArray objectAtIndex:[_behaviorPicker selectedRowInComponent:0] ];
    
    NSString *title = [[NSString alloc] initWithFormat:@"You selected %", select];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:@"Yay!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    
    
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




@end
