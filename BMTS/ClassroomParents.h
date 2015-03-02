//
//  ClassroomParents.h
//  BMTS
//
//  Created by JD Hatton on 2/19/15.
//  Copyright (c) 2015 Homeroom Technologies. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface ClassroomParents : NSManagedObject

@property (nonatomic, retain) NSNumber * classroomId;
@property (nonatomic, retain) NSNumber * id;
@property (nonatomic, retain) NSNumber * parentId;
@property (nonatomic, retain) NSNumber * studentId;

@end
