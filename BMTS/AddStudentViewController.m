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


@interface AddStudentViewController ()

@property (strong, nonatomic) NSArray *behaviorArray;
@property (strong, nonatomic) NSArray *intervalArray;

@end

NSInteger selectedBehavior = 0;
NSInteger selectedInterval = 0;

@implementation AddStudentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    //
    // TODO: move both of these array data elements to a NSDefault List to be read in from disk synced to WS.
    //
    
    NSArray *data;
    NSArray *data2;
    data = [[NSArray alloc] initWithObjects:@"Head Exploding",
            @"Demon Summoning", @"Screaming",
            @"Fighting", @"Drinking Blood",
            @"Running", @"Open Portal",
            @"Attention Off", @"Disruptions",
            @"Spell Casting", @"Shape Shifting",
            nil];
    
    self.behaviorArray = data;
    
    data2 = [[NSArray alloc] initWithObjects:@"15 Minutes",
             @"30 Minutes", @"45 Minutes", @"1 Hour",
             @"2 Hours", @"3 Hours",
             @"4 Hours", @"5 Hours",
             @"6 Hours", @"Once a Day",
             @"Every Other Day", @"Once a Week",
             @"Every Other Week",@"Once a Month",@"Other",
             nil];
    
    self.intervalArray = data2;
    
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


- (IBAction)saveFormData:(id)sender {
    
    
    NSLog(@"DEBUG: AddStudent - Saving FormData ");
    
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
    
    
    
}


@end
