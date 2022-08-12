//
//  AppDelegate.m
//  VoiceOverDemo
//
//  Created by Allison on 2022/8/3.
//

#import "AppDelegate.h"
#import "ViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window.rootViewController = [[UINavigationController alloc]initWithRootViewController:[ViewController new]];
    return YES;
}



@end
