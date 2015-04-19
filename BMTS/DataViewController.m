//
//  DataViewController.m
//  BMTS
//
//  Created by JD Hatton on 11/5/14.
//  Copyright (c) 2014 Homeroom Technologies. All rights reserved.
//

#import "DataViewController.h"
#import "Reachability.h"
#import "AppDelegate.h"
#import "User.h"
#import "UserCookie.h"
#import "RegisterOneViewController.h"
#import "TeacherMainViewController.h"


@interface DataViewController ()

@property (nonatomic) Reachability *hostReachability;
@property (nonatomic, weak) IBOutlet UITextField *remoteHostStatusField;

@end

@implementation DataViewController

@synthesize emailAddressTextBox, passwordTextBox, createAccountButton, alreadyHaveAccountButton, debugButton, remoteHostImageView ;
@synthesize window = _window;

NSManagedObjectContext *context = nil;
BOOL isValidForSegue = true;


- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"DEBUG: loading main view");
    NSLog(@"HOME > %@", NSHomeDirectory());
    
    NSArray *directories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documents = [directories firstObject];
    NSLog(@"DOCUMENTS > %@", documents);
 
    
    NSLog(@"DEBUG: DataViewController LOADING...");
    NSLog(@"DEBUG: DataViewController appDelegate  =  %@",appDelegate);
    
    
    NSError *error;
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"User" inManagedObjectContext:context];
    
    [fetchRequest setEntity:entity];
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    for (User *user in fetchedObjects) {
        NSLog(@" Found User : userId: %@", user.id);

    
//        NSLog(@" Deleting: User : userId: %@", user.id);
//        [context deleteObject:user];
        
    }
//    if (![context save:&error]) {
//        NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
//    } else {
//        NSLog(@"\n SUCCESS - Deleted all Users from SqlLite");
//    }

    
    
    /*
     Observe the kNetworkReachabilityChangedNotification. When that notification is posted, the method reachabilityChanged will be called.
     */
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChanged:) name:kReachabilityChangedNotification object:nil];
    NSString *remoteHostName = @"homeroomtechnologies.com";
    self.hostReachability = [Reachability reachabilityWithHostName:remoteHostName];
    [self.hostReachability startNotifier];
    [self updateInterfaceWithReachability:self.hostReachability];
    

    //
    // Trying to segui over to main view..  This might work, if it does use it if not DELETE it.
    //
   
    //
    // TODO: this should be conditional on a User and UserCookie existing.
    //
    //    [self performSegueWithIdentifier:@"showTeacherView" sender:self];
    
    NSLog(@"DEBUG: Attempting Segway to TeacherMainView");
//    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//    TeacherMainViewController *main = [storyboard instantiateViewControllerWithIdentifier:@"teacherMainView"];
//    [self presentViewController:main animated:YES completion:nil];
    
    
//    TeacherMainViewController *mainView = [[TeacherMainViewController alloc]init];
//    [self.navigationController presentViewController:mainView animated:NO completion:nil];
    //    [self presentViewController:cameraView animated:NO completion:nil]; //this will cause view is not in the window hierarchy error
    NSLog(@"DEBUG: Should have gone to to TeacherMain View....");
    
}

/*!
 * Called by Reachability whenever status changes.
 */
- (void) reachabilityChanged:(NSNotification *)note
{
    Reachability* curReach = [note object];
    NSParameterAssert([curReach isKindOfClass:[Reachability class]]);
    [self updateInterfaceWithReachability:curReach];
}


- (void)updateInterfaceWithReachability:(Reachability *)reachability
{
    if (reachability == self.hostReachability)
    {
        [self configureStatus:self.remoteHostStatusField imageView:self.remoteHostImageView reachability:reachability];
    }
}



- (void)configureStatus:(UITextField *)textField imageView:(UIImageView *)imageView reachability:(Reachability *)reachability
{
    NetworkStatus netStatus = [reachability currentReachabilityStatus];
    BOOL connectionRequired = [reachability connectionRequired];
    NSString* statusString = @"";
    
    NSLog(@"DEBUG: Network Status = %ld", netStatus);
    
    switch (netStatus)
    {
        case NotReachable:        {
            statusString = NSLocalizedString(@"Access Not Available", @"Text field text for access is not available");
            imageView.image = [UIImage imageNamed:@"stop-32.png"] ;
            /*
             Minor interface detail- connectionRequired may return YES even when the host is unreachable. We cover that up here...
             */
            connectionRequired = NO;
            break;
        }
            
        case ReachableViaWWAN:        {
            statusString = NSLocalizedString(@"Reachable WWAN", @"");
            imageView.image = [UIImage imageNamed:@"WWAN5.png"];
            break;
        }
        case ReachableViaWiFi:        {
            statusString= NSLocalizedString(@"Reachable WiFi", @"");
            imageView.image = [UIImage imageNamed:@"Airport.png"];
            break;
        }
    }
    
    if (connectionRequired)
    {
        NSString *connectionRequiredFormatString = NSLocalizedString(@"%@, Connection Required", @"Concatenation of status string with connection requirement");
        statusString= [NSString stringWithFormat:connectionRequiredFormatString, statusString];
    }
    textField.text= statusString;
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    
}

