//
//  UserUIBarButtonItem.h
//  BMTS
//
//  Created by JD Hatton on 3/22/15.
//  Copyright (c) 2015 Homeroom Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"

@interface UserUIBarButtonItem : UIBarButtonItem

@property (weak, nonatomic) User *student;

@end
