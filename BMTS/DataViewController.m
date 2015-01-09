//
//  DataViewController.m
//  BMTS
//
//  Created by JD Hatton on 11/5/14.
//  Copyright (c) 2014 Homeroom Technologies. All rights reserved.
//

#import "DataViewController.h"

@interface DataViewController ()

@end

@implementation DataViewController

@synthesize emailAddressTextBox, passwordTextBox, createAccountButton, alreadyHaveAccountButton, debugButton ;



- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"DEBUG: loading main view");
    NSLog(@"HOME > %@", NSHomeDirectory());
    
    NSArray *directories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documents = [directories firstObject];
    NSLog(@"DOCUMENTS > %@", documents);
 
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
   
}

- (void)createAccount:(id)sender
{
    NSLog(@"DEBUG: you touched the createAccount button");
    
    NSString *email = emailAddressTextBox.text ;
    NSString *password = passwordTextBox.text ;
    
    [emailAddressTextBox resignFirstResponder];
    [passwordTextBox resignFirstResponder];
    
//    NSString *convertResult = [[NSString alloc] initWithFormat: @"Celsius: %f", celsius];
//    calcResult.text = convertResult;
}

- (void)alreadyHaveAccount:(id)sender
{
    NSLog(@"DEBUG: you touched the alreadyHaveAccount button");

}

- (void)debug:(id)sender
{
    NSLog(@"DEBUG: you touched the debug button");
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    return YES;
}

@end
