//
//  StudentMainView.m
//  BMTS
//
//  Created by JD Hatton on 3/28/15.
//  Copyright (c) 2015 Homeroom Technologies. All rights reserved.
//

#import "StudentMainView.h"
#import "StudentBehaviors.h"
#import "Comments.h"
#import "IPhone5MainViewController.h"
#import "TeacherMainViewController.h"

@implementation StudentMainView

@synthesize student, window, dayHeaderLabel,trackedBehaviorLbl;


 NSMutableArray *items;
 NSMutableArray *behaviorList; // = [[NSMutableArray alloc] init];

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"DEBUG: StudentViewController::loading...  [.1.] student = %@", self.student);
    
    NSMutableArray *commentList = [[NSMutableArray alloc] init];
    
    if(self.student == nil){
        NSLog(@"DEBUG: StudentViewController::appDelegate.currentSelectedStudent    =    %@",appDelegate.currentSelectedStudent);
        self.student = appDelegate.currentSelectedStudent;
    }

    //
    // TODO: move down to if block?
    //
    NSString *headerText = [NSString stringWithFormat:@"%@%@", @" ", self.student.firstName];
    self.dayHeaderLabel.text = headerText;
    
    if( self.student != nil) {
        
        items = [NSMutableArray arrayWithObjects: nil];
        behaviorList = [NSMutableArray arrayWithObjects: nil];
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"MM/dd/yyyy - hh:mma"];
        // MM/dd/yyyy hh:mma
        //Optionally for time zone conversions
        [formatter setTimeZone:[NSTimeZone timeZoneWithName:@"..."]];
        
 
        //
        //
        // TODO: only show the items for TODAY.
        //
        //
 
        
        NSError *error;
        NSManagedObjectContext *context = [appDelegate managedObjectContext];
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
        NSEntityDescription *entity = [NSEntityDescription entityForName:@"StudentBehaviors" inManagedObjectContext:context];
        [fetchRequest setEntity:entity];
        NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
        for (StudentBehaviors *behavior in fetchedObjects) {
            
            if( behavior.studentId == student.id ){
                [behaviorList addObject:behavior.statusId];
                
                // NSLog(@" StudentBehavior :statudId  =  %@", behavior.statusId);
                // NSLog(@" StudentBehavior :statudId  =  %@", behavior.studentId);
                // NSLog(@" StudentBehavior :statudId  =  %@", behavior.createdDate);
                
                NSDateFormatter *formatter2 = [[NSDateFormatter alloc] init];
                [formatter2 setDateFormat:@"YYYY-MM-dd\'T\'HH:mm:ss"];

                NSDate *dateObject = [formatter2 dateFromString:behavior.createdDate];
                
                NSString *stringCreatedDate = [formatter stringFromDate:dateObject];
                [items addObject:stringCreatedDate];
            }
        }
        
        NSFetchRequest *fetchRequest2 = [[NSFetchRequest alloc] init];
        NSEntityDescription *entity2 = [NSEntityDescription entityForName:@"Comments" inManagedObjectContext:context];
        [fetchRequest2 setEntity:entity2];
        NSArray *fetchedObjects2 = [context executeFetchRequest:fetchRequest2 error:&error];
        for (Comments *comment in fetchedObjects2) {

            if( comment.studentId == student.id ){
               [commentList addObject:comment];
            }
            
        }
        
        //unless ARC is active
        //[formatter release];
    }
    
 
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [items count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SimpleTableCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:simpleTableIdentifier];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
   cell.backgroundColor = [UIColor clearColor];
    
    //
    //
    //
    NSNumber *status = [behaviorList objectAtIndex:indexPath.row];
 
        if( status == [NSNumber numberWithInteger:1])
            cell.imageView.image = [UIImage imageNamed:@"statusCircleGREEN.jpg"];
        else if( status ==  [NSNumber numberWithInteger:2])
            cell.imageView.image = [UIImage imageNamed:@"statusCircleYELLOW.jpg"];
        else if( status ==  [NSNumber numberWithInteger:3])
            cell.imageView.image = [UIImage imageNamed:@"statusCircleRED-1.jpg"];
        else
            cell.imageView.image = [UIImage imageNamed:@"statusCircleGREEN.jpg"];
 
    cell.textLabel.text = [items objectAtIndex:indexPath.row];

    //
    // TODO: set the real value here.
    //
    cell.detailTextLabel.text = @" TESTING...1.2..3...  We can put the comment text here from StudentBehaviors.statusComment object. Cool stuff that will be here.";

    cell.detailTextLabel.numberOfLines = 2;
  //  cell.detailTextLabel.lineBreakMode = NSLineBreakByWordWrapping;
  //  cell.detailTextLabel.autoresizingMask = UIViewAutoresizingFlexibleHeight;
 
    // -- seperator
        UIView* separatorLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 400, 1)];/// change size as you need.
        separatorLineView.backgroundColor = [UIColor blackColor];// you can also put image here
        [cell.contentView addSubview:separatorLineView];
}


- (IBAction)save:(id)sender {
        //
        // Segue to the TeacherMainView
        //
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        TeacherMainViewController *teacherMainViewController = [storyboard instantiateViewControllerWithIdentifier:@"teacherMainView"];
        [self.window makeKeyAndVisible];
        [self.window.rootViewController presentViewController:teacherMainViewController animated:YES completion:NULL];
}
    
//Change the Height of the Cell [Default is 44]:
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath*)indexPath
{
    return 70;
    //    return 44;
}






- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];

    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    
    UIAlertView * alert =[[UIAlertView alloc ] initWithTitle:@"Status Comment:"
                                                     message:cell.detailTextLabel.text
                                                    delegate:self
                                           cancelButtonTitle:@"OK"
                                           otherButtonTitles: nil];
    [alert show];
}








@end
