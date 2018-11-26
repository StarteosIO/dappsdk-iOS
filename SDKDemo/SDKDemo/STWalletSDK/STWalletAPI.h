//
//  STWalletAPI.h
//  STWalletSDK
//
//  Created by 梁唐 on 2018/10/31.
//  Copyright © 2018 梁唐. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "STWalletReq.h"
#import "STWalletResp.h"

@interface STWalletAPI : NSObject
/*!
 * @brief 注册URL Schemes
 * @param urlSchemes 在Xcode工程info.plist-> URL types -> URL Schemes里添加
 */
+ (void)registerAppURLSchemes:(NSString *)urlSchemes;

/*!
 * @brief 向 wallet 发起请求
 * @param req 登录/转账
 * @return YES/NO
 */
+ (BOOL)sendReq:(STWalletReq *)req;


/*!
 * @brief   处理wallet的回调
 * @discuss 在AppDelegate -(application:openURL:options:)方法里调用
 */
+ (BOOL)handleURL:(NSURL *)url result:(void(^)(STWalletResp *resq))result;



@end
