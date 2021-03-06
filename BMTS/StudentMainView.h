//
//  StudentMainView.h
//  BMTS
//
//  Created by JD Hatton on 3/28/15.
//  Copyright (c) 2015 Homeroom Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "User.h"

@interface StudentMainView : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) User *student;
@property (strong, nonatomic) UIWindow *window;
@property (weak, nonatomic) IBOutlet UILabel *dayHeaderLabel;

@property (weak, nonatomic) IBOutlet UILabel *trackedBehaviorLbl;

@property (weak, nonatomic) IBOutlet UITableView *itemList;

 

@end
