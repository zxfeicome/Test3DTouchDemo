//
//  AppDelegate.m
//  Test3DTouchDemo
//
//  Created by 曾飞 on 2019/2/21.
//  Copyright © 2019年 浙江集商优选电子商务有限公司. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    //首先判断是否支持3DTouch
    if ([self isCan3DTouch]) {
        //设置3DTouch
        [self create3DTouch];
    }
    
    return YES;
}
//代码创建3DTouch
- (void)create3DTouch
{
    NSMutableArray *shortcutItems = (NSMutableArray *)[UIApplication sharedApplication].shortcutItems;
    [shortcutItems removeAllObjects];
    //只设置标题和唯一标识
    UIApplicationShortcutItem *shortcutItem1 = [[UIApplicationShortcutItem alloc] initWithType:@"type1" localizedTitle:@"第一个"];
    //设置系统图标样式类型
    UIApplicationShortcutItem *shortcutItem2 = [[UIApplicationShortcutItem alloc] initWithType:@"type2" localizedTitle:@"第二个" localizedSubtitle:@"我是副标题" icon:[UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypeAdd] userInfo:@{@"name":@"zzz"}];
    //设置标题为空
    UIApplicationShortcutItem *shortcutItem3 = [[UIApplicationShortcutItem alloc] initWithType:@"type3" localizedTitle:nil localizedSubtitle:@"我是副标题" icon:[UIApplicationShortcutIcon iconWithTemplateImageName:@"yj_3dTouch_message_icon"] userInfo:nil];
    //设置本地图片样式
    UIApplicationShortcutItem *shortcutItem4 = [[UIApplicationShortcutItem alloc] initWithType:@"type4" localizedTitle:@"第四个" localizedSubtitle:@"我是副标题" icon:[UIApplicationShortcutIcon iconWithTemplateImageName:@"yj_3dTouch_message_icon"] userInfo:nil];
    
    [shortcutItems addObjectsFromArray:@[shortcutItem1,shortcutItem2,shortcutItem3,shortcutItem4]];
    
    [UIApplication sharedApplication].shortcutItems = shortcutItems;
    
}
//判断是否可以支持3DTouch
- (BOOL)isCan3DTouch
{
    //由于traitCollection 在iOS 8.0以后支持 forceTouchCapability 在iOS 9.0以后支持 需要做防奔溃处理
    if ([self.window respondsToSelector:@selector(traitCollection)]) {
        if ([self.window.traitCollection respondsToSelector:@selector(forceTouchCapability)]) {
            if (self.window.traitCollection.forceTouchCapability == UIForceTouchCapabilityAvailable) {
                return YES;
            }
        }
    }
    return NO;
}
//3DTouch 快捷菜单点击回调代理
- (void)application:(UIApplication *)application performActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem completionHandler:(void (^)(BOOL))completionHandler
{
    if ([shortcutItem.type isEqualToString:@"type"]) {
        //执行代码
    }
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options
{
    if ([url.host isEqualToString:@"test"]) {
        NSLog(@"test");
    }
    return YES;
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    if ([url.host isEqualToString:@"test"]) {
        NSLog(@"test");
    }
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
