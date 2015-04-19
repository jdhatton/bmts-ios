//
//  ManageStudentViewController.m
//  BMTS
//
//  Created by JD Hatton on 4/9/15.
//  Copyright (c) 2015 Homeroom Technologies. All rights reserved.
//

#import "ManageStudentViewController.h"
#import "AppDelegate.h"
#import "ClassroomBehaviors.h"
#import "TeacherMainViewController.h"

@interface ManageStudentViewController ()

@property (strong, nonatomic) NSArray *behaviorUpdateArray;
@property (strong, nonatomic) NSArray *intervalUpdateArray;

@end

@implementation ManageStudentViewController


@synthesize student, window = _window, studentHeaderLabel, behaviorUpdatePicker, intervalUpdatePicker, studentNameTextField, studentIDNumber;

NSInteger selectedStudentUpdateBehavior = 0;
NSInteger selectedStudentUpdateInterval = 0;
ClassroomBehaviors *studentInfo = nil;
BOOL isCancelledUpdate = false;


- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"DEBUG: ManageStudentViewController::loading...   student = %@", student);
    
    
    NSString *headerText = [NSString stringWithFormat:@"%@%@", @"Manage ", student.firstName];
    studentHeaderLabel.text = headerText;

    self.studentNameTextField.text = student.firstName;
    
    self.behaviorUpdateArray = [appDelegate behaviorListData];
    
    self.intervalUpdateArray = [appDelegate intervalListData];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
    
    studentNameTextField.delegate = self;
    self.behaviorUpdatePicker.dataSource = self;
    self.behaviorUpdatePicker.delegate = self;
    self.intervalUpdatePicker.dataSource = self;
    self.intervalUpdatePicker.delegate = self;
    studentIDNumber.delegate = self;
    
    self.studentNameTextField.autocapitalizationType = UITextAutocapitalizationTypeSentences;
    
    NSError *error;
    NSManagedObjectContext *context = [appDelegate managedObjectContext];

    NSLog(@" Looking for any existing CRB's ");
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"ClassroomBehaviors"  inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    for (ClassroomBehaviors *crb in fetchedObjects) {
        if(crb.studentId == student.id){
            studentInfo = crb;
        }
    }
    //
    // Set the selected behavior and interval.
    //
    [self.behaviorUpdatePicker selectRow:[studentInfo.behaviorId integerValue] inComponent:0 animated:YES];
    [self.intervalUpdatePicker selectRow:[studentInfo.trackingInterval integerValue] inComponent:0 animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)dismissKeyboard {
    [studentNameTextField resignFirstResponder];
    [self.view endEditing:YES];
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
    if (pickerView == self.behaviorUpdatePicker ) {
        return [self.behaviorUpdateArray  count];
    }
    else if (pickerView == self.intervalUpdatePicker) {
        return [self.intervalUpdateArray  count];
    }
    return 0;
}

-(NSString *) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (pickerView == self.behaviorUpdatePicker ) {
        return [self.behaviorUpdateArray  objectAtIndex:row];
    }
    else if (pickerView == self.intervalUpdatePicker) {
        return [self.intervalUpdateArray  objectAtIndex:row];
    }
    return @"FAILED";
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (pickerView == self.behaviorUpdatePicker ) {
        selectedStudentUpdateBehavior = row;
    }
    else if (pickerView == self.intervalUpdatePicker) {
        selectedStudentUpdateInterval = row;
    }
}



- (IBAction)saveStudentUpdate:(id)sender {
    
    NSError *error;
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
 
    NSLog(@" Updating the student info. StudentName, Tracked Behavior, Tracking Interval  ");
    
    NSString *selBehavior = [self.behaviorUpdateArray objectAtIndex:selectedStudentUpdateBehavior];
    NSLog(@" AddStudent String BEHAVIOR : %@", selBehavior);
    studentInfo.behaviorId = [NSNumber numberWithInteger: selectedStudentUpdateBehavior];
    NSLog(@" AddStudent Added behavior : %@", studentInfo.behaviorId);
    
    NSString *selInterval = [self.intervalUpdateArray objectAtIndex:selectedStudentUpdateInterval];
    NSLog(@" AddStudent Adding Interval : %@", selInterval);
    //    NSLog(@" AddStudent Matched    :  %@", selInterval);
    studentInfo.trackingInterval = [NSNumber numberWithInteger:selectedStudentUpdateInterval];
    NSLog(@" AddStudent Added interval : %@", studentInfo.trackingInterval);
    
    if(self.studentNameTextField.text.length > 1 ){
        student.firstName = self.studentNameTextField.text;
    }
    
    if(self.studentIDNumber.text.length > 1 ){
        student.studentIdNumber = self.studentIDNumber.text;
    }
    
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
        NSLog(@" UPDATE StudentController:Exiting() ");
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
        NSLog(@" UPDATE StudentController:Exiting() ");
        NSLog(@" ----------------------------------------");
        NSLog(@" Found CRB : Id          : %@", crb.id);
        NSLog(@" Found CRB : studentId   : %@", crb.studentId );
        NSLog(@" Found CRB : status      : %@", crb.statusId);
        NSLog(@" Found CRB : behaviorId  : %@", crb.behaviorId);
        NSLog(@" Found CRB : intervalId  : %@", crb.trackingInterval);
        NSLog(@" ----------------------------------------");
    }
    
 
    isCancelledUpdate = false;
    
    //
    // Segway to the TeacherMainView
    //
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    TeacherMainViewController *teacherMainViewController = [storyboard instantiateViewControllerWithIdentifier:@"teacherMainView"];
    [self.window makeKeyAndVisible];
    [self.window.rootViewController presentViewController:teacherMainViewController animated:YES completion:NULL];
    
}

- (IBAction)cancelUpdate:(id)sender {
    isCancelledUpdate = true;
}










- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender {
    
    NSLog(@" >>>    shouldPerformSegueWithIdentifier    ");
    
//    if (!isCancelledUpdate) {
//        //prevent segue from occurring
//        NSLog(@" >>>    shouldPerformSegueWithIdentifier  - NO   ");
//        return NO;
//    }
//    
//    // by default perform the segue transition
//    NSLog(@" >>>    shouldPerformSegueWithIdentifier  - YES   ");
    return YES;
}



@end
