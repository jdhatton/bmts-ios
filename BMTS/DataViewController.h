//
//  DataViewController.h
//  BMTS
//
//  Created by JD Hatton on 11/5/14.
//  Copyright (c) 2014 Homeroom Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface DataViewController : UIViewController {
    
    UITextField *emailAddressTextBox;
    UITextField *passwordTextBox;
    UIButton *createAccountButton;
    UIButton *alreadyHaveAccountButton;
    UIButton *debugButton;
    
}

@property (strong, nonatomic) IBOutlet UITextField *emailAddressTextBox;
@property (strong, nonatomic) IBOutlet UITextField *passwordTextBox;
@property (strong, nonatomic) IBOutlet UIButton *createAccountButton;
@property (strong, nonatomic) IBOutlet UIButton *alreadyHaveAccountButton;
@property (strong, nonatomic) IBOutlet UIButton *debugButton;

- (IBAction)createAccount:(id)sender;
- (IBAction)alreadyHaveAccount:(id)sender;
- (IBAction)debug:(id)sender;



@property (strong, nonatomic) IBOutlet UILabel *dataLabel;
@property (strong, nonatomic) id dataObject;

@end

