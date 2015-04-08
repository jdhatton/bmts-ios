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
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://homeroomtechnologies.com:8080/registerUser"]];

    // Specify that it will be a POST request
    request.HTTPMethod = @"POST";

    // This is how we set header fields
    [request setValue:@"application/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];

    // Convert your data and set your request's HTTPBody property
    //NSString *stringData = @"some data";
 
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
    
    if (! jsonData) {
        NSLog(@"Got an error: %@", error);
    } else {
        NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    
    
    
    
    
    NSData *requestBodyData = jsonData;
    request.HTTPBody = requestBodyData;

    // Create url connection and fire request
    NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    

}



@end
