//
//  AddStudentViewController.m
//  BMTS
//
//  Created by JD Hatton on 11/13/14.
//  Copyright (c) 2014 Homeroom Technologies. All rights reserved.
//

#import "AddStudentViewController.h"
#import "AppDelegate.h"
#import "User.h"
#import "ClassroomBehaviors.h"
#import "TeacherMainViewController.h"
 

@interface AddStudentViewController ()

@property (strong, nonatomic) NSArray *behaviorArray;
@property (strong, nonatomic) NSArray *intervalArray;

@end

@implementation AddStudentViewController

@synthesize window = _window, studentName;
NSInteger selectedBehavior = 0;
NSInteger selectedInterval = 0;
BOOL isValidStudentName = true;
BOOL isCancelledAdd = false;


- (void)viewDidLoad {
    [super viewDidLoad];
 
    self.behaviorArray = [appDelegate behaviorListData];
    
    self.intervalArray = [appDelegate intervalListData];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
    
    studentName.delegate = self;
    
    self.studentName.autocapitalizationType = UITextAutocapitalizationTypeSentences;
    
}

-(void)dismissKeyboard {
    [studentName resignFirstResponder];
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



-(NSInteger) numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1; // 1 column in the picker.
}

-(NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (pickerView == self.behaviorPicker ) {
        return [_behaviorArray  count];
    }
    else if (pickerView == self.intervalPicker) {
        return [_intervalArray  count];
    }
    return 0;
}

-(NSString *) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (pickerView == self.behaviorPicker ) {
        return [_behaviorArray  objectAtIndex:row];
    }
    else if (pickerView == self.intervalPicker) {
        return [_intervalArray  objectAtIndex:row];
    }
    return @"FAILED TO MATCH AddStudent Picker ";
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (pickerView == self.behaviorPicker ) {
        selectedBehavior = row;
    }
    else if (pickerView == self.intervalPicker) {
        selectedInterval = row;
    }
}


