//
//  RestController.m
//  BMTS
//
//  Created by JD Hatton on 4/4/15.
//  Copyright (c) 2015 Homeroom Technologies. All rights reserved.
//

#import "RestController.h"

@implementation RestController



- (IBAction)fetchGreeting;
{
    //
    // http://localhost:8080/hello-world    http://rest-service.guides.spring.io/greeting
    //
    
    
    NSURL *url = [NSURL URLWithString:@"http://localhost:8080/hello-world"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response,
                                               NSData *data, NSError *connectionError)
     {
         if (data.length > 0 && connectionError == nil)
         {
             NSDictionary *greeting = [NSJSONSerialization JSONObjectWithData:data   options:0  error:NULL];
             NSLog(@"\n\n >>>>     REST:: Greeting ID %@", [[greeting objectForKey:@"id"] stringValue] );
             NSLog(@"\n\n >>>>     REST:: Greeting CONTENT %@", [greeting objectForKey:@"content"] );
             
         }
     }];
}



@end
