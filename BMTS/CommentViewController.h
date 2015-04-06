//
//  CommentViewController.h
//  BMTS
//
//  Created by JD Hatton on 1/6/15.
//  Copyright (c) 2015 Homeroom Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"

@interface CommentViewController : UIViewController <UITextFieldDelegate>


@property (weak, nonatomic) IBOutlet UITextField *commentTextField;

@property (weak, nonatomic) User *student;
@property (strong, nonatomic) UIWindow *window;
@property (weak, nonatomic) IBOutlet UILabel *headerLabel;

@end
