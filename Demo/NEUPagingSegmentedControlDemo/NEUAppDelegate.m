//
//  NEUAppDelegate.m
//  NEUPagingSegmentedControlDemo
//
//  Created by Ben on 06/05/2014.
//  Copyright (c) 2014 bcylin. All rights reserved.
//

#import "NEUAppDelegate.h"
#import "NEUViewController.h"

@implementation NEUAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];

    UIViewController *controller = [[NEUViewController alloc] init];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:controller];
    self.window.rootViewController = navigationController;

    [self.window makeKeyAndVisible];
    return YES;
}

@end
