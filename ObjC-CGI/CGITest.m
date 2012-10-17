//
//  CGITest.m
//  CGIKit
//
//  Created by Maxthon Chan on 12-10-17.
//  Copyright (c) 2012年 myWorld Creations. All rights reserved.
//

#import "CGITest.h"

@implementation CGITest

- (void)applicationDidFinishLaunching:(CGIApplication *)application
{
    [application.request dumpInformation];
}

@end
