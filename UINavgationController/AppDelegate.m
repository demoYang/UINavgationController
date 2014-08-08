//
//  AppDelegate.m
//  UINavgationController
//
//  Created by niexin on 12-9-12.
//  Copyright (c) 2012年 niexin. All rights reserved.
//

#import "AppDelegate.h"

#import "PrintLog.h"
#import "Define.h"
#import <FacebookSDK/FacebookSDK.h>

@implementation AppDelegate


@synthesize window;
@synthesize nav;
@synthesize firstView;
@synthesize session;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    
    if (isIphone5) {
        firstView = [[NavRootViewController alloc] initWithNibName:@"NavRootViewController45" bundle:nil ];
    }else{
        firstView = [[NavRootViewController alloc] initWithNibName:@"NavRootViewController" bundle:nil ];
    }
    
    nav = [[NavigationController alloc]initWithRootViewController:firstView];

    self.window.rootViewController = nav;
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    
    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge|UIRemoteNotificationTypeSound|UIRemoteNotificationTypeAlert)];
    
    
//    UIRemoteNotificationType enabledTypes =[[UIApplication sharedApplication] enabledRemoteNotificationTypes];
    
    
    self.session = [[FBSession alloc] init];
    
    
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    LOGINFO(@"qwerqwer%@",@"qwerqwer");
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    
    LOGINFO(@"qwerqwer%@",@"qwerqwer");
    [FBAppEvents activateApp];
    [FBAppCall handleDidBecomeActiveWithSession:self.session];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    [self.session close];
}



-(BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
    
    return [FBAppCall handleOpenURL:url sourceApplication:sourceApplication withSession:self.session];
}


- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)newDeviceToken
{

    LOGINFO(@"我的设备ID: %@", newDeviceToken);
    
}
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    //    [PFPush handlePush:userInfo];
    for (id key in userInfo) {
        LOGINFO(@"key: %@, value: %@", key, [userInfo objectForKey:key]);
    }
    
}


-(void)application:(UIApplication*)application didFailToRegisterForRemoteNotificationsWithError:(NSError*)error
{
    LOGINFO(@"注册失败，无法获取设备ID, 具体错误: %@", error);
}


-(BOOL)shouldAutorotate{
    return [self.nav shouldAutorotate];;
}

-(NSUInteger)supportedInterfaceOrientations{
    return [self.nav supportedInterfaceOrientations];
}

-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation{
    return [self.nav shouldAutorotateToInterfaceOrientation:toInterfaceOrientation];
}







@end
