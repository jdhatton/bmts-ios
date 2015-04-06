//
//  StudentStatusViewController.h
//  BMTS
//
//  Created by JD Hatton on 3/22/15.
//  Copyright (c) 2015 Homeroom Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"

@interface StudentStatusViewController : UIViewController

@property (weak, nonatomic) User *student;
@property (strong, nonatomic) UIWindow *window;
@property (weak, nonatomic) IBOutlet UIButton *greenButton;
@property (weak, nonatomic) IBOutlet UIButton *yellowButon;
@property (weak, nonatomic) IBOutlet UIButton *redButton;
@property (weak, nonatomic) IBOutlet UILabel *statusHeaderLabel;

@end
