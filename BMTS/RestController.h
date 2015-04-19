//
//  RestController.h
//  BMTS
//
//  Created by JD Hatton on 4/4/15.
//  Copyright (c) 2015 Homeroom Technologies. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"
#import "AppDelegate.h"

@interface RestController : NSObject

- (IBAction)fetchGreeting;

- (NSArray*)fetchDistrictsForZipCode:(NSString *)srcZipCode;

- (IBAction)registerUser:(User *)user;

- (IBAction)sendFeedback:(NSString *)comment;


@end
