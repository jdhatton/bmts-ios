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

@interface RegisterTwoViewController ()

@property (strong, nonatomic) NSArray *districtArray;
@property (strong, nonatomic) NSArray *gradesArray;

@end

@implementation RegisterTwoViewController

@synthesize zipCode;

NSInteger selectedDistrict = 0;
NSInteger selectedGrade = 0;


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
    
    //
    // Let's dump the User data we know we should have here
    //
    NSError *error;
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"User" inManagedObjectContext:context];
    
    [fetchRequest setEntity:entity];
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    for (User *user in fetchedObjects) {
        NSLog(@" RegisterTwoViewController:Loading() ");
        NSLog(@" ----------------------------------------");
        NSLog(@" Found User : userId    :  %@", user.id);
        NSLog(@" Found User : email     :  %@", user.email);
        NSLog(@" Found User : role      :  %@", user.role);
        NSLog(@" ----------------------------------------");
        
    }
    
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

-(void)dismissKeyboard {
    [zipCode resignFirstResponder];
    [self.view endEditing:YES];
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
    
    [fetchRequest setEntity:entity];
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    for (User *user in fetchedObjects) {
        NSLog(@" Found User : userId: %@", user.id);
//        if(user.id == [NSNumber numberWithInt:1]) {
        
            NSLog(@" Register-2 > UPDATING  User : userId: %@", user.id);
            //
            // Set the zipCode on to the User.
            //
            //  NSString *distanceString = [self.selectedBeacon.distance stringValue];
            NSString *strZip = [self.zipCode text];
            NSLog(@" Register-2 String ZIP : %@", strZip);

            NSNumberFormatter *f = [[NSNumberFormatter alloc] init];
            f.numberStyle = NSNumberFormatterDecimalStyle;
            NSNumber *zip = [f numberFromString:strZip];
            user.zipCode = zip;
            NSLog(@" Register-2 Added ZIP : %@", strZip);
        
            //
            // Find and set the selected school district on to the User.
            //
 
            user.schoolDistrict = [self.districtArray objectAtIndex:selectedDistrict];
        
            NSLog(@" Register-2 Added schoolDistrict : %@", user.schoolDistrict);
            
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
            user.schoolGrade = [NSNumber numberWithInteger:1];
        }
        else if ([selGrade isEqualToString:@"First Grade"])
        {
            NSLog(@" Register-2 Matched First Grade   :  %@", selGrade);
            user.schoolGrade = [NSNumber numberWithInteger:2];
        }
        else if ([selGrade isEqualToString:@"Second Grade"])
        {
            NSLog(@" Register-2 Matched Second Grade   :  %@", selGrade);
            user.schoolGrade = [NSNumber numberWithInteger:3];
        }
        else if ([selGrade isEqualToString:@"Third Grade"])
        {
            NSLog(@" Register-2 Matched Third Grade   :  %@", selGrade);
            user.schoolGrade = [NSNumber numberWithInteger:4];
        }
        else if ([selGrade isEqualToString:@"Fourth Grade"])
        {
            NSLog(@" Register-2 Matched Fourth Grade   :  %@", selGrade);
            user.schoolGrade = [NSNumber numberWithInteger:5];
        }
        else if ([selGrade isEqualToString:@"Fifth Grade"])
        {
            NSLog(@" Register-2 Matched Fifth Grade   :  %@", selGrade);
            user.schoolGrade = [NSNumber numberWithInteger:6];
        }
        else if ([selGrade isEqualToString:@"Sixth grade"])
        {
            NSLog(@" Register-2 Matched Sixth grade   :  %@", selGrade);
            user.schoolGrade = [NSNumber numberWithInteger:7];
        }
        else if ([selGrade isEqualToString:@"Seventh Grade"])
        {
            NSLog(@" Register-2 Matched Seventh Grade   :  %@", selGrade);
            user.schoolGrade = [NSNumber numberWithInteger:8];
        }
        else if ([selGrade isEqualToString:@"Eight Grade"])
        {
            NSLog(@" Register-2 Matched Eight Grade   :  %@", selGrade);
            user.schoolGrade = [NSNumber numberWithInteger:9];
        }
        else if ([selGrade isEqualToString:@"Ninth Grade"])
        {
            NSLog(@" Register-2 Matched Ninth Grade   :  %@", selGrade);
            user.schoolGrade = [NSNumber numberWithInteger:10];
        }
        else if ([selGrade isEqualToString:@"Tenth Grade"])
        {
            NSLog(@" Register-2 Matched Tenth Grade   :  %@", selGrade);
            user.schoolGrade = [NSNumber numberWithInteger:11];
        }
        else if ([selGrade isEqualToString:@"Eleventh Grade"])
        {
            NSLog(@" Register-2 Matched Eleventh Grade   :  %@", selGrade);
            user.schoolGrade = [NSNumber numberWithInteger:12];
        }
        else if ([selGrade isEqualToString:@"Twelth Grade"])
        {
            NSLog(@" Register-2 Matched Twelth Grade   :  %@", selGrade);
            user.schoolGrade = [NSNumber numberWithInteger:13];
        }
        else {
            NSLog(@" Register-2 FAILED TO MATCH - Grade   :  %@", selGrade);
        }
        
        
            NSLog(@" Register-2 Added grade : %@", user.schoolGrade);
        
        
            NSLog(@" UPDATING  User : zipCode   :  %@", user.zipCode);
            NSLog(@" UPDATING  User : district  :  %@", user.schoolDistrict);
            NSLog(@" UPDATING  User : grade     :  %@", user.schoolGrade);
            
            
            
            if (![context save:&error]) {
                NSLog(@"\n\n ERROR!!!    Whoops, couldn't save: %@", [error localizedDescription]);
            } else {
                NSLog(@"\n SUCCESS  - User - UPDATED  ");
            }
//        }
        
        //
        // Let's dump the User data we know we should have here
        //
        NSError *error;
        NSManagedObjectContext *context = [appDelegate managedObjectContext];
        
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
        NSEntityDescription *entity = [NSEntityDescription entityForName:@"User" inManagedObjectContext:context];
        
        [fetchRequest setEntity:entity];
        NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
        for (User *user in fetchedObjects) {
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
    }
    
    
    
}
@end
