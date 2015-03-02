//
//  RegisterOneViewController.h
//  BMTS
//
//  Created by JD Hatton on 11/13/14.
//  Copyright (c) 2014 Homeroom Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegisterOneViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIButton *teacherButton;
@property (strong, nonatomic) IBOutlet UIButton *parentButton;
@property (strong, nonatomic) IBOutlet UIButton *studentButton;
@property (strong, nonatomic) IBOutlet UIButton *principalButton;
@property (strong, nonatomic) IBOutlet UIButton *districtButton;

- (IBAction)saveTeacher:(id)sender;

- (IBAction)saveParent:(id)sender;

- (IBAction)saveStudent:(id)sender;

- (IBAction)savePrincipal:(id)sender;

- (IBAction)saveDistrict:(id)sender;


@end
