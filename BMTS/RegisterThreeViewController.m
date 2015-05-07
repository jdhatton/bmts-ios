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
    
    
    NSLog(@"DEBUG: saving form data Register-3 ");
    
    //
    // Set the zipCode on to the User.
    //
    //  NSString *distanceString = [self.selectedBeacon.distance stringValue];
    NSString *strZip = [self.zipCode text];
    NSLog(@" Register-2 String ZIP : %@", strZip);
    
  
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
        
        
  
       
        
        NSNumberFormatter *f = [[NSNumberFormatter alloc] init];
        f.numberStyle = NSNumberFormatterDecimalStyle;
        NSNumber *zip = [f numberFromString:strZip];
        user.zipCode = zip;
        NSLog(@" Register-2 Added ZIP : %@", strZip);

        //
        // Find and set the Gender on the User.
        //
        NSString * selectedGender = [self getTitleForSelectedSegment:gender];
        user.gender = selectedGender;
        

        NSLog(@" UPDATING  User : firstName   :  %@", user.firstName);
        NSLog(@" UPDATING  User : lastName    :  %@", user.lastName);
        NSLog(@" UPDATING  User : gender      :  %@", user.gender);
        NSLog(@" UPDATING  User : zipcode     :  %@", user.zipCode);
        
        
        
        if (![context save:&error]) {
            NSLog(@"\n\n ERROR!!!    Whoops, couldn't save: %@", [error localizedDescription]);
        } else {
            NSLog(@"\n SUCCESS  - User - UPDATED  ");
            isValidForSegueNext = true;
        }
        
        
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
        
        isValidForSegueNext = true;
        
        //
        // Segway to the RegisterTwo
        //
        NSLog(@" \n\n >>  Attempting to segue to REGISTERTWO  view controller :  strZip  =  %@", strZip);
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        RegisterTwoViewController *registerTwoViewController = [storyboard instantiateViewControllerWithIdentifier:@"registerTwoMainView"];
        [self.window makeKeyAndVisible];
        [self.window.rootViewController presentViewController:registerTwoViewController animated:YES completion:NULL];
        registerTwoViewController.zipCode = strZip;
        appDelegate.zipCode = strZip;

    }
    
    
}



- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender {
    
    [self saveFormData:sender ];
    
    NSLog(@" \n  AppDelegate::zipCode  =  %@", appDelegate.zipCode);
    
    if (!isValidForSegueNext) {
        //prevent segue from occurring
        return NO;
    }
    
    // by default perform the segue transition
    return YES;
}


@end
