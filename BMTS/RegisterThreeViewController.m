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

@property (strong, nonatomic) NSArray *gradesArray;

@end

@implementation RegisterThreeViewController

@synthesize emailAddressTextBox, firstName, lastName, gender, zipCode, gradePicker, buttonNext;
@synthesize window = _window;


bool isFirstNameProvided = false;
bool isLastNameProvided = false;
bool isZipCodeProvided = false;
bool isValidForSegueNext = false;
NSInteger selectedGrade = 0;


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
    gradePicker.delegate = self;
    
    //
    // Hard coding the grades here for now is OK.
    //
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
    
  //  self.buttonNext.enabled = NO;
    
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
    
    // //NSLog(@"DEBUG: saving form data Register-3 ");
    NSString *strZip = [self.zipCode text];
    // //NSLog(@" Register-2 String ZIP : %@", strZip);
    
  
    if( self.firstName.text.length > 0){
        isFirstNameProvided = true;
    }
    
    if( self.zipCode.text.length > 0) {
        isZipCodeProvided = true;
    }
 
    if( ! isFirstNameProvided || !isZipCodeProvided) {
        UIAlertView * alert =[[UIAlertView alloc ] initWithTitle:@"INFO:"
                                                         message:@"Please provided your first name, last name, and zipCode to get started! "
                                                        delegate:self
                                               cancelButtonTitle:@"OK"
                                               otherButtonTitles: nil];
        isValidForSegueNext = false;
        [alert show];
        
    
    } else {

        NSString *strFirstName = [self.firstName text];
        appDelegate.teacherUser.firstName = strFirstName;
        NSString *strLastName = [self.lastName text];
        appDelegate.teacherUser.lastName = strLastName;
        
        appDelegate.teacherUser.email = emailAddressTextBox.text;
        
        NSNumberFormatter *f = [[NSNumberFormatter alloc] init];
        f.numberStyle = NSNumberFormatterDecimalStyle;
        NSNumber *zip = [f numberFromString:strZip];
        appDelegate.teacherUser.zipCode = zip;
       
        NSString * selectedGender = @"M"; // [self getTitleForSelectedSegment:gender];
        appDelegate.teacherUser.gender = selectedGender;
        
        
        //
        // Find and set the selected Grade on to the User.
        //
        NSString *selGrade = [self.gradesArray objectAtIndex:selectedGrade];
        
        // //NSLog(@" Register-2 Adding Grade : %@", selGrade);
        //
        // Walk the types to determine the corralating number to store.
        //
        if ([selGrade isEqualToString:@"Kindergarten"])
        {
            // //NSLog(@" Register-2 Matched Kindergarten   :  %@", selGrade);
            appDelegate.teacherUser.schoolGrade = [NSNumber numberWithInteger:1];
        }
        else if ([selGrade isEqualToString:@"First Grade"])
        {
            // //NSLog(@" Register-2 Matched First Grade   :  %@", selGrade);
            appDelegate.teacherUser.schoolGrade = [NSNumber numberWithInteger:2];
        }
        else if ([selGrade isEqualToString:@"Second Grade"])
        {
            // //NSLog(@" Register-2 Matched Second Grade   :  %@", selGrade);
            appDelegate.teacherUser.schoolGrade = [NSNumber numberWithInteger:3];
        }
        else if ([selGrade isEqualToString:@"Third Grade"])
        {
            // //NSLog(@" Register-2 Matched Third Grade   :  %@", selGrade);
            appDelegate.teacherUser.schoolGrade = [NSNumber numberWithInteger:4];
        }
        else if ([selGrade isEqualToString:@"Fourth Grade"])
        {
            // //NSLog(@" Register-2 Matched Fourth Grade   :  %@", selGrade);
            appDelegate.teacherUser.schoolGrade = [NSNumber numberWithInteger:5];
        }
        else if ([selGrade isEqualToString:@"Fifth Grade"])
        {
            // //NSLog(@" Register-2 Matched Fifth Grade   :  %@", selGrade);
            appDelegate.teacherUser.schoolGrade = [NSNumber numberWithInteger:6];
        }
        else if ([selGrade isEqualToString:@"Sixth grade"])
        {
            // //NSLog(@" Register-2 Matched Sixth grade   :  %@", selGrade);
            appDelegate.teacherUser.schoolGrade = [NSNumber numberWithInteger:7];
        }
        else if ([selGrade isEqualToString:@"Seventh Grade"])
        {
            // //NSLog(@" Register-2 Matched Seventh Grade   :  %@", selGrade);
            appDelegate.teacherUser.schoolGrade = [NSNumber numberWithInteger:8];
        }
        else if ([selGrade isEqualToString:@"Eight Grade"])
        {
            // //NSLog(@" Register-2 Matched Eight Grade   :  %@", selGrade);
            appDelegate.teacherUser.schoolGrade = [NSNumber numberWithInteger:9];
        }
        else if ([selGrade isEqualToString:@"Ninth Grade"])
        {
            // //NSLog(@" Register-2 Matched Ninth Grade   :  %@", selGrade);
            appDelegate.teacherUser.schoolGrade = [NSNumber numberWithInteger:10];
        }
        else if ([selGrade isEqualToString:@"Tenth Grade"])
        {
            // //NSLog(@" Register-2 Matched Tenth Grade   :  %@", selGrade);
            appDelegate.teacherUser.schoolGrade = [NSNumber numberWithInteger:11];
        }
        else if ([selGrade isEqualToString:@"Eleventh Grade"])
        {
            // //NSLog(@" Register-2 Matched Eleventh Grade   :  %@", selGrade);
            appDelegate.teacherUser.schoolGrade = [NSNumber numberWithInteger:12];
        }
        else if ([selGrade isEqualToString:@"Twelth Grade"])
        {
            // //NSLog(@" Register-2 Matched Twelth Grade   :  %@", selGrade);
            appDelegate.teacherUser.schoolGrade = [NSNumber numberWithInteger:13];
        }
        else {
            // //NSLog(@" Register-2 FAILED TO MATCH - Grade   :  %@", selGrade);
        }
        
        // //NSLog(@" UPDATING  Teacher : firstName   :  %@", appDelegate.teacherUser.firstName);
        // //NSLog(@" UPDATING  Teacher : lastName    :  %@", appDelegate.teacherUser.lastName);
        // //NSLog(@" UPDATING  Teacher : gender      :  %@", appDelegate.teacherUser.gender);
        // //NSLog(@" UPDATING  Teacher : zipcode     :  %@", appDelegate.teacherUser.zipCode);
    
        isValidForSegueNext = true;
        
        //
        // Segway to the RegisterTwo
        //
        // //NSLog(@" \n\n >>  Attempting to segue to REGISTERTWO  view controller :  strZip  =  %@", strZip);
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        RegisterTwoViewController *registerTwoViewController = [storyboard instantiateViewControllerWithIdentifier:@"registerTwoMainView"];
        [self.window makeKeyAndVisible];
        [self.window.rootViewController presentViewController:registerTwoViewController animated:YES completion:NULL];
        registerTwoViewController.zipCode = strZip;
        appDelegate.zipCode = strZip;

    }
        
    
        


}

-(void)viewWillAppear:(BOOL)animated {
    
    [self.view setNeedsDisplay];
    [self viewDidLoad];
}



- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender {
    
    if (!isValidForSegueNext) {
        //prevent segue from occurring
        return NO;
    }
    
    // by default perform the segue transition
    return YES;
}


-(NSInteger) numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1; // 1 column in the picker.
}

-(NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return [_gradesArray  count];
}

-(NSString *) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [_gradesArray  objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    selectedGrade = row;
}


@end
