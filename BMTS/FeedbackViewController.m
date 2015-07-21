//
//  FeedbackViewController.m
//  BMTS
//
//  Created by JD Hatton on 3/21/15.
//  Copyright (c) 2015 Homeroom Technologies. All rights reserved.
//

#import "FeedbackViewController.h"
#import "RestController.h"

@interface FeedbackViewController ()

@end

@implementation FeedbackViewController

@synthesize student, feedback;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
    
    self.feedback.delegate = self;
    
}

-(void)dismissKeyboard {
    [feedback resignFirstResponder];
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{

    if([text isEqualToString:@"\n"]) {
        [self.feedback resignFirstResponder];
        return NO;
    }
    
    return YES;
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)saveComment:(id)sender {
    // NSLog(@"DEBUG: Saving Feedback... ");
    RestController *restCntrlr  = [RestController alloc];
    [restCntrlr sendFeedback:self.feedback.text];
}

- (IBAction)saveFormData:(id)sender {
    // NSLog(@"DEBUG: Saving Feedback... ");
}


@end
