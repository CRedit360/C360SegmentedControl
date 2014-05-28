//
//  C360AppDelegate.m
//  C360SegmentedControlDemo
//
//  Created by Simon Booth on 28/05/2014.
//  Copyright (c) 2014 CRedit360. All rights reserved.
//

#import "C360AppDelegate.h"
#import "C360DemoController.h"

@implementation C360AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController = [[C360DemoController alloc] init];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

@end
