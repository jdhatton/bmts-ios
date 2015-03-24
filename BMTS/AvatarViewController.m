//
//  AvatarViewController.m
//  BMTS
//
//  Created by JD Hatton on 1/4/15.
//  Copyright (c) 2015 Homeroom Technologies. All rights reserved.
//

#import "AvatarViewController.h"

@interface AvatarViewController ()

@end



@implementation AvatarViewController

@synthesize student;

- (void)viewDidLoad {
    [super viewDidLoad];
        
    NSLog(@"DEBUG: Loading the Avatar View Controller...");
    NSLog(@"DEBUG: AvatarViewController::loading...   student = %@", student);
    
    
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
        UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"Error"
                                                              message:@"Device has no camera"
                                                             delegate:nil
                                                    cancelButtonTitle:@"OK"
                                                    otherButtonTitles: nil];
        
        [myAlertView show];
        
    }
    
    
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

- (IBAction)takePicture:(id)sender {
    
    NSLog(@"DEBUG: you touched the take picture button.");
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    [self presentViewController:picker animated:YES completion:NULL];
    
    
    
}


- (IBAction)selectPicture:(id)sender {
    
    NSLog(@"DEBUG: you touched the select picture button.");
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:picker animated:YES completion:NULL];
    
    
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    NSLog(@"DEBUG: didFinishPickingMediaWithInfo");
    
    
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    self.imageView.image = chosenImage;
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    NSLog(@"DEBUG: didCancelPickMedia");
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}


- (IBAction)saveSelection:(id)sender {
    
    NSLog(@"DEBUG: saving your selections.");
    
}


@end
