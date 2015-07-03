//
//  AddBehaviorViewController.h
//  Homeroom
//
//  Created by JD Hatton on 6/25/15.
//  Copyright (c) 2015 Homeroom Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddBehaviorViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *behavior;
@property (weak, nonatomic) IBOutlet UIButton *saveBehavior;
@property (strong, nonatomic) UIWindow *window;

@end
