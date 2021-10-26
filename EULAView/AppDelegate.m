//
//  AppDelegate.m
//  EULAView
//
//  Created by jabraknight on 2021/10/25.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    return YES;
}


#pragma mark - UISceneSession lifecycle


- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options {
    NSLog(@"创建了新的场景");

    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
}


- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions {
    NSLog(@"场景被释放");

    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
}

#pragma mark --如果使用SceneDelegate，原先AppDelegate的生命周期方法不再起作用。
#pragma mark 程序失去焦点的时候调用（不能跟用户进行交互了）

- (void)applicationWillResignActive:(UIApplication *)application

{

    NSLog(@"applicationWillResignActive-失去焦点");

}



#pragma mark 当应用程序进入后台的时候调用（点击HOME键）

- (void)applicationDidEnterBackground:(UIApplication *)application

{

    NSLog(@"applicationDidEnterBackground-进入后台");

}



#pragma mark 当应用程序进入前台的时候调用

- (void)applicationWillEnterForeground:(UIApplication *)application

{

    NSLog(@"applicationWillEnterForeground-进入前台");

}



#pragma mark 当应用程序获取焦点的时候调用

// 获取焦点之后才可以跟用户进行交互

- (void)applicationDidBecomeActive:(UIApplication *)application

{

    NSLog(@"applicationDidBecomeActive-获取焦点");

}



#pragma mark 程序在某些情况下被终结时会调用这个方法

- (void)applicationWillTerminate:(UIApplication *)application

{
    //某种情况下会调用
    NSLog(@"applicationWillTerminate-被关闭");

}
@end
