//
//  CGIResponse.h
//  CGIKit
//
//  Created by Maxthon Chan on 12-10-17.
//  Copyright (c) 2012年 myWorld Creations. All rights reserved.
//

#import "CGICommon.h"

@interface CGIResponse : NSObject

@property (strong) NSMutableDictionary *headers;
@property NSUInteger statusCode;
@property (strong) NSString *status;
@property (readonly) BOOL sent;
@property (strong) NSMutableData *responseData;

@property (strong) NSString *contentType;
@property (nonatomic, strong) NSString *cookie;

+ (NSString *)defaultStatusForCode:(NSUInteger)statusCode;

- (void)redirect:(NSString *)to;
- (void)send;

@end
