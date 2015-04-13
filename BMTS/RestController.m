//
//  RestController.m
//  BMTS
//
//  Created by JD Hatton on 4/4/15.
//  Copyright (c) 2015 Homeroom Technologies. All rights reserved.
//

#import "RestController.h"
#import "User.h"

@implementation RestController



- (IBAction)fetchGreeting;
{
    //
    // http://localhost:8080/hello-world    http://rest-service.guides.spring.io/greeting
    //
    
    
    NSURL *url = [NSURL URLWithString:@"http://homeroomtechnologies.com:8080/hello-world"];
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


- (NSArray*)fetchDistrictsForZipCode:(NSString *)srcZipCode;
{
 
    NSLog(@"\n >>>>  ..1..    REST::  fetchDistrictsForZipCode ");
    NSArray *districts;
    
 
    NSString *searchURL = [@"http://homeroomtechnologies.com:8080/schoolSearch?zip=" stringByAppendingString:srcZipCode];
    NSLog(@"\n >>>>  ..2..    REST::  fsearchURL =  %@", searchURL);
    
    
    NSURL *url = [NSURL URLWithString:searchURL];
    NSLog(@"\n >>>>  ..3..    REST::  url =  %@", [url absoluteString]);

    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSLog(@"\n >>>>  ..4..    REST::  request =  %@", [request debugDescription]);
    
 //   + (NSData *)sendSynchronousRequest:(NSURLRequest *)request returningResponse:(NSURLResponse **)response error:(NSError **)error;
    // Send a synchronous request
    NSURLRequest * urlRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:searchURL]];
    NSURLResponse * response = nil;
    NSError * error = nil;
    NSData * data = [NSURLConnection sendSynchronousRequest:urlRequest
                                          returningResponse:&response
                                                      error:&error];
    
    if (error == nil)
    {
        NSLog(@"\n >>>>     REST:: response =  %@", [response debugDescription] );
//        NSLog(@"\n >>>>     REST:: data =  %@", data );
        if (data.length > 0 )
        {
            
            NSDictionary *districtData = [NSJSONSerialization JSONObjectWithData:data   options:0  error:NULL];
            NSLog(@"\n >>>>     REST:: districtData  =  %@", districtData );
 
            districts = [[NSMutableArray alloc] init];
            NSMutableArray *jsonDistricts = [NSJSONSerialization JSONObjectWithData: data options:NSJSONReadingMutableContainers error:nil];
//            [districts addObjectsFromArray:jsonDistricts];
            
            
            NSArray *idData = [jsonDistricts valueForKey:@"id"];
            NSLog(@"idData=%@", idData);
            NSArray *nameData = [jsonDistricts valueForKey:@"name"];
            NSLog(@"nameData=%@", nameData);
//            [districts addObjectsFromArray:nameData];
            districts = nameData;
            
        }

    }
    NSLog(@"\n >>>>  ..5..    REST::  returning districts  =  %@", districts);
    NSLog(@"\n >>>>  ..6..    REST::  request =  %@", @"Done");
    return districts;

    
}


- (IBAction)registerUser:(User *)user;
{
    
    NSLog(@"\n >>>>  ..1..    REST::POST::    registerUser ");

    // Convert your data and set your request's HTTPBody property
    //NSString *stringData = @"some data";
    NSString *jsonString;
    
    NSMutableDictionary *fields = [NSMutableDictionary dictionary];
    for (NSAttributeDescription *attribute in [[user entity] properties]) {
        NSString *attributeName = attribute.name;
        id attributeValue = [user valueForKey:attributeName];
        if (attributeValue) {
            [fields setObject:attributeValue forKey:attributeName];
        }
    }
    
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:fields
                                                       options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
                                                         error:&error];
    NSLog(@"\n jsonData = %@", jsonData);
 
    if (! jsonData) {
        NSLog(@"Got an error: %@", error);
    } else {
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
 
    NSURL *url = [NSURL URLWithString:@"http://localhost:8080/registerUser"];
    NSMutableURLRequest *rq = [NSMutableURLRequest requestWithURL:url];
    [rq setHTTPMethod:@"POST"];
    
 //   NSData *jsonData = [@"{ \"foo\": 1337 }" dataUsingEncoding:NSUTF8StringEncoding];
    [rq setHTTPBody:jsonData];
    
    [rq setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [rq setValue:[NSString stringWithFormat:@"%ldn", (long)[jsonData length]] forHTTPHeaderField:@"Content-Length"];
    
    [NSURLConnection sendAsynchronousRequest:rq
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response,
                                               NSData *data, NSError *connectionError)
     {
         if (data.length > 0 && connectionError == nil)
         {
             NSLog(@"\n\n    >>>>>    POST sent!");
             NSDictionary *resp = [NSJSONSerialization JSONObjectWithData:data   options:0  error:NULL];
             NSLog(@"\n\n >>>>     REST:: RESP : ID %@", [[resp objectForKey:@"id"] stringValue] );
             NSLog(@"\n\n >>>>     REST:: RESP : CONTENT %@", [resp objectForKey:@"content"] );
             //
             // set this User record to synced = true.
             //
             
         }
     }];
    
     NSLog(@"did it happen???");

}



@end