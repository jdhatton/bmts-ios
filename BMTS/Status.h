//
//  Status.h
//  BMTS
//
//  Created by JD Hatton on 2/19/15.
//  Copyright (c) 2015 Homeroom Technologies. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Status : NSManagedObject

@property (nonatomic, retain) NSString * descr;
@property (nonatomic, retain) NSNumber * id;
@property (nonatomic, retain) NSString * name;

@end
