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

@implementation StudentMainView

@synthesize student, window, dayHeaderLabel,trackedBehaviorLbl;


 NSArray *items;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"DEBUG: StudentViewController::loading...   student = %@", student);
    
    
    NSMutableArray *behaviorList = [[NSMutableArray alloc] init];
    NSMutableArray *commentList = [[NSMutableArray alloc] init];
    
    NSString *headerText = [NSString stringWithFormat:@"%@%@", @" ", student.firstName];
    self.dayHeaderLabel.text = headerText;
    
    if( self.student != nil) {
        
        items = [NSArray arrayWithObjects:@"Egg Benedict", @"Mushroom Risotto", @"Full Breakfast", @"Hamburger", @"Ham and Egg Sandwich", @"Creme Brelee", @"White Chocolate Donut", @"Starbucks Coffee", @"Vegetable Curry", @"Instant Noodle with Egg", @"Noodle with BBQ Pork", @"Japanese Noodle with Pork", @"Green Tea", @"Thai Shrimp Cake", @"Angry Birds Cake", @"Ham and Cheese Panini", nil];
        
        
        NSError *error;
        NSManagedObjectContext *context = [appDelegate managedObjectContext];
        

        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
        NSEntityDescription *entity = [NSEntityDescription entityForName:@"StudentBehaviors" inManagedObjectContext:context];
        [fetchRequest setEntity:entity];
        NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
        for (StudentBehaviors *behavior in fetchedObjects) {
            
            if( behavior.studentId == student.id ){
                [behaviorList addObject:behavior];
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
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    cell.textLabel.text = [items objectAtIndex:indexPath.row];
    cell.imageView.image = [UIImage imageNamed:@"statusCircleRED-1.jpg"];
    return cell;
}

@end
