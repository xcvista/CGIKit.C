//
//  CGIResponse.m
//  CGIKit
//
//  Created by Maxthon Chan on 12-10-17.
//  Copyright (c) 2012年 myWorld Creations. All rights reserved.
//

#import "CGIResponse.h"
#import "CGIApplication.h"
#import "CGIRequest.h"

@implementation CGIResponse

@synthesize statusCode = _statusCode;
@synthesize headers = _headers;
@synthesize status = _status;
@synthesize sent = _sent;
@synthesize responseData = _responseData;
@synthesize contentType = _contentType;

+ (NSString *)defaultStatusForCode:(NSUInteger)statusCode
{
    switch (statusCode)
    {
        case 200:
            return @"OK";
        case 204:
            return @"No Response";
        case 302:
            return @"Found";
        case 400:
            return @"Bad Request";
        case 401:
            return @"Unauthorized";
        case 403:
            return @"Forbidden";
        case 503:
            return @"Service Unavalible";
        default:
            return nil;
    }
}

- (id)init
{
    if (self = [super init])
    {
        self.headers = [NSMutableDictionary dictionary];
        self.statusCode = 200;
        _sent = NO;
        _responseData = [NSMutableData data];
        self.contentType = @"text/html";
        self.cookie = @""; //CGIApp.request.cookie;
    }
    return self;
}

- (void)setStatusCode:(NSUInteger)statusCode
{
    @synchronized (self)
    {
        _statusCode = statusCode;
        self.status = [CGIResponse defaultStatusForCode:statusCode];
    }
}

- (NSUInteger)statusCode
{
    @synchronized (self)
    {
        return _statusCode;
    }
}

- (void)redirect:(NSString *)to
{
    self.headers = [NSMutableDictionary dictionaryWithObject:to forKey:@"Location"];
    self.statusCode = 302;
    [self send];
}

- (NSString *)cookie
{
    return [self.headers objectForKey:@"Set-Cookie"];
}

- (void)setCookie:(NSString *)cookie
{
    [self.headers setObject:cookie forKey:@"Set-Cookie"];
}

- (void)send
{
    NSMutableData *outputData = [NSMutableData data];
    [self.headers setObject:[NSString stringWithFormat:@"%lu %@", self.statusCode, self.status] forKey:@"Status"];
    if (self.statusCode != 302)
        [self.headers setObject:self.contentType forKey:@"Content-Type"];
    for (NSString *key in self.headers)
    {
        [outputData appendData:[[NSString stringWithFormat:@"%@: %@\n", key, [self.headers objectForKey:key]] dataUsingEncoding:NSUTF8StringEncoding]];
    }
    [outputData appendData:[@"\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [outputData appendData:self.responseData];
    NSFileHandle *handle = [NSFileHandle fileHandleWithStandardOutput];
    [handle writeData:outputData];
    _sent = YES;
}

@end
