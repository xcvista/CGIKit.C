//
//  CGIRequest.m
//  CGIKit
//
//  Created by Maxthon Chan on 12-10-17.
//  Copyright (c) 2012年 myWorld Creations. All rights reserved.
//

#import "CGIRequest.h"
#import "CGIResponse.h"
#import "CGIApplication.h"

NSDictionary *CGIDictionaryFromURLEncodedString(NSString *string)
{
    NSArray *parts = [string componentsSeparatedByString:@"&"];
    NSMutableDictionary *outputDictionary = [NSMutableDictionary dictionaryWithCapacity:parts.count];
    for (NSString *part in parts)
    {
        NSArray *components = [part componentsSeparatedByString:@"="];
        if (components.count < 2)
            components = [components arrayByAddingObject:[components objectAtIndex:0]];
        [outputDictionary setObject:[[components objectAtIndex:1] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding] forKey:[[components objectAtIndex:0] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    }
    return [outputDictionary copy];
}

NSString *CGIGetEnv(NSString *name)
{
    return [[[NSProcessInfo processInfo] environment] objectForKey:name];
}

@implementation CGIRequest

@synthesize requestData = _requestData;

- (id)init
{
    if (self = [super init])
    {
        NSFileHandle *handle = [NSFileHandle fileHandleWithStandardInput];
        _requestData = [handle readDataToEndOfFile];
    }
    return self;
}

- (NSInputStream *)requestStream
{
    return [NSInputStream inputStreamWithData:self.requestData];
}

- (NSDictionary *)queryString
{
    if (!_queryString)
        _queryString = CGIDictionaryFromURLEncodedString(CGIGetEnv(@"QUERY_STRING")); //Apache
    return _queryString;
}

- (NSDictionary *)form
{
    if (!_form)
        _form = CGIDictionaryFromURLEncodedString([[NSString alloc] initWithData:self.requestData
                                                                        encoding:NSUTF8StringEncoding]);
    return _form;
}

- (NSDictionary *)environment
{
    if (!_environment)
    {
        _environment = [[[NSProcessInfo processInfo] environment] copy];
    }
    return _environment;
}

- (void)dumpInformation
{
    NSMutableString *str = [@"<!DOCTYPE html>\n" mutableCopy];
    [str appendString:@"<html>\n<head>\n"];
    [str appendString:@"<title>CGIKit Info Dump</title>\n"];
    [str appendString:@"</head>\n<body>\n"];
    
    [str appendString:@"<h2>Environment</h2>\n"];
    [str appendString:@"<table>\n<tr><th>Key</th>\n"];
    [str appendString:@"<th>Value</th>\n"];
    for (NSString *key in self.environment)
        [str appendFormat:@"<tr><td>%@</td><td>%@</td>\n", key, [self.environment objectForKey:key]];
    [str appendString:@"</table>\n"];
    
    [str appendString:@"<h2>Query string</h2>\n"];
    [str appendString:@"<table>\n<tr><th>Key</th>\n"];
    [str appendString:@"<th>Value</th>\n"];
    for (NSString *key in self.queryString)
        [str appendFormat:@"<tr><td>%@</td><td>%@</td>\n", key, [self.queryString objectForKey:key]];
    [str appendString:@"</table>\n"];
    
    [str appendString:@"<h2>Form</h2>\n"];
    [str appendString:@"<table>\n<tr><th>Key</th>\n"];
    [str appendString:@"<th>Value</th>\n"];
    for (NSString *key in self.form)
        [str appendFormat:@"<tr><td>%@</td><td>%@</td>\n", key, [self.form objectForKey:key]];
    [str appendString:@"</table>\n"];
    
    [str appendString:@"<h2>Request Data</h2>\n"];
    [str appendFormat:@"<table><tr><td>%@</td></tr></table>\n", self.requestData];
    
    [str appendString:@"<hr /><div>&copy; 2012 Maxthon Chan</div>\n"];
    [str appendString:@"</body></html>"];
    [CGIApp.response.responseData appendData:[str dataUsingEncoding:NSUTF8StringEncoding]];
}

@end