- (void)saveFormData:(id)sender {
    
    
    NSLog(@"DEBUG: AddStudent - Saving FormData ");
    
    if( isCancelledAdd ) {
        isValidStudentName = true;
    }
    else if( ! [self.studentName text].length > 0  ) {
        UIAlertView * alert =[[UIAlertView alloc ] initWithTitle:@"INFO:"
                                                         message:@"Please provided a name for your student! "
                                                        delegate:self
                                               cancelButtonTitle:@"OK"
                                               otherButtonTitles: nil];
        [alert show];
        isValidStudentName = false;
    } else {

        NSError *error;
        NSManagedObjectContext *context = [appDelegate managedObjectContext];
        
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
        NSEntityDescription *entity = [NSEntityDescription entityForName:@"User" inManagedObjectContext:context];
        [fetchRequest setEntity:entity];
        
        NSNumber *userId = @(2);
        NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
        for (User *user in fetchedObjects) {
            NSLog(@" Found User : userId: %@", user.id);
            userId = @([user.id floatValue] + 1);
        }
        
        //
        // Create a new User object for the Student with a ROLE of student.
        //
        NSString *strStudentName = [self.studentName text];
        NSLog(@" AddStudent String STUDENTNAME : %@", strStudentName);
        
        if(strStudentName.length > 17){
            NSString *mySmallerString = [strStudentName substringToIndex:17];
            strStudentName = mySmallerString;
        }
        
        
        User *newUser = [NSEntityDescription  insertNewObjectForEntityForName:@"User" inManagedObjectContext:context];
        newUser.id = userId;
        newUser.firstName = strStudentName;
        newUser.role = [NSNumber numberWithInt:2]; // 2 = student
        NSLog(@" Created Student : %@", newUser);
        
        //
        // Find and set the selected behavior. >  ClassRoomBehaviors
        //
        NSLog(@" Looking for any existing CRB's ");
        NSNumber *ClassRoomBehaviorsId = [NSNumber numberWithInteger: 0];
        NSFetchRequest *fetchRequest6 = [[NSFetchRequest alloc] init];
        NSEntityDescription *entity6 = [NSEntityDescription entityForName:@"ClassroomBehaviors"  inManagedObjectContext:context];
        [fetchRequest6 setEntity:entity6];
        NSArray *fetchedObjects6 = [context executeFetchRequest:fetchRequest6 error:&error];
        for (ClassroomBehaviors *crb in fetchedObjects6) {
            NSLog(@" Found ClassRoomBehaviors : id: %@", crb.id);
            ClassRoomBehaviorsId = @([crb.id floatValue] + 1);
        }
        
        //
        // Create a new classroomBehavior record for the student-behavior-interval
        //
        NSLog(@" Creating a new CRB - 1   %@", ClassRoomBehaviorsId);
        ClassroomBehaviors *newCRB = [NSEntityDescription  insertNewObjectForEntityForName:@"ClassroomBehaviors" inManagedObjectContext:context];
        newCRB.id = ClassRoomBehaviorsId;
        newCRB.studentId = userId;
        newCRB.statusId = @(1);
        NSLog(@" Createing a new CRB - 2  ");
        
        NSString *selBehavior = [self.behaviorArray objectAtIndex:selectedBehavior];
        NSLog(@" AddStudent String BEHAVIOR : %@", selBehavior);
        newCRB.behaviorId = [NSNumber numberWithInteger: selectedBehavior];
        NSLog(@" AddStudent Added behavior : %@", newCRB.behaviorId);
        
        
        //
        // Find and set the selected Interval.
        //
        NSString *selInterval = [self.intervalArray objectAtIndex:selectedInterval];
        NSLog(@" AddStudent Adding Interval : %@", selInterval);
        //    NSLog(@" AddStudent Matched    :  %@", selInterval);
        newCRB.trackingInterval = [NSNumber numberWithInteger:selectedInterval];
        NSLog(@" AddStudent Added interval : %@", newCRB.trackingInterval);
        
        NSLog(@" AddStudent SAVING ");
        if (![context save:&error]) {
            NSLog(@"\n\n ERROR!!!    Whoops, couldn't save: %@", [error localizedDescription]);
        } else {
            NSLog(@"\n SUCCESS  - User & ClassroomBehavior - UPDATED  ");
        }
        
        
        //
        // Lets dump the User (student) and the ClassRoomBehavior objects created.
        //
        
        NSFetchRequest *fetchRequest5 = [[NSFetchRequest alloc] init];
        NSEntityDescription *entity5 = [NSEntityDescription entityForName:@"User" inManagedObjectContext:context];
        
        [fetchRequest5 setEntity:entity5];
        NSArray *fetchedObjects5 = [context executeFetchRequest:fetchRequest5 error:&error];
        for (User *user in fetchedObjects5) {
            NSLog(@" AddStudentController:Exiting() ");
            NSLog(@" ----------------------------------------");
            NSLog(@" Found User : userId     : %@", user.id);
            NSLog(@" Found User : firstName  : %@", user.firstName);
            NSLog(@" Found User : email      : %@", user.email);
            NSLog(@" Found User : role       : %@", user.role);
            NSLog(@" Found User : zipcode    : %@", user.zipCode);
            NSLog(@" Found User : district   : %@", user.schoolDistrict);
            NSLog(@" Found User : grade      : %@", user.schoolGrade);
            NSLog(@" ----------------------------------------");
        }
        
        NSFetchRequest *fetchRequest4 = [[NSFetchRequest alloc] init];
        NSEntityDescription *entity4 = [NSEntityDescription entityForName:@"ClassroomBehaviors" inManagedObjectContext:context];
        
        [fetchRequest4 setEntity:entity4];
        NSArray *fetchedObjects4 = [context executeFetchRequest:fetchRequest4 error:&error];
        for (ClassroomBehaviors *crb in fetchedObjects4) {
            NSLog(@" AddStudentController:Exiting() ");
            NSLog(@" ----------------------------------------");
            NSLog(@" Found CRB : Id          : %@", crb.id);
            NSLog(@" Found CRB : studentId   : %@", crb.studentId );
            NSLog(@" Found CRB : status      : %@", crb.statusId);
            NSLog(@" Found CRB : behaviorId  : %@", crb.behaviorId);
            NSLog(@" Found CRB : intervalId  : %@", crb.trackingInterval);
            NSLog(@" ----------------------------------------");
        }
        
        isValidStudentName = true;
        isCancelledAdd = false;
        
        //
        // Segway to the TeacherMainView
        //
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        TeacherMainViewController *teacherMainViewController = [storyboard instantiateViewControllerWithIdentifier:@"teacherMainView"];
        [self.window makeKeyAndVisible];
        [self.window.rootViewController presentViewController:teacherMainViewController animated:YES completion:NULL];

    }
    
}



- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender {
    
     NSLog(@" >>>    shouldPerformSegueWithIdentifier    ");
    
    if (!isValidStudentName) {
        //prevent segue from occurring
        NSLog(@" >>>    shouldPerformSegueWithIdentifier  - NO   ");
        return NO;
    }
    
    // by default perform the segue transition
    NSLog(@" >>>    shouldPerformSegueWithIdentifier  - YES   ");
    return YES;
}


- (IBAction)cancel:(id)sender {
    
    isValidStudentName = true;
    isCancelledAdd = true;
    
}


- (IBAction)addStudent:(id)sender {
    
    NSLog(@" ------  You tapped to add a student!  --------");

    if( ! [self.studentName text].length > 0  ) {
        UIAlertView * alert =[[UIAlertView alloc ] initWithTitle:@"INFO:"
                                                         message:@"Please provided a name for your student! "
                                                        delegate:self
                                               cancelButtonTitle:@"OK"
                                               otherButtonTitles: nil];
        [alert show];
        isValidStudentName = false;
    } else {
        NSLog(@" ------  Everything looks good, lets call the saveForm method...");
        isCancelledAdd = false;
        isValidStudentName = true;
        [self saveFormData:sender ];
        
    }
    
}


- (BOOL)studentName:(UITextField *)studentName shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
     NSLog(@" >> isMaxCharsLimitExceeded :: shouldChangeCharactersInRange  ");
    NSUInteger newLength = [self.studentName.text length] + [string length] - range.length;
    return (newLength > 17) ? NO : YES;
}


@end
