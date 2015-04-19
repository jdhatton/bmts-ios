//
//  Feedback.h
//  BMTS
//
//  Created by JD Hatton on 4/18/15.
//  Copyright (c) 2015 Homeroom Technologies. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Feedback : NSManagedObject

@property (nonatomic, retain) NSString * comment;
@property (nonatomic, retain) NSString * id;

@end
