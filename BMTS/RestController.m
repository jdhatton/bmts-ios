//
//  RestController.m
//  BMTS
//
//  Created by JD Hatton on 4/4/15.
//  Copyright (c) 2015 Homeroom Technologies. All rights reserved.
//

#import "RestController.h"
#import "User.h"
#import "Comments.h"
#import "AppDelegate.h"
#import "Feedback.h"
#import "Behaviors.h"

@implementation RestController

///  NSString *REST_SERVER_HOST = [@"http://homeroomtechnologies.com:8080"];

 

  NSString *const SERVICES_HOST_PREFIX = @"http://";
  NSString *const SERVICES_HOST_URL = @"homeroomtechnologies.com" ;
  NSString *const SERVICES_HOST_PORT = @"8080";


- (IBAction)fetchGreeting;
{
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

    // Add the password to be sent
    user.password = appDelegate.userPassword;
    
    // Convert your data and set your request's HTTPBody property
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
 
    NSURL *url = [NSURL URLWithString:@"http://homeroomtechnologies.com:8080/registerUser/add"];
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
             NSLog(@"\n    >>>>>    POST sent!  response   =  %@ ", response );
             NSLog(@"\n    >>>>>    POST sent!  resp data  =  %@ ", data  );
             NSDictionary *resp = [NSJSONSerialization JSONObjectWithData:data   options:0  error:NULL];
             NSLog(@"\n    >>>>>    POST sent!  resp   =  %@ ", resp );
             NSLog(@"\n >>>>     REST:: RESP : ID %@", [[resp objectForKey:@"id"] stringValue] );
             NSLog(@"\n >>>>     REST:: RESP : CONTENT %@", [resp objectForKey:@"remoteId"] );
             
             user.registered = @1;
             user.synced = @1;
             user.remoteId = [resp objectForKey:@"remoteId"];
             appDelegate.userRemoteId = user.remoteId;
             
             NSError *error;
             NSManagedObjectContext *context = [appDelegate managedObjectContext];
             if (![context save:&error]) {
                 NSLog(@"\n\n ERROR!!!    Whoops, couldn't save: %@", [error localizedDescription]);
             } else {
                 NSLog(@"\n SUCCESS  - User - UPDATED  ");
             }
             
         }
     }];
    
}




- (IBAction)sendFeedback:(NSString *)comment;
{
    
    NSLog(@"\n >>>>  ..1..    REST::POST::    sendFeedback ");
    
    NSError *error;
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    Feedback  *comments = [NSEntityDescription  insertNewObjectForEntityForName:@"Feedback" inManagedObjectContext:context];
    comments.comment = comment;
    comments.id = appDelegate.userRemoteId;
    
    NSLog(@"\n >>>>  ..2..    REST::POST::    appDelegate.userRemoteId  =   %@", appDelegate.userRemoteId);

    
    // Convert your data and set your request's HTTPBody property
    NSString *jsonString;
    
    NSMutableDictionary *fields = [NSMutableDictionary dictionary];
    for (NSAttributeDescription *attribute in [[comments entity] properties]) {
        NSString *attributeName = attribute.name;
        id attributeValue = [comments valueForKey:attributeName];
        if (attributeValue) {
            [fields setObject:attributeValue forKey:attributeName];
        }
    }
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:fields options:NSJSONWritingPrettyPrinted error:&error];
    NSLog(@"\n jsonData = %@", jsonData);
    
    if (! jsonData) {
        NSLog(@"Got an error: %@", error);
    } else {
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    
    NSURL *url = [NSURL URLWithString:@"http://homeroomtechnologies.com:8080/feedback/add"];
    NSMutableURLRequest *rq = [NSMutableURLRequest requestWithURL:url];
    [rq setHTTPMethod:@"POST"];
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
             NSLog(@"\n    >>>>>    POST sent!  response   =  %@ ", response );
             NSLog(@"\n    >>>>>    POST sent!  resp data  =  %@ ", data  );
             NSDictionary *resp = [NSJSONSerialization JSONObjectWithData:data   options:0  error:NULL];
             NSLog(@"\n    >>>>>    POST sent!  resp   =  %@ ", resp );
             
         }
     }];
    
    NSLog(@"did it happen???");
    
}

