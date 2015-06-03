//
//  RegisterTwoViewController.m
//  BMTS
//
//  Created by JD Hatton on 11/13/14.
//  Copyright (c) 2014 Homeroom Technologies. All rights reserved.
//

#import "RegisterTwoViewController.h"
#import "AppDelegate.h"
#import "User.h"
#import "TeacherMainViewController.h"
#import "RestController.h"
#import "UserCookie.h"

@interface RegisterTwoViewController ()

@property (strong, nonatomic) NSArray *districtArray;
@property (strong, nonatomic) NSArray *gradesArray;

@end

@implementation RegisterTwoViewController

@synthesize schoolName, zipCode;
@synthesize window = _window;

NSInteger selectedDistrict = 0;
NSInteger selectedGrade = 0;
bool isSchoolSelected = false;
bool isValidForSegueToMain = false;


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.zipCode = appDelegate.zipCode;
    schoolName.delegate = self;
    NSLog(@" LOADING: RegisterTwoViewController  :  zipCode =  %@", zipCode);
    
    //
    // Load and test a REST call
    //
    RestController *restCntrlr  = [RestController alloc];
    NSArray *results =[restCntrlr fetchDistrictsForZipCode:zipCode];
    NSLog(@" LOADING: RegisterTwoViewController  :  results  =  %@", results);
    

    self.districtArray = results;
    
    if(results.count > 0){
        self.districtArray = results;
    } else {
        NSArray *data;
        data = [[NSArray alloc] initWithObjects: @"Blue Valley", @"Shawnee Mission",
                @"Kansas City", @"Wyandotte",
                @"Kansas City Missouri", @"Turner",
                @"Cherokee Hills", @"Desoto",
                nil];
        self.districtArray = data;
        
    }
    
    
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
    
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    for (UIView * txt in self.view.subviews){
        if ([txt isKindOfClass:[UITextField class]] && [txt isFirstResponder]) {
            [txt resignFirstResponder];
        }
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dismissKeyboard {
    [schoolName resignFirstResponder];
    [self.view endEditing:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [schoolName resignFirstResponder];
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

- (IBAction)zipCode:(id)sender {
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

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    if (pickerView == self.districtPicker ) {
        selectedDistrict = row;
    }
    else if (pickerView == self.gradePicker) {
        selectedGrade = row;
    }
    
    
}


- (IBAction)saveFormData:(id)sender {

    
    NSLog(@"DEBUG: saving form data Register-2 ");
    
    NSError *error;
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"User" inManagedObjectContext:context];

        //
        // Find and set the selected school district on to the User.
        //
        appDelegate.teacherUser.schoolDistrict = [self.districtArray objectAtIndex:selectedDistrict];
        
        NSLog(@" Register-2 Added schoolDistrict : %@", appDelegate.teacherUser.schoolDistrict);
        
        //
        // Find and set the selected school name on to the User.
        //
        appDelegate.teacherUser.schoolName = self.schoolName.text;
        
        //
        // Find and set the selected Grade on to the User.
        //
        NSString *selGrade = [self.gradesArray objectAtIndex:selectedGrade];
        
        NSLog(@" Register-2 Adding Grade : %@", selGrade);
        //
        // Walk the types to determine the corralating number to store.
        //
        if ([selGrade isEqualToString:@"Kindergarten"])
        {
            NSLog(@" Register-2 Matched Kindergarten   :  %@", selGrade);
            appDelegate.teacherUser.schoolGrade = [NSNumber numberWithInteger:1];
        }
        else if ([selGrade isEqualToString:@"First Grade"])
        {
            NSLog(@" Register-2 Matched First Grade   :  %@", selGrade);
            appDelegate.teacherUser.schoolGrade = [NSNumber numberWithInteger:2];
        }
        else if ([selGrade isEqualToString:@"Second Grade"])
        {
            NSLog(@" Register-2 Matched Second Grade   :  %@", selGrade);
            appDelegate.teacherUser.schoolGrade = [NSNumber numberWithInteger:3];
        }
        else if ([selGrade isEqualToString:@"Third Grade"])
        {
            NSLog(@" Register-2 Matched Third Grade   :  %@", selGrade);
            appDelegate.teacherUser.schoolGrade = [NSNumber numberWithInteger:4];
        }
        else if ([selGrade isEqualToString:@"Fourth Grade"])
        {
            NSLog(@" Register-2 Matched Fourth Grade   :  %@", selGrade);
            appDelegate.teacherUser.schoolGrade = [NSNumber numberWithInteger:5];
        }
        else if ([selGrade isEqualToString:@"Fifth Grade"])
        {
            NSLog(@" Register-2 Matched Fifth Grade   :  %@", selGrade);
            appDelegate.teacherUser.schoolGrade = [NSNumber numberWithInteger:6];
        }
        else if ([selGrade isEqualToString:@"Sixth grade"])
        {
            NSLog(@" Register-2 Matched Sixth grade   :  %@", selGrade);
            appDelegate.teacherUser.schoolGrade = [NSNumber numberWithInteger:7];
        }
        else if ([selGrade isEqualToString:@"Seventh Grade"])
        {
            NSLog(@" Register-2 Matched Seventh Grade   :  %@", selGrade);
            appDelegate.teacherUser.schoolGrade = [NSNumber numberWithInteger:8];
        }
        else if ([selGrade isEqualToString:@"Eight Grade"])
        {
            NSLog(@" Register-2 Matched Eight Grade   :  %@", selGrade);
            appDelegate.teacherUser.schoolGrade = [NSNumber numberWithInteger:9];
        }
        else if ([selGrade isEqualToString:@"Ninth Grade"])
        {
            NSLog(@" Register-2 Matched Ninth Grade   :  %@", selGrade);
            appDelegate.teacherUser.schoolGrade = [NSNumber numberWithInteger:10];
        }
        else if ([selGrade isEqualToString:@"Tenth Grade"])
        {
            NSLog(@" Register-2 Matched Tenth Grade   :  %@", selGrade);
            appDelegate.teacherUser.schoolGrade = [NSNumber numberWithInteger:11];
        }
        else if ([selGrade isEqualToString:@"Eleventh Grade"])
        {
            NSLog(@" Register-2 Matched Eleventh Grade   :  %@", selGrade);
            appDelegate.teacherUser.schoolGrade = [NSNumber numberWithInteger:12];
        }
        else if ([selGrade isEqualToString:@"Twelth Grade"])
        {
            NSLog(@" Register-2 Matched Twelth Grade   :  %@", selGrade);
            appDelegate.teacherUser.schoolGrade = [NSNumber numberWithInteger:13];
        }
        else {
            NSLog(@" Register-2 FAILED TO MATCH - Grade   :  %@", selGrade);
        }
        
        
        NSLog(@" Register-2 Added grade : %@", appDelegate.teacherUser.schoolGrade);
        NSLog(@" UPDATING  User : zipCode   :  %@", appDelegate.teacherUser.zipCode);
        NSLog(@" UPDATING  User : district  :  %@", appDelegate.teacherUser.schoolDistrict);
        NSLog(@" UPDATING  User : grade     :  %@", appDelegate.teacherUser.schoolGrade);
    
        UserCookie *userCookie1 = [NSEntityDescription
                                   insertNewObjectForEntityForName:@"UserCookie"
                                   inManagedObjectContext:context];
        userCookie1.userId = [NSNumber numberWithInt:1];
        userCookie1.email = appDelegate.teacherUser.email;
        userCookie1.password = appDelegate.teacherUser.password;
    
            
            
            
            if (![context save:&error]) {
                NSLog(@"\n\n ERROR!!!    Whoops, couldn't save: %@", [error localizedDescription]);
            } else {
                NSLog(@"\n SUCCESS  - Teacher Created. ");
            }
//        }
        
        User *completedUser;
 
        [fetchRequest setEntity:entity];
        NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
        for (User *user in fetchedObjects) {
            completedUser = user;
            NSLog(@" RegisterTwoViewController:Exiting() ");
            NSLog(@" ----------------------------------------");
            NSLog(@" Found User : userId    : %@", user.id);
            NSLog(@" Found User : email     : %@", user.email);
            NSLog(@" Found User : role      : %@", user.role);
            NSLog(@" Found User : zipcode   : %@", user.zipCode);
            NSLog(@" Found User : district  : %@", user.schoolDistrict);
            NSLog(@" Found User : grade     : %@", user.schoolGrade);
            NSLog(@" ----------------------------------------");
            
        }
        
        
        //
        // Here we need to POST the user to the registerUser web service to be registered.
        //
        //
        // Load and test a REST call
        //
        RestController *restCntrlr  = [RestController alloc];
        [restCntrlr registerUser:completedUser];
        NSLog(@" LOADING: RegisterTwoViewController  :  POSTED - DONE  ");
        
        

        
        
        
        isValidForSegueToMain = true;
        
        //
        // Segway to the TeacherMainView
        //
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        TeacherMainViewController *teacherMainViewController = [storyboard instantiateViewControllerWithIdentifier:@"teacherMainView"];
        [self.window makeKeyAndVisible];
        [self.window.rootViewController presentViewController:teacherMainViewController animated:YES completion:NULL];
        
   
    
}

- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender {
    
  
    [self saveFormData:sender ];
    
    if (!isValidForSegueToMain) {
        //prevent segue from occurring
        return NO;
    }
    
    // by default perform the segue transition
    return YES;
}

@end
