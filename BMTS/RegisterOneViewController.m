//
//  RegisterOneViewController.m
//  BMTS
//
//  Created by JD Hatton on 11/13/14.
//  Copyright (c) 2014 Homeroom Technologies. All rights reserved.
//

#import "RegisterOneViewController.h"
#import "AppDelegate.h"
#import "User.h"

@interface RegisterOneViewController ()

@end


@implementation RegisterOneViewController

@synthesize parentButton,studentButton, principalButton, districtButton;


bool isTeacherSelected = false;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //
    // Disable all buttons except the teacher button
    //
    
    parentButton.enabled = NO;
    parentButton.alpha = 0.5;
    
    studentButton.enabled = NO;
    studentButton.alpha = 0.5;
    
    principalButton.enabled = NO;
    principalButton.alpha = 0.5;
    
    districtButton.enabled = NO;
    districtButton.alpha = 0.5;
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

- (IBAction)teacherButtonClicked:(id)sender {
    
    // //NSLog(@"DEBUG: >>>     you touched the TEACHER button");
    [self.teacherButton setBackgroundColor:[UIColor blueColor]];
    isTeacherSelected = true;
}



- (IBAction)saveTeacher:(id)sender {
    
    // //NSLog(@"DEBUG: >>>  saving teacher  ");
    
//    if( ! isTeacherSelected ){
    
//    } else {
    NSError *error;
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"User" inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
//    User *user = nil;
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    for (User *info in fetchedObjects) {
        // //NSLog(@" Found User : userId: %@", info.id);
//        if(info.id == [NSNumber numberWithInt:1]) {
            //user = info;
            info.role = [NSNumber numberWithInt:1];
            // //NSLog(@" UPDATING  User : Role  :  %@", info.role);
            
            if (![context save:&error]) {
                // //NSLog(@"\n\n ERROR!!!    Whoops, couldn't save: %@", [error localizedDescription]);
            } else {
                // //NSLog(@"\n SUCCESS  - User - UPDATED  ");
                // //NSLog(@"-----------------------------------");
                // //NSLog(@" SUCCESS  - User: id    :  %@", info.id);
                // //NSLog(@" SUCCESS  - User: email :  %@", info.email);
                // //NSLog(@" SUCCESS  - User: role  :  %@", info.role);
                // //NSLog(@"-----------------------------------");
            }
        }
//    }
    
   
//    }
    
    
}

- (IBAction)saveParent:(id)sender {
    //
    // TODO: copy the code from saveTeacher changing the user.role to = the number for the role selected
    // TODO: until that is hooked up completely we should show a pop-up message.
    //
}

- (IBAction)saveStudent:(id)sender {
    //
    // TODO: copy the code from saveTeacher changing the user.role to = the number for the role selected
    // TODO: until that is hooked up completely we should show a pop-up message.
    //
}

- (IBAction)savePrincipal:(id)sender {
    //
    // TODO: copy the code from saveTeacher changing the user.role to = the number for the role selected
    // TODO: until that is hooked up completely we should show a pop-up message.
    //
}

- (IBAction)saveDistrict:(id)sender {
    //
    // TODO: copy the code from saveTeacher changing the user.role to = the number for the role selected
    // TODO: until that is hooked up completely we should show a pop-up message.
    //
}

-(void)viewWillAppear:(BOOL)animated {
    
    // //NSLog(@"DEBUG: RegisterOneViewController  ---   RELOADING VIEW CONTROLLER --- AA-1   - ");
    [self.view setNeedsDisplay];
    [self viewDidLoad];
    // //NSLog(@"DEBUG: RegisterOneViewController  ---   RELOADING VIEW CONTROLLER --- AA-2  - ");
    
}

@end
