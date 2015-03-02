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

@interface RegisterThreeViewController ()

@property (strong, nonatomic) NSArray *schoolsArray;


@end

@implementation RegisterThreeViewController

@synthesize schoolPicker, firstName, lastName, gender;

NSInteger selectedSchool = 0;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    NSArray *data1;
    
   
    
    data1 = [[NSArray alloc] initWithObjects:@"School-001",
            @"School-002", @"School-003", @"School-004",
            @"School-005", @"School-006",
            @"School-007", @"School-008",
            @"School-009",
            nil];
    
    self.schoolsArray = data1;
    



    
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

    return [_schoolsArray  count];
}

-(NSString *) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    

    return [_schoolsArray  objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    selectedSchool = row;
}


- (NSString *) getTitleForSelectedSegment: (UISegmentedControl *) segment {
    return [segment titleForSegmentAtIndex:[segment selectedSegmentIndex]];
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
        // Set the firstName, lastName on to the User.
        //
        NSString *strFirstName = [self.firstName text];
        NSLog(@" Register-2 String FIRSTNAME : %@", strFirstName);
        user.firstName = strFirstName;
        NSLog(@" Register-2 Added FIRSTNAME : %@", strFirstName);
        
        NSString *strLastName = [self.lastName text];
        NSLog(@" Register-2 String LASTNAME : %@", strLastName);
        user.lastName = strLastName;
        NSLog(@" Register-2 Added LASTNAME : %@", strLastName);
        
        //
        // Find and set the selected school name on to the User.
        //
        user.schoolName = [self.schoolsArray objectAtIndex:selectedSchool];
        
        //
        // Find and set the Gender on the User.
        //
        NSString * selectedGender = [self getTitleForSelectedSegment:gender];
        user.gender = selectedGender;
        

        NSLog(@" UPDATING  User : firstName   :  %@", user.firstName);
        NSLog(@" UPDATING  User : lastName    :  %@", user.lastName);
        NSLog(@" UPDATING  User : gender      :  %@", user.gender);
        NSLog(@" UPDATING  User : schoolName  :  %@", user.schoolName);
        
        
        
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
            NSLog(@" RegisterThreeViewController:Exiting() ");
            NSLog(@" ----------------------------------------");
            NSLog(@" Found User : userId      :  %@", user.id);
            NSLog(@" Found User : email       :  %@", user.email);
            NSLog(@" Found User : role        :  %@", user.role);
            NSLog(@" Found User : zipcode     :  %@", user.zipCode);
            NSLog(@" Found User : district    :  %@", user.schoolDistrict);
            NSLog(@" Found User : grade       :  %@", user.schoolGrade);
            NSLog(@" Found User : firstName   :  %@", user.firstName);
            NSLog(@" Found User : lastName    :  %@", user.lastName);
            NSLog(@" Found User : gender      :  %@", user.gender);
            NSLog(@" Found User : schoolName  :  %@", user.schoolName);
            NSLog(@" ----------------------------------------");
            
        }
    }
    
    
}





@end