//
// TODO: Implement these.
//
- (IBAction)addStudent:(User *)user;
{
    
    NSLog(@"\n >>>>  ..1..    REST::POST::  addStudent ");
    
    // Convert your data and set your request's HTTPBody property
    NSString *jsonString;
    
    NSMutableDictionary *fields = [NSMutableDictionary dictionary];
    for (NSAttributeDescription *attribute in [[user entity] properties]) {
        NSString *attributeName = attribute.name;
        id attributeValue = [user valueForKey:attributeName];
        if (attributeValue) {
            [fields setObject:attributeValue forKey:attributeName];
        }
    }
    
    //
    // Add the teacherId to associate this student to.
    //
    if (appDelegate.userRemoteId == nil || appDelegate.userRemoteId == (id)[NSNull null]) {
        NSLog(@"\n >>>>  ..2A..    appDelegate.userRemoteId  is NULL  ");
        
    } else {
        NSLog(@"\n >>>>  ..2B..    appDelegate.userRemoteId  =   %@ ", appDelegate.userRemoteId);
    }
    [fields setObject:appDelegate.userRemoteId forKey:@"teacherId"];
    
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:fields
                                                       options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
                                                         error:&error];
    if (! jsonData) {
        NSLog(@"Got an error: %@", error);
    } else {
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    NSLog(@"\n jsonData = %@", jsonString);
    
    NSURL *url = [NSURL URLWithString:@"http://homeroomtechnologies.com:8080/remoteSync/addStudent"];
    NSMutableURLRequest *rq = [NSMutableURLRequest requestWithURL:url];
    [rq setHTTPMethod:@"POST"];
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
             NSLog(@"\n    >>>>>    POST sent!  response   =  %@ ", response );
             NSLog(@"\n    >>>>>    POST sent!  resp data  =  %@ ", data  );
             NSDictionary *resp = [NSJSONSerialization JSONObjectWithData:data   options:0  error:NULL];
             NSLog(@"\n    >>>>>    POST sent!  resp   =  %@ ", resp );
             NSLog(@"\n >>>>     REST:: RESP : ID %@", [[resp objectForKey:@"id"] stringValue] );
             NSLog(@"\n >>>>     REST:: RESP : CONTENT %@", [resp objectForKey:@"remoteId"] );
             
             user.registered = @1;
             user.synced = @1;
             user.remoteId = [resp objectForKey:@"remoteId"];
             appDelegate.userRemoteId = user.remoteId;
             
             NSError *error;
             NSManagedObjectContext *context = [appDelegate managedObjectContext];
             if (![context save:&error]) {
                 NSLog(@"\n\n ERROR!!!    Whoops, couldn't save: %@", [error localizedDescription]);
             } else {
                 NSLog(@"\n SUCCESS  - User - UPDATED  ");
             }
             
         }
     }];
    
}







- (IBAction)syncComments:(User *)user;
{
    
    NSLog(@"\n >>>>  ..1..    REST::POST::  syncComments ");
    NSMutableDictionary *fields = [NSMutableDictionary dictionary];
    
    //
    // Get the Comments not synced.
    //
    NSError *error;
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Comments" inManagedObjectContext:context];
    
    [fetchRequest setEntity:entity];
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    for (Comments *comment in fetchedObjects) {
        if( comment.synced  == false ){ //0

            NSLog(@" syncComments() Syncing: ");
            NSLog(@" ----------------------------------------");
            NSLog(@" Comment : comment      :  %@", comment.comment);
            NSLog(@" Comment : studentId    :  %@", comment.studentId);
            NSLog(@" Comment : createdDate  :  %@", comment.createdDate);
            NSLog(@" Comment : synced       :  %@", comment.synced);
            NSLog(@" ----------------------------------------");
            
            for (NSAttributeDescription *attribute in [[comment entity] properties]) {
                NSString *attributeName = attribute.name;
                id attributeValue = [comment valueForKey:attributeName];
                if (attributeValue) {
                    [fields setObject:attributeValue forKey:attributeName];
                }
            }
        }
    }

    
    // Convert your data and set your request's HTTPBody property
    NSString *jsonString;
    
  
    
    //
    // Add the teacherId to associate this student to.
    //
    if (appDelegate.userRemoteId == (id)[NSNull null]) {
        NSLog(@"\n >>>>  ..2A..    appDelegate.userRemoteId  is NULL  ");
        
    } else {
        NSLog(@"\n >>>>  ..2B..    appDelegate.userRemoteId  =   %@ ", appDelegate.userRemoteId);
    }
    [fields setObject:appDelegate.userRemoteId forKey:@"teacherId"];
    
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:fields
                                                       options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
                                                         error:&error];
    if (! jsonData) {
        NSLog(@"Got an error: %@", error);
    } else {
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    NSLog(@"\n jsonData = %@", jsonString);
    
    NSURL *url = [NSURL URLWithString:@"http://homeroomtechnologies.com:8080/remoteSync/comments"];
    NSMutableURLRequest *rq = [NSMutableURLRequest requestWithURL:url];
    [rq setHTTPMethod:@"POST"];
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
             NSLog(@"\n    >>>>>    POST sent!  response   =  %@ ", response );
             NSLog(@"\n    >>>>>    POST sent!  resp data  =  %@ ", data  );
             NSDictionary *resp = [NSJSONSerialization JSONObjectWithData:data   options:0  error:NULL];
             NSLog(@"\n    >>>>>    POST sent!  resp   =  %@ ", resp );
             NSLog(@"\n >>>>     REST:: RESP : ID %@", [[resp objectForKey:@"id"] stringValue] );
             
             for (Comments *comment in fetchedObjects) {
                 if( comment.synced  == false ){ //0
                     comment.synced = [NSNumber numberWithInt:1];
                 }
             }
             
             NSError *error;
             NSManagedObjectContext *context = [appDelegate managedObjectContext];
             if (![context save:&error]) {
                 NSLog(@"\n\n ERROR!!!    Whoops, couldn't save: %@", [error localizedDescription]);
             } else {
                 NSLog(@"\n SUCCESS  - User - UPDATED  ");
             }
             
         }
     }];
    
}





