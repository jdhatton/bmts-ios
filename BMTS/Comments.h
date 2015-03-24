//
//  Comments.h
//  BMTS
//
//  Created by JD Hatton on 3/23/15.
//  Copyright (c) 2015 Homeroom Technologies. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Comments : NSManagedObject

@property (nonatomic, retain) NSString * comment;
@property (nonatomic, retain) NSNumber * studentId;
@property (nonatomic, retain) NSDate * createdDate;

@end
