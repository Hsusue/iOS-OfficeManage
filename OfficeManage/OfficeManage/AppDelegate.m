//
//  AppDelegate.m
//  OfficeManage
//
//  Created by Hsusue on 2018/8/5.
//  Copyright © 2018年 Hsusue. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    return YES;
}


//- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
//    return YES;
//}
//
//- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url{
//    return YES;
//}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {
    
    if ([url.host isEqualToString:@"safepay"]) {
        //跳转支付宝钱包进行支付，处理支付结果
//        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
//            NSLog(@"result = %@",resultDic);
//        }];
    }else if ([url.host isEqualToString:@"pay"]){//微信支付
//        return [WXApi handleOpenURL:url delegate:self];
    }else if([url.host isEqualToString:@"oauth"]){//微信登陆
//        return [WXApi handleOpenURL:url delegate:self];
    }else if([url.host isEqualToString:@"qzapp"]){//QQ登陆
//        [QQApiInterface handleOpenURL:url delegate:self];
//        return [TencentOAuth HandleOpenURL:url];
    } else { //回调处理文件
        UIAlertController *alertCtl = [UIAlertController alertControllerWithTitle:@"保存文件成功"
                                                                           message:nil
                                                                    preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:nil];
        [alertCtl addAction:action];
        [self.window.rootViewController presentViewController:alertCtl animated:YES completion:nil];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"configFilesArray" object:nil];
        return YES;
    }
    
    return YES;
}



@end
