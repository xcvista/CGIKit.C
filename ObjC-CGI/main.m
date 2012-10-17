//
//  main.m
//  ObjC-CGI
//
//  Created by Maxthon Chan on 12-10-17.
//  Copyright (c) 2012年 myWorld Creations. All rights reserved.
//

#import <CGIKit/CGIKit.h>
#import "CGITest.h"

int main(int argc, const char * argv[])
{
    int rv;
    rv = CGIApplicationMain(argc, argv, nil, [[CGITest alloc] init]);
    return rv;
}

