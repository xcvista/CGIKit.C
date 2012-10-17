//
//  CGIApplication.h
//  CGIKit
//
//  Created by Maxthon Chan on 12-10-17.
//  Copyright (c) 2012年 myWorld Creations. All rights reserved.
//

#import "CGICommon.h"

@class CGIApplication, CGIRequest, CGIResponse;

CGIApplication *CGIApp;

@protocol CGIApplicationDelegate <NSObject>

- (void)applicationDidFinishLaunching:(CGIApplication *)application;

@end

int CGIApplicationMain(int, const char **, Class, id<CGIApplicationDelegate>);

@interface CGIApplication : NSObject

@property (strong) id <CGIApplicationDelegate> delegate;
@property (readonly, strong) CGIRequest *request;
@property (readonly, strong) CGIResponse *response;

+ (CGIApplication *)sharedApplication;
- (void)run;

@end
