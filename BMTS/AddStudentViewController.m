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
#import "RestController.h"
#import "Behaviors.h"
#import "IPhone5MainViewController.h"

@interface AddStudentViewController ()

@property (strong, nonatomic) NSMutableArray *behaviorArray;
@property (strong, nonatomic) NSArray *intervalArray;

@end

@implementation AddStudentViewController

@synthesize window = _window, studentName, studentIdNumber;
NSInteger selectedBehavior = 0;
NSInteger selectedInterval = 0;
BOOL isValidStudentName = true;
BOOL isCancelledAdd = false;
CGFloat height;
CGFloat width;

- (void)viewDidLoad {
    [super viewDidLoad];
 
    //self.behaviorArray = [appDelegate behaviorListData];
    self.behaviorArray = [NSMutableArray array];
    
    self.intervalArray = [appDelegate intervalListData];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
    
    studentName.delegate = self;
    studentIdNumber.delegate = self;
    
    CGRect imageRect = self.imagePicker.frame;
    height = imageRect.size.height;
    width = imageRect.size.width;
    
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

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [studentName resignFirstResponder];
    [studentIdNumber resignFirstResponder];
    [self.view endEditing:YES];
    return YES;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    //hides keyboard when another part of layout was touched
    [self.view endEditing:YES];
    [super touchesBegan:touches withEvent:event];
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

//
// Persist the form data...
//
- (void)saveFormData:(id)sender {
    
    
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

        NSNumber *userId = @(2);
        NSError *error;
        NSManagedObjectContext *context = [appDelegate managedObjectContext];
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
        NSEntityDescription *entity = [NSEntityDescription entityForName:@"User" inManagedObjectContext:context];
        [fetchRequest setEntity:entity];
        
        //
        // Find the next available userId
        //
        NSNumber *cntNumber = [NSNumber numberWithInt:1];
        int count = [cntNumber intValue];
        NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
        for (User *user in fetchedObjects) {
            userId = @([user.id integerValue]);
            count = count +1;
            cntNumber = [NSNumber numberWithInt:count];
            
        }
        userId = @([cntNumber integerValue] );
        
        
        //
        // Create a new User object for the Student with a ROLE of student.
        //
        NSString *strStudentName = [self.studentName text];
        //NSLog(@" AddStudent String STUDENTNAME : %@", strStudentName);
        
        if(strStudentName.length > 17){
            NSString *mySmallerString = [strStudentName substringToIndex:17];
            strStudentName = mySmallerString;
        }
        
        
        User *newUser = [NSEntityDescription  insertNewObjectForEntityForName:@"User" inManagedObjectContext:context];
        newUser.id = userId;
        newUser.firstName = strStudentName;
        newUser.role = [NSNumber numberWithInt:2]; // 2 = student
        newUser.studentIdNumber = self.studentIdNumber.text;
        newUser.synced = false;
        newUser.profileImg = UIImagePNGRepresentation(self.imagePicker.image);
        //NSLog(@" Created Student : %@", newUser);
        
        //
        // Find and set the selected behavior. >  ClassRoomBehaviors
        //
        // //NSLog(@" Looking for any existing CRB's ");
        NSNumber *ClassRoomBehaviorsId = [NSNumber numberWithInteger: 0];
        NSFetchRequest *fetchRequest6 = [[NSFetchRequest alloc] init];
        NSEntityDescription *entity6 = [NSEntityDescription entityForName:@"ClassroomBehaviors"  inManagedObjectContext:context];
        [fetchRequest6 setEntity:entity6];
        NSArray *fetchedObjects6 = [context executeFetchRequest:fetchRequest6 error:&error];
        for (ClassroomBehaviors *crb in fetchedObjects6) {
            // //NSLog(@" Found ClassRoomBehaviors : id: %@", crb.id);
            ClassRoomBehaviorsId = @([ClassRoomBehaviorsId integerValue] + 1);
        }
        
        NSString *selBehavior = [self.behaviorArray objectAtIndex:selectedBehavior];
        //NSLog(@" AddStudent String BEHAVIOR : %@", selBehavior);
        
        //
        // Use a predicate to query the behaviors table to get the id to be behaviorId
        //
        NSFetchRequest *fetchRequest7 = [[NSFetchRequest alloc] init];
        NSEntityDescription *entity7 = [NSEntityDescription entityForName:@"Behaviors"  inManagedObjectContext:context];
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name LIKE %@",selBehavior];
        fetchRequest7.predicate = predicate;
        [fetchRequest7 setEntity:entity7];
        NSArray *fetchedObjects7 = [context executeFetchRequest:fetchRequest7 error:&error];
        for (Behaviors *behavior in fetchedObjects7) {
            //NSLog(@" Found Behaviors : id: %@", behavior.id);
            selectedBehavior = [behavior.id integerValue];
        }
        //NSLog(@" selectedBehavior :    %ld", (long)selectedBehavior);
        
        
        //
        // Create a new classroomBehavior record for the student-behavior-interval
        //
        // //NSLog(@" Creating a new CRB - 1   %@", ClassRoomBehaviorsId);
        ClassroomBehaviors *newCRB = [NSEntityDescription  insertNewObjectForEntityForName:@"ClassroomBehaviors" inManagedObjectContext:context];
        newCRB.id = ClassRoomBehaviorsId;
        newCRB.studentId = userId;
        newCRB.statusId = @(1);
        //NSLog(@" Createing a new CRB - 2  ");
        

        newCRB.behaviorId = [NSNumber numberWithInteger: selectedBehavior];
        //NSLog(@" AddStudent Added behavior : %@", newCRB.behaviorId);
        newCRB.synced = false;
        
        //
        // Find and set the selected Interval.
        //
//        NSString *selInterval = [self.intervalArray objectAtIndex:selectedInterval];
//        // //NSLog(@" AddStudent Adding Interval : %@", selInterval);
//        //    // //NSLog(@" AddStudent Matched    :  %@", selInterval);
//        newCRB.trackingInterval = [NSNumber numberWithInteger:selectedInterval];
//        // //NSLog(@" AddStudent Added interval : %@", newCRB.trackingInterval);
//        
        // //NSLog(@" AddStudent SAVING ");
        if (![context save:&error]) {
            // //NSLog(@"\n\n ERROR!!!    Whoops, couldn't save: %@", [error localizedDescription]);
        } else {
            // //NSLog(@"\n SUCCESS  - User & ClassroomBehavior - UPDATED  ");
        }
        
        //
        // Call the rest service to save the student on the server.
        //
        RestController *restCntrlr  = [RestController alloc];
        [restCntrlr addStudent:newUser :selBehavior];
        
        //
        // Lets dump the User (student) and the ClassRoomBehavior objects created.
        //
        
        NSFetchRequest *fetchRequest5 = [[NSFetchRequest alloc] init];
        NSEntityDescription *entity5 = [NSEntityDescription entityForName:@"User" inManagedObjectContext:context];
        
        [fetchRequest5 setEntity:entity5];
        NSArray *fetchedObjects5 = [context executeFetchRequest:fetchRequest5 error:&error];
        for (User *user in fetchedObjects5) {
            // //NSLog(@" AddStudentController:Exiting() ");
            // //NSLog(@" ----------------------------------------");
            // //NSLog(@" Added Student  :  userId      : %@", user.id);
            // //NSLog(@" Added Student  :  firstName   : %@", user.firstName);
            // //NSLog(@" Added Student  :  email       : %@", user.email);
            // //NSLog(@" Added Student  :  role        : %@", user.role);
            // //NSLog(@" Added Student  :  zipcode     : %@", user.zipCode);
            // //NSLog(@" Added Student  :  district    : %@", user.schoolDistrict);
            // //NSLog(@" Added Student  :  grade       : %@", user.schoolGrade);
            // //NSLog(@" Added Student  :  studentId   : %@", user.studentIdNumber);
            // //NSLog(@" Added Student  :  status      : %@", user.status);
            // //NSLog(@" Added Student  :  synced      : %@", user.synced);
            // //NSLog(@" ----------------------------------------\n\n");
        }
        
        NSFetchRequest *fetchRequest4 = [[NSFetchRequest alloc] init];
        NSEntityDescription *entity4 = [NSEntityDescription entityForName:@"ClassroomBehaviors" inManagedObjectContext:context];
        
        [fetchRequest4 setEntity:entity4];
        NSArray *fetchedObjects4 = [context executeFetchRequest:fetchRequest4 error:&error];
        for (ClassroomBehaviors *crb in fetchedObjects4) {
             //NSLog(@" AddStudentController:Exiting() ");
             //NSLog(@" ----------------------------------------");
             //NSLog(@" Found CRB : Id          : %@", crb.id);
             //NSLog(@" Found CRB : studentId   : %@", crb.studentId );
             //NSLog(@" Found CRB : status      : %@", crb.statusId);
             //NSLog(@" Found CRB : behaviorId  : %@", crb.behaviorId);
             //NSLog(@" Found CRB : intervalId  : %@", crb.trackingInterval);
             //NSLog(@" ----------------------------------------");
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
    
     // //NSLog(@" >>>    shouldPerformSegueWithIdentifier    ");
    
    if (!isValidStudentName) {
        //prevent segue from occurring
        // //NSLog(@" >>>    shouldPerformSegueWithIdentifier  - NO   ");
        return NO;
    }
    
    // by default perform the segue transition
    // //NSLog(@" >>>    shouldPerformSegueWithIdentifier  - YES   ");
    return YES;
}


- (IBAction)cancel:(id)sender {
    
    isValidStudentName = true;
    isCancelledAdd = true;
    
}


- (IBAction)addStudent:(id)sender {
    
    // //NSLog(@" ------  You tapped to add a student!  --------");

    if( ! [self.studentName text].length > 0  ) {
        UIAlertView * alert =[[UIAlertView alloc ] initWithTitle:@"INFO:"
                                                         message:@"Please provided a name for your student! "
                                                        delegate:self
                                               cancelButtonTitle:@"OK"
                                               otherButtonTitles: nil];
        [alert show];
        isValidStudentName = false;
    } else {
        // //NSLog(@" ------  Everything looks good, lets call the saveForm method...");
        isCancelledAdd = false;
        isValidStudentName = true;
        [self saveFormData:sender ];
        
    }
    
}


- (BOOL)studentName:(UITextField *)studentName shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
     // //NSLog(@" >> isMaxCharsLimitExceeded :: shouldChangeCharactersInRange  ");
    NSUInteger newLength = [self.studentName.text length] + [string length] - range.length;
    return (newLength > 17) ? NO : YES;
}

//
// Force the view to refresh
//
- (void)viewWillAppear:(BOOL)animated {
    
    [self.view setNeedsDisplay];
    
    NSError *error;
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    NSFetchRequest *fetchRequest6 = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity6 = [NSEntityDescription entityForName:@"Behaviors"  inManagedObjectContext:context];
    [fetchRequest6 setEntity:entity6];
    NSArray *fetchedObjects6 = [context executeFetchRequest:fetchRequest6 error:&error];
    for (Behaviors *behavior in fetchedObjects6) {
        // //NSLog(@" Found Behavior : id: %@", behavior.id);
        [self.behaviorArray  addObject:behavior.name];
    }
    [self.behaviorPicker reloadAllComponents];
}



- (IBAction)takePicture:(id)sender {
    
    // //NSLog(@"DEBUG: you touched the take picture button.");
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    [self presentViewController:picker animated:YES completion:NULL];
}


- (IBAction)selectPicture:(id)sender {
    
    // //NSLog(@"DEBUG: you touched the select picture button.");
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
//    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    [self presentViewController:picker animated:YES completion:NULL];
 
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    // //NSLog(@"DEBUG: didFinishPickingMediaWithInfo");
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    self.imagePicker.image = chosenImage;
    self.imagePicker.clearsContextBeforeDrawing = true;
    self.imagePicker.clipsToBounds = true;
    self.imagePicker.center = self.imagePicker.superview.center;
    self.imagePicker.image = [self resizedImageWithContentMode :self.imagePicker];
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    // //NSLog(@"DEBUG: didCancelPickMedia");
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}


// Resizes the image according to the given content mode, taking into account the image's orientation
//- (UIImage *)resizedImageWithContentMode  :(UIImage*)imageToScale  :(CGSize)bounds  :(CGInterpolationQuality)quality {
- (UIImage *)resizedImageWithContentMode  :(UIImageView*)imgPicker  {
    
    
    CGRect bounds = self.imagePicker.bounds;
    
    
    //Get the size we want to scale it to
    CGFloat horizontalRatio = width / self.imagePicker.image.size.width;     // <----------  THIS COULD WRONG width & heigt values.  !!!!!!!
    CGFloat verticalRatio = height / self.imagePicker.image.size.height;
    CGFloat ratio;
    
   // switch (contentMode) {
   //     case UIViewContentModeScaleAspectFill:
   //         ratio = MAX(horizontalRatio, verticalRatio);
   //         break;
            
   //     case UIViewContentModeScaleAspectFit:
            ratio = MIN(horizontalRatio, verticalRatio);
  //          break;
            
   //     default:
   //         //NSLog(@"DEBUG: Unsupported content mode");
          //  [NSException raise:NSInvalidArgumentException format:@"Unsupported content mode: %d", contentMode];
   // }
    
    //...and here it is
    CGSize newSize = CGSizeMake(self.imagePicker.image.size.width * ratio, self.imagePicker.image.size.height * ratio);
    
    
    //start scaling it
    CGRect newRect = CGRectIntegral(CGRectMake(0, 0, newSize.width, newSize.height));
    CGImageRef imageRef = self.imagePicker.image.CGImage;
    CGContextRef bitmap = CGBitmapContextCreate(NULL,
                                                newRect.size.width,
                                                newRect.size.height,
                                                CGImageGetBitsPerComponent(imageRef),
                                                0,
                                                CGImageGetColorSpace(imageRef),
                                                CGImageGetBitmapInfo(imageRef));
    
    CGContextSetInterpolationQuality(bitmap, kCGInterpolationLow);
    
    // Draw into the context; this scales the image
    CGContextDrawImage(bitmap, newRect, imageRef);
    
    // Get the resized image from the context and a UIImage
    CGImageRef newImageRef = CGBitmapContextCreateImage(bitmap);
    UIImage *newImage = [UIImage imageWithCGImage:newImageRef];
    
    // Clean up
    CGContextRelease(bitmap);
    CGImageRelease(newImageRef);
    
    return newImage;
}

@end
