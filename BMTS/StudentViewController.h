//
//  StudentViewController.h
//  Homeroom
//
//  Created by JD Hatton on 11/17/15.
//  Copyright © 2015 Homeroom Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "User.h"


@interface StudentViewController : UITabBarController

@property (weak, nonatomic) User *student;
@property (strong, nonatomic) UIWindow *window;

@end
