//
//  User.h
//  BMTS
//
//  Created by JD Hatton on 4/17/15.
//  Copyright (c) 2015 Homeroom Technologies. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface User : NSManagedObject

@property (nonatomic, retain) NSString * email;
@property (nonatomic, retain) NSString * firstName;
@property (nonatomic, retain) NSString * gender;
@property (nonatomic, retain) NSNumber * id;
@property (nonatomic, retain) NSString * lastName;
@property (nonatomic, retain) NSNumber * paid;
@property (nonatomic, retain) NSString * phone;
@property (nonatomic, retain) NSNumber * registered;
@property (nonatomic, retain) NSString * remoteId;
@property (nonatomic, retain) NSNumber * role;
@property (nonatomic, retain) NSString * schoolDistrict;
@property (nonatomic, retain) NSNumber * schoolGrade;
@property (nonatomic, retain) NSString * schoolName;
@property (nonatomic, retain) NSNumber * status;
@property (nonatomic, retain) NSNumber * synced;
@property (nonatomic, retain) NSNumber * zipCode;
@property (nonatomic, retain) NSString * password;
@property (nonatomic, retain) NSString * studentIdNumber;
@property (nonatomic, retain) NSString * deviceId;
@property (nonatomic, retain) NSNumber * deleted;
@property (nonatomic, retain) NSData  * profileImg;


@end
