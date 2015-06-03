//
//  ClassroomBehaviors.h
//  BMTS
//
//  Created by JD Hatton on 2/19/15.
//  Copyright (c) 2015 Homeroom Technologies. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface ClassroomBehaviors : NSManagedObject

@property (nonatomic, retain) NSDate * beginDate;
@property (nonatomic, retain) NSNumber * behaviorId;
@property (nonatomic, retain) NSNumber * classroomId;
@property (nonatomic, retain) NSDate * endDate;
@property (nonatomic, retain) NSNumber * id;
@property (nonatomic, retain) NSNumber * statusId;
@property (nonatomic, retain) NSNumber * studentId;
@property (nonatomic, retain) NSNumber * trackingInterval;
@property (nonatomic, retain) NSNumber * synced;

@end
