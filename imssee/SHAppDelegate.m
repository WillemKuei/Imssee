//
//  AppDelegate.m
//  imssee
//
//  Created by 鑫易 on 14/12/26.
//  Copyright (c) 2014年 鑫易. All rights reserved.
//

#import "SHAppDelegate.h"
#import "Reachability.h"

//Change the host name here to change the server you want to monitor.
#define HOST_NAME @"www.apple.com.cn"

@interface SHAppDelegate ()

@property (nonatomic) Reachability *hostReachability;
@property (nonatomic) Reachability *internetReachability;
@property (nonatomic) Reachability *wifiReachability;

@end

@implementation SHAppDelegate

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kReachabilityChangedNotification object:nil];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    //网络状态检测
    /*
     Observe the kNetworkReachabilityChangedNotification. When that notification is posted, the method reachabilityChanged will be called.
     */
    //监听网络状态
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChanged:) name:kReachabilityChangedNotification object:nil];
    
    /*****Testing GitHub****/
    self.hostReachability = [Reachability reachabilityWithHostName:HOST_NAME];
    [self.hostReachability startNotifier];
//    [self updateInterfaceWithReachability:self.hostReachability];
    
//    self.internetReachability = [Reachability reachabilityForInternetConnection];
//    [self.internetReachability startNotifier];
//    [self updateInterfaceWithReachability:self.internetReachability];
    
//    self.wifiReachability = [Reachability reachabilityForLocalWiFi];
//    [self.wifiReachability startNotifier];
//    [self updateInterfaceWithReachability:self.wifiReachability];
    
    return YES;
}

- (void)reachabilityChanged:(NSNotification *)note
{
    Reachability *curReach = [note object];
    NSParameterAssert([curReach isKindOfClass:[Reachability class]]);
    [self updateInterfaceWithReachability:curReach];
}

- (void)updateInterfaceWithReachability:(Reachability *)reachability
{
    NetworkStatus netStatus = [reachability currentReachabilityStatus];
    switch (netStatus) {
        case NotReachable:          //无网络
        {
            [UIHelper alertWithTitle:@"温馨提示" andMSG:@"亲，世界最遥远的距离就是没网络！"];
            break;
        }
        case ReachableViaWiFi:      //连WIFI
        {
            //[UIHelper alertWithTitle:@"温馨提示" andMSG:@"正在使用WIFI网络"];
            break;
        }
        case ReachableViaWWAN:      //连3G/4G
        {
            //[UIHelper alertWithTitle:@"温馨提示" andMSG:@"正在使用3G/4G网络，请注意流量!"];
            break;
        }
            
        default:
            break;
    }
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
