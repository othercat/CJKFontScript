//
//  main.m
//  KanjiFail-Lite
//
//  Created by ShikiSuen on 2014/10/27.
//  Copyright (c) 2014 Richard Li & Shiki Suen. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <AppleScriptObjC/AppleScriptObjC.h>

int main(int argc, const char * argv[]) {
    [[NSBundle mainBundle] loadAppleScriptObjectiveCScripts];
    return NSApplicationMain(argc, argv);
}
