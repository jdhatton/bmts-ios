//
//  FeedbackViewController.h
//  BMTS
//
//  Created by JD Hatton on 3/21/15.
//  Copyright (c) 2015 Homeroom Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"

@interface FeedbackViewController : UIViewController <UITextViewDelegate>

@property (weak, nonatomic) User *student;
@property (weak, nonatomic) IBOutlet UITextView *feedback;

@end