- (IBAction)syncBehaviors:(User *)user;
{
    NSLog(@"\n >>>>  ..1..    REST::POST::  syncBehaviors ");
    NSMutableDictionary *fields = [NSMutableDictionary dictionary];
    
    //
    // Get the Comments not synced.
    //
    NSError *error;
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Behaviors" inManagedObjectContext:context];
    
    [fetchRequest setEntity:entity];
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    for (Behaviors *behavior in fetchedObjects) {
        if( behavior.synced  == false ){ //0
            
            NSLog(@" syncBehaviors() Syncing: ");
            NSLog(@" ----------------------------------------");
            NSLog(@" Behavior : descr      :  %@", behavior.descr);
            NSLog(@" Behavior : name       :  %@", behavior.name);
            NSLog(@" Behavior : sortOrder  :  %@", behavior.sortOrder);
            NSLog(@" Behavior : statusId   :  %@", behavior.statusId);
            NSLog(@" Behavior : synced     :  %@", behavior.synced);
            NSLog(@" ----------------------------------------");
            
            for (NSAttributeDescription *attribute in [[behavior entity] properties]) {
                NSString *attributeName = attribute.name;
                id attributeValue = [behavior valueForKey:attributeName];
                if (attributeValue) {
                    [fields setObject:attributeValue forKey:attributeName];
                }
            }
        }
    }
    
    
    // Convert your data and set your request's HTTPBody property
    NSString *jsonString;
    
    //
    // Add the teacherId to associate this student to.
    //
    if (appDelegate.userRemoteId == (id)[NSNull null]) {
        NSLog(@"\n >>>>  ..2A..    appDelegate.userRemoteId  is NULL  ");
        
    } else {
        NSLog(@"\n >>>>  ..2B..    appDelegate.userRemoteId  =   %@ ", appDelegate.userRemoteId);
    }
    [fields setObject:appDelegate.userRemoteId forKey:@"teacherId"];
    
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:fields
                                                       options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
                                                         error:&error];
    if (! jsonData) {
        NSLog(@"Got an error: %@", error);
    } else {
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    NSLog(@"\n jsonData = %@", jsonString);
    
    NSURL *url = [NSURL URLWithString:@"http://homeroomtechnologies.com:8080/remoteSync/behaviors"];
    NSMutableURLRequest *rq = [NSMutableURLRequest requestWithURL:url];
    [rq setHTTPMethod:@"POST"];
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
             NSLog(@"\n    >>>>>    POST sent!  response   =  %@ ", response );
             NSLog(@"\n    >>>>>    POST sent!  resp data  =  %@ ", data  );
             NSDictionary *resp = [NSJSONSerialization JSONObjectWithData:data   options:0  error:NULL];
             NSLog(@"\n    >>>>>    POST sent!  resp   =  %@ ", resp );
             NSLog(@"\n >>>>     REST:: RESP : ID %@", [[resp objectForKey:@"id"] stringValue] );
             
             for (Behaviors *behavior in fetchedObjects) {
                 if( behavior.synced  == false ){ //0
                     behavior.synced = [NSNumber numberWithInt:1];
                 }
             }
             
             NSError *error;
             NSManagedObjectContext *context = [appDelegate managedObjectContext];
             if (![context save:&error]) {
                 NSLog(@"\n\n ERROR!!!    Whoops, couldn't save: %@", [error localizedDescription]);
             } else {
                 NSLog(@"\n SUCCESS  - User - UPDATED  ");
             }
             
         }
     }];
    
}




//
// TODO: implement these
//
- (IBAction)syncAll:(User *)user
{
    
}


- (IBAction)updateStudent:(User *)user
{
    
}

- (IBAction)inviteStudent:(User *)user
{
    
}



@end
