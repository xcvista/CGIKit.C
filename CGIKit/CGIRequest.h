//
//  CGIRequest.h
//  CGIKit
//
//  Created by Maxthon Chan on 12-10-17.
//  Copyright (c) 2012年 myWorld Creations. All rights reserved.
//

#import "CGICommon.h"

@class CGIResponse, CGIApplication;

NSDictionary *CGIDictionaryFromURLEncodedString(NSString *);
NSString *CGIGetEnv(NSString *);

@interface CGIRequest : NSObject
{
@private
    NSDictionary *_queryString;
    NSDictionary *_form;
    NSDictionary *_environment;
}

@property (readonly, strong) NSData *requestData;


- (NSInputStream *)requestStream;
- (NSDictionary *)environment;
- (NSDictionary *)queryString;
- (NSDictionary *)form;

/*
    //Commonly-used fields.
- (NSHost *)client;
- (NSHost *)server;
- (NSUInteger)clientPort;
- (NSUInteger)serverPort;

- (NSString *)method;
- (NSURL *)requestURI;
- (NSString *)serverProtocol;

- (NSString *)host;
- (NSString *)userAgent;
- (NSURL *)referer;
- (NSArray *)acceptTypes;
- (NSString *)acceptLanguage;
- (NSString *)cookie;
*/

- (void)dumpInformation; //Miss phpinfo?

@end
