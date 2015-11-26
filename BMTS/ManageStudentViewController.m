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
#import "IPhone5MainViewController.h"

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
    
    // NSLog(@"DEBUG: ManageStudentViewController::loading...   student = %@", student);
    
    //
    // TODO: trying this to see if this is OK.
    //
    if(self.student == nil){
        NSLog(@"DEBUG: StudentViewController::appDelegate.currentSelectedStudent    =    %@",appDelegate.currentSelectedStudent);
        self.student = appDelegate.currentSelectedStudent;
    }
    
    
    //self.inviteStudentBtn.hidden=YES;
    self.deleteStudentBtn.hidden=YES;
    
    NSString *headerText = [NSString stringWithFormat:@"%@%@", @"Manage ", student.firstName];
    studentHeaderLabel.text = headerText;
    
    self.studentIDNumber.text = student.studentIdNumber;

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
    studentNameTextField.delegate = self;
    
    self.studentNameTextField.autocapitalizationType = UITextAutocapitalizationTypeSentences;
    
    NSError *error;
    NSManagedObjectContext *context = [appDelegate managedObjectContext];

    // NSLog(@" Looking for any existing CRB's ");
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"ClassroomBehaviors"  inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    for (ClassroomBehaviors *crb in fetchedObjects) {
        if(crb.studentId == student.id){
            studentInfo = crb;
        }
    }
    NSLog(@" studentInfo.behaviorId  :    %@", studentInfo.behaviorId );
    
    //
    // Set the selected behavior and interval.
    //
    
    //
    // HACK!!
    //
    NSNumber *bid = studentInfo.behaviorId;
    int count = [bid intValue] -1;
    NSLog(@" USING :  behaviorId  :    %d", count );

    
    [self.behaviorUpdatePicker selectRow:count inComponent:0 animated:YES];
    [self.intervalUpdatePicker selectRow:[studentInfo.trackingInterval integerValue] inComponent:0 animated:YES];
    
    
    //
    // Set the selected image from stored core data image selected on Add Student.
    //
    //NSData *selectedObject = self.student.profileImg;
    UIImage* image = [UIImage imageWithData:self.student.profileImg];
    self.studentImg.image = image;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)dismissKeyboard {
    [studentNameTextField resignFirstResponder];
    [studentIDNumber resignFirstResponder];
    [self.view endEditing:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [studentNameTextField resignFirstResponder];
    [studentIDNumber resignFirstResponder];
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
 
    // NSLog(@" Updating the student info. StudentName, Tracked Behavior, Tracking Interval  ");
    
    NSString *selBehavior = [self.behaviorUpdateArray objectAtIndex:selectedStudentUpdateBehavior];
    // NSLog(@" AddStudent String BEHAVIOR : %@", selBehavior);
    studentInfo.behaviorId = [NSNumber numberWithInteger: selectedStudentUpdateBehavior];
    // NSLog(@" AddStudent Added behavior : %@", studentInfo.behaviorId);
    
    NSString *selInterval = [self.intervalUpdateArray objectAtIndex:selectedStudentUpdateInterval];
    // NSLog(@" AddStudent Adding Interval : %@", selInterval);
    //    // NSLog(@" AddStudent Matched    :  %@", selInterval);
    studentInfo.trackingInterval = [NSNumber numberWithInteger:selectedStudentUpdateInterval];
    // NSLog(@" AddStudent Added interval : %@", studentInfo.trackingInterval);
    
    if(self.studentNameTextField.text.length > 1 ){
        student.firstName = self.studentNameTextField.text;
    }
    
    if(self.studentIDNumber.text.length > 1 ){
        student.studentIdNumber = self.studentIDNumber.text;
    }
    
    // NSLog(@" AddStudent SAVING ");
    if (![context save:&error]) {
        // NSLog(@"\n\n ERROR!!!    Whoops, couldn't save: %@", [error localizedDescription]);
    } else {
        // NSLog(@"\n SUCCESS  - User & ClassroomBehavior - UPDATED  ");
    }

    
    //
    // Lets dump the User (student) and the ClassRoomBehavior objects created.
    //
    
    NSFetchRequest *fetchRequest5 = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity5 = [NSEntityDescription entityForName:@"User" inManagedObjectContext:context];
    
    [fetchRequest5 setEntity:entity5];
    NSArray *fetchedObjects5 = [context executeFetchRequest:fetchRequest5 error:&error];
    for (User *user in fetchedObjects5) {
        // NSLog(@" UPDATE StudentController:Exiting() ");
        // NSLog(@" ----------------------------------------");
        // NSLog(@" Found User : userId     : %@", user.id);
        // NSLog(@" Found User : firstName  : %@", user.firstName);
        // NSLog(@" Found User : email      : %@", user.email);
        // NSLog(@" Found User : role       : %@", user.role);
        // NSLog(@" Found User : zipcode    : %@", user.zipCode);
        // NSLog(@" Found User : district   : %@", user.schoolDistrict);
        // NSLog(@" Found User : grade      : %@", user.schoolGrade);
        // NSLog(@" ----------------------------------------");
    }
    
    NSFetchRequest *fetchRequest4 = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity4 = [NSEntityDescription entityForName:@"ClassroomBehaviors" inManagedObjectContext:context];
    
    [fetchRequest4 setEntity:entity4];
    NSArray *fetchedObjects4 = [context executeFetchRequest:fetchRequest4 error:&error];
    for (ClassroomBehaviors *crb in fetchedObjects4) {
        // NSLog(@" UPDATE StudentController:Exiting() ");
        // NSLog(@" ----------------------------------------");
        // NSLog(@" Found CRB : Id          : %@", crb.id);
        // NSLog(@" Found CRB : studentId   : %@", crb.studentId );
        // NSLog(@" Found CRB : status      : %@", crb.statusId);
        // NSLog(@" Found CRB : behaviorId  : %@", crb.behaviorId);
        // NSLog(@" Found CRB : intervalId  : %@", crb.trackingInterval);
        // NSLog(@" ----------------------------------------");
    }
    
 
    isCancelledUpdate = false;
    
    //
    // Segway to the TeacherMainView
    //
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//    if( IS_IPHONE_5 ) {
//        //
//        // Segue to iphone5 view
//        //
//        NSLog(@"\n\n  FOUND iPHONE 5 !!!  \n\n  ");
//        
//        IPhone5MainViewController *teacherMainViewController = [storyboard instantiateViewControllerWithIdentifier:@"iPhone5MainView"];
//        [self.window makeKeyAndVisible];
//        [self.window.rootViewController presentViewController:teacherMainViewController animated:YES completion:NULL];
//    }
//    else {
        //
        // Segway to the TeacherMainView
        //
        TeacherMainViewController *teacherMainViewController = [storyboard instantiateViewControllerWithIdentifier:@"teacherMainView"];
        [self.window makeKeyAndVisible];
        [self.window.rootViewController presentViewController:teacherMainViewController animated:YES completion:NULL];
//    }
    
}

- (IBAction)cancelUpdate:(id)sender {
    isCancelledUpdate = true;
}




- (IBAction)deleteStudent:(id)sender {
    
    UIAlertView * alert =[[UIAlertView alloc ] initWithTitle:@"COMING SOON"
                                                     message:@"This feature is still under development."
                                                    delegate:self
                                           cancelButtonTitle:@"OK"
                                           otherButtonTitles: nil];
    [alert show];
 
    
//    
//    NSNumberFormatter *f = [[NSNumberFormatter alloc] init];
//    f.numberStyle = NSNumberFormatterDecimalStyle;
// 
//    
//    NSError *error;
//    NSManagedObjectContext *context = [appDelegate managedObjectContext];
//    NSFetchRequest *fetchRequest5 = [[NSFetchRequest alloc] init];
//    NSEntityDescription *entity5 = [NSEntityDescription entityForName:@"User" inManagedObjectContext:context];
//    
//    [fetchRequest5 setEntity:entity5];
//    NSArray *fetchedObjects5 = [context executeFetchRequest:fetchRequest5 error:&error];
//    for (User *user in fetchedObjects5) {
//        if(user.id == [f numberFromString:student.studentIdNumber] ){
//            // NSLog(@" Deleting the student :  %@ ", student.studentIdNumber);
//            [context deleteObject:user];
//        }
// 
//    }
//    
//
//    
//    if (![context save:&error]) {
//        // NSLog(@"\n\n ERROR!!!    Whoops, couldn't save: %@", [error localizedDescription]);
//    } else {
//        // NSLog(@"\n SUCCESS  - STUDENT DELETED  ");
//    }
//    
//    isCancelledUpdate = false;
//    
//    //
//    // Segway to the TeacherMainView
//    //
//    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//    TeacherMainViewController *teacherMainViewController = [storyboard instantiateViewControllerWithIdentifier:@"teacherMainView"];
//    [self.window makeKeyAndVisible];
//    [self.window.rootViewController presentViewController:teacherMainViewController animated:YES completion:NULL];
//    

    
}



- (IBAction)inviteStudent:(id)sender {
    
    UIAlertView * alert =[[UIAlertView alloc ] initWithTitle:@"COMING SOON"
                                                     message:@"This feature is still under development."
                                                    delegate:self
                                           cancelButtonTitle:@"OK"
                                           otherButtonTitles: nil];
    [alert show];
}



- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender {
    
    // NSLog(@" >>>    shouldPerformSegueWithIdentifier    ");
    
//    if (!isCancelledUpdate) {
//        //prevent segue from occurring
//        // NSLog(@" >>>    shouldPerformSegueWithIdentifier  - NO   ");
//        return NO;
//    }
//    
//    // by default perform the segue transition
//    // NSLog(@" >>>    shouldPerformSegueWithIdentifier  - YES   ");
    return YES;
}



@end