/**
 *
 * This is the method to take the form data and create the initial data models.
 * This method should also do any processing...
 *
 */
- (void)createAccount:(id)sender
{
    NSLog(@"DEBUG: you touched the createAccount button");
    
    NSLog(@"DEBUG: validating the form when clicking create account.");
    
    // Email and Password must be provided for form submission.
    
    // If both are not provided show alert.
    
    if( ! self.emailAddressTextBox.text.length > 0 ) {
        UIAlertView * alert =[[UIAlertView alloc ] initWithTitle:@"INFO:"
        message:@"Please provided an email and password to get started! "
                                                    delegate:self
                                           cancelButtonTitle:@"OK"
                                           otherButtonTitles: nil];
        [alert show];
        isValidForSegue = false;
    }
    else if( ! self.passwordTextBox.text.length > 0 ){
        UIAlertView * alert =[[UIAlertView alloc ] initWithTitle:@"INFO:"
                                                         message:@"Please provided an email and password to get started! "
                                                        delegate:self
                                               cancelButtonTitle:@"OK"
                                               otherButtonTitles: nil];
        [alert show];
        isValidForSegue = false;
    }
    else if( [self isValidEmail:self.emailAddressTextBox.text ] == false) {
        UIAlertView * alert =[[UIAlertView alloc ] initWithTitle:@"INFO:"
                                                         message:@"Please provided a valid email to get started! "
                                                        delegate:self
                                               cancelButtonTitle:@"OK"
                                               otherButtonTitles: nil];
        [alert show];
        isValidForSegue = false;
    }
    
//    else if( self.passwordTextBox.text.length > 0 && [self.NSStringIsValidEmail:self.passwordTextBox.text]){
//        
//    }
    else {
    
        // If both are provided - goto next view.
        [emailAddressTextBox resignFirstResponder];
        [passwordTextBox resignFirstResponder];
        
        NSError *error;
        NSManagedObjectContext *context = [appDelegate managedObjectContext];
        UserCookie *userCookie1 = [NSEntityDescription
                                          insertNewObjectForEntityForName:@"UserCookie"
                                          inManagedObjectContext:context];
        userCookie1.userId = [NSNumber numberWithInt:1];
        userCookie1.email = emailAddressTextBox.text;
        userCookie1.password = passwordTextBox.text;
    
        User *user = [NSEntityDescription
                insertNewObjectForEntityForName:@"User"
                inManagedObjectContext:context];
        user.id = [NSNumber numberWithInt:1];
        user.email = emailAddressTextBox.text;
    
        if (![context save:&error]) {
            NSLog(@"\n\n ERROR!!!    Whoops, couldn't save: %@", [error localizedDescription]);
        } else {
            NSLog(@"\n SUCCESS  - User & UserCookie SAVED ");
        }
        
        isValidForSegue = true;
        
        appDelegate.userPassword = passwordTextBox.text;
        
        //
        // Segway to the TeacherMainView
        //
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        RegisterOneViewController *registerOneViewController = [storyboard instantiateViewControllerWithIdentifier:@"registerOneView"];
        [self.window makeKeyAndVisible];
        [self.window.rootViewController presentViewController:registerOneViewController animated:YES completion:NULL];
        

    }
    
}

- (void)alreadyHaveAccount:(id)sender
{
    NSLog(@"DEBUG: you touched the alreadyHaveAccount button");

}

- (void)debug:(id)sender
{
    NSLog(@"DEBUG: you touched the debug button");
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    return YES;
}

-(BOOL) isValidEmail:(NSString *)checkString
{
    BOOL stricterFilter = NO; // Discussion http://blog.logichigh.com/2010/09/02/validating-an-e-mail-address/
    NSString *stricterFilterString = @"[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}";
    NSString *laxString = @".+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:checkString];
}


- (IBAction)validateBeforeSubmit:(id)sender {
}


- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender {
    
        if (!isValidForSegue) {
            //prevent segue from occurring
            return NO;
        }
    
    // by default perform the segue transition
    return YES;
}

@end
