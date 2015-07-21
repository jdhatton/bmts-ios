//
//  RegisterThreeViewController.m
//  BMTS
//
//  Created by JD Hatton on 11/13/14.
//  Copyright (c) 2014 Homeroom Technologies. All rights reserved.
//

#import "RegisterThreeViewController.h"
#import "AppDelegate.h"
#import "User.h"
#import "RegisterTwoViewController.h"

@interface RegisterThreeViewController ()

@end

@implementation RegisterThreeViewController

@synthesize firstName, lastName, gender, zipCode;
@synthesize window = _window;


bool isFirstNameProvided = false;
bool isLastNameProvided = false;
bool isZipCodeProvided = false;
bool isValidForSegueNext = false;


- (void)viewDidLoad {
    [super viewDidLoad];
 

    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
    
    self.firstName.autocapitalizationType = UITextAutocapitalizationTypeSentences;
    self.lastName.autocapitalizationType = UITextAutocapitalizationTypeSentences;
    
    lastName.delegate = self;
    firstName.delegate = self;
    zipCode.delegate = self;
    
}

-(void)dismissKeyboard {
    [lastName resignFirstResponder];
    [firstName resignFirstResponder];
    [zipCode resignFirstResponder];
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL) textFieldShouldReturn: (UITextField *) textField {
    [lastName resignFirstResponder];
    [firstName resignFirstResponder];
    [zipCode resignFirstResponder];
    [self.view endEditing:YES];
    return YES;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


- (NSString *) getTitleForSelectedSegment: (UISegmentedControl *) segment {
    return [segment titleForSegmentAtIndex:[segment selectedSegmentIndex]];
}
 


- (IBAction)saveFormData:(id)sender {
    
    // NSLog(@"DEBUG: saving form data Register-3 ");
    NSString *strZip = [self.zipCode text];
    // NSLog(@" Register-2 String ZIP : %@", strZip);
    
  
    if( self.firstName.text.length > 0){
        isFirstNameProvided = true;
    }
    if( self.lastName.text.length > 0) {
        isLastNameProvided = true;
    }
    if( self.zipCode.text.length > 0) {
        isZipCodeProvided = true;
    }
 
    if( ! isFirstNameProvided || !isLastNameProvided || !isZipCodeProvided) {
        UIAlertView * alert =[[UIAlertView alloc ] initWithTitle:@"INFO:"
                                                         message:@"Please provided your first name, last name, and zipCode to get started! "
                                                        delegate:self
                                               cancelButtonTitle:@"OK"
                                               otherButtonTitles: nil];
        [alert show];
        isValidForSegueNext = false;
    
    } else {

        NSString *strFirstName = [self.firstName text];
        appDelegate.teacherUser.firstName = strFirstName;
        NSString *strLastName = [self.lastName text];
        appDelegate.teacherUser.lastName = strLastName;
        
        NSNumberFormatter *f = [[NSNumberFormatter alloc] init];
        f.numberStyle = NSNumberFormatterDecimalStyle;
        NSNumber *zip = [f numberFromString:strZip];
        appDelegate.teacherUser.zipCode = zip;
       
        NSString * selectedGender = [self getTitleForSelectedSegment:gender];
        appDelegate.teacherUser.gender = selectedGender;
        
        // NSLog(@" UPDATING  Teacher : firstName   :  %@", appDelegate.teacherUser.firstName);
        // NSLog(@" UPDATING  Teacher : lastName    :  %@", appDelegate.teacherUser.lastName);
        // NSLog(@" UPDATING  Teacher : gender      :  %@", appDelegate.teacherUser.gender);
        // NSLog(@" UPDATING  Teacher : zipcode     :  %@", appDelegate.teacherUser.zipCode);
    

    }
        
        isValidForSegueNext = true;
        
        //
        // Segway to the RegisterTwo
        //
        // NSLog(@" \n\n >>  Attempting to segue to REGISTERTWO  view controller :  strZip  =  %@", strZip);
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        RegisterTwoViewController *registerTwoViewController = [storyboard instantiateViewControllerWithIdentifier:@"registerTwoMainView"];
        [self.window makeKeyAndVisible];
        [self.window.rootViewController presentViewController:registerTwoViewController animated:YES completion:NULL];
        registerTwoViewController.zipCode = strZip;
        appDelegate.zipCode = strZip;


    
    
}



- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender {
    
    [self saveFormData:sender ];
    
    // NSLog(@" \n  AppDelegate::zipCode  =  %@", appDelegate.zipCode);
    
    if (!isValidForSegueNext) {
        //prevent segue from occurring
        return NO;
    }
    
    // by default perform the segue transition
    return YES;
}


@end
