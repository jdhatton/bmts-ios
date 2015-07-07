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
@property (nonatomic, retain) NSString * studentId;
@property (nonatomic, retain) NSString * createdDate;
@property (nonatomic, retain) NSNumber * synced;

@end
