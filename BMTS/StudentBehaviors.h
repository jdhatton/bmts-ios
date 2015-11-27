//
//  StudentBehaviors.h
//  BMTS
//
//  Created by JD Hatton on 3/22/15.
//  Copyright (c) 2015 Homeroom Technologies. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface StudentBehaviors : NSManagedObject

@property (nonatomic, retain) NSNumber * statusId;
@property (nonatomic, retain) NSNumber * studentId;
@property (nonatomic, retain) NSString * createdDate;
@property (nonatomic, retain) NSNumber * synced;
@property (nonatomic, retain) NSString * statusComment;

@end
