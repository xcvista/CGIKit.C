//
//  CGIApplication.m
//  CGIKit
//
//  Created by Maxthon Chan on 12-10-17.
//  Copyright (c) 2012年 myWorld Creations. All rights reserved.
//

#import "CGIApplication.h"
#import "CGIRequest.h"
#import "CGIResponse.h"

@interface CGIApplication ()

@end

int CGIApplicationMain(int argc, const char **argv,
                       Class application, id<CGIApplicationDelegate> delegate)
{
    if (!application)
        application = [CGIApplication class];
    
        //Make the instance
    CGIApp = (CGIApplication *)[application sharedApplication];
    CGIApp.delegate = delegate;
    [CGIApp run];
    return 0;
}

@implementation CGIApplication

@synthesize delegate = _delegate;
@synthesize request = _request;
@synthesize response = _response;

+ (CGIApplication *)sharedApplication
{
    if (!CGIApp)
        CGIApp = [[CGIApplication alloc] init];
    return CGIApp;
}

- (void)run
{
    _request = [[CGIRequest alloc] init];
    _response = [[CGIResponse alloc] init];
    [self.delegate applicationDidFinishLaunching:self];
    if (!self.response.sent)
        [self.response send];
}

@end
