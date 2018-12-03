//
//  STWalletAPI.m
//  STWalletSDK
//
//  Created by 梁唐 on 2018/10/31.
//  Copyright © 2018 梁唐. All rights reserved.
//

#import "STWalletAPI.h"
#import <UIKit/UIKit.h>
#import "STHeader.h"

static const NSString *kParamKey  = @"param";
static const NSString *kCallbackKey  = @"callback";
static const NSString *kQuerySDK  = @"walletsdk";

static NSString *app_url_schemes;

@implementation STWalletAPI
/*!
 * @brief 注册URL Schemes
 * @param urlSchemes 在Xcode工程info.plist-> URL types -> URL Schemes里添加
 */
+ (void)registerAppURLSchemes:(NSString *)urlSchemes{
    app_url_schemes = urlSchemes;
}
/*!
 * @brief 向 STWallet 发起请求
 * @param req 登录/转账
 * @return YES/NO
 */
+ (BOOL)sendReq:(STWalletReq *)req{
    NSLog(@"当前类--->%@",req.class);
    if (app_url_schemes) {
        NSString * protocol;
        switch (req.currentProtocol) {
            case STProtocol:{
                protocol = @"STProtocol";
                NSDictionary * currentAccount =  [[NSUserDefaults standardUserDefaults]objectForKey:STCurrentAccounts];
                if ([req isKindOfClass:[STWalletLoginReq class]]) {
                    if (currentAccount && currentAccount.allKeys.count > 0) {
                        return YES;
                    }
                }else if ([req isKindOfClass:[STWalletTransferReq class]]){
                    STWalletTransferReq * transfer = (STWalletTransferReq *)req;
                    if (currentAccount && currentAccount.allKeys.count > 0) {
                        transfer.from = currentAccount[@"accountName"];
                        transfer.fromAddress = currentAccount[@"accountAddress"];
                    }else{
                        return NO;
                    }
                }else if([req isKindOfClass:[STWalletTransactionReq class]]){
                    STWalletTransactionReq * transaction = (STWalletTransactionReq *)req;
                    if (currentAccount && currentAccount.allKeys.count > 0) {
                        transaction.from = currentAccount[@"accountName"];
                        transaction.fromAddress = currentAccount[@"accountAddress"];
                    }else{
                        return NO;
                    }
                }else if([req isKindOfClass:[STWalletLogoutReq class]]){
                    [[NSUserDefaults standardUserDefaults]removeObjectForKey:STCurrentAccounts];
                    BOOL synchronize =  [[NSUserDefaults standardUserDefaults]synchronize];
                    if (synchronize) {
                        return YES;
                    }else{
                        return NO;
                    }
                }
            }
                
                break;
                
            case STProtocolSimpleWallet:
                protocol = @"SimpleWallet";
                break;
                
            default:
                return NO;
                break;
        }
        
        // Append callback
        NSMutableDictionary *params = req.toParams.mutableCopy;
        [params setObject:protocol forKey:@"currentProtocol"];
        [params setObject:[NSString stringWithFormat:@"%@://%@?",app_url_schemes,kQuerySDK] forKey:kCallbackKey];
        // To string
        NSString *paramsString = [STWalletAPI toJSONString:params];
        if (!paramsString) {
            return NO;
        }
        // Send
        NSString *urlString = [NSString stringWithFormat:STWalletOpenUrlPrefix,paramsString];
        urlString = [urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        urlString = [urlString stringByReplacingOccurrencesOfString:@" " withString:@""];
        return [STWalletAPI openURL:[NSURL URLWithString:urlString]];
    }
    return NO;
}
/*!
 * @brief   处理Wallet的回调
 * @discuss 在AppDelegate -(application:openURL:options:)方法里调用
 */
+ (BOOL)handleURL:(NSURL *)url result:(void(^)(STWalletResp *resq))result{
    NSLog(@"%@",url);
    if ([url.scheme isEqualToString:app_url_schemes]) {
        STWalletResp *resp = [STWalletAPI respWithURL:url];
        if (resp) {
            result(resp);
            return YES;
        }
    }
    return NO;
}

/**  解析回调url */
+ (STWalletResp *)respWithURL:(NSURL *)url {

    @try {
        NSString *query =[url.absoluteString componentsSeparatedByString:@"param="].lastObject;
        query = [query stringByRemovingPercentEncoding];
        NSDictionary *paramDict = [NSJSONSerialization JSONObjectWithData:[query dataUsingEncoding:NSUTF8StringEncoding] options:0 error:nil];
        NSString * currentProtocol = paramDict[@"currentProtocol"];
        NSString * action = paramDict[@"action"];
        if ([currentProtocol isEqualToString:@"SimpleWallet"]) {
            if(paramDict && action && paramDict[@"result"]){
                return [STWalletAPI STSimpleWalletResponse:paramDict];
            }
        }else if ([currentProtocol isEqualToString:@"STProtocol"]){
            if(paramDict && action && paramDict[@"data"]){
                return [STWalletAPI STProtocolResponse:paramDict];
            }
        }
        return nil;
    } @catch (NSException *exception) {
        NSLog(@"---->%@",exception);
        return nil;
    } @finally {}
}
+(STWalletResp *)STSimpleWalletResponse:(NSDictionary *)param{
    @try {
        NSString * currentProtocol = param[@"currentProtocol"];
        
        STWalletResp *resp = [[STWalletResp alloc] init];
        resp.currentProtocol = currentProtocol;
        resp.action = param[@"action"];
        resp.result = [param[@"result"] intValue];
        resp.data = param;
        return resp;
    } @catch (NSException *exception) {
        NSLog(@"---->%@",exception);
    } @finally {}
}
+(STWalletResp *)STProtocolResponse:(NSDictionary *)param{
    @try {
        NSString * currentProtocol = param[@"currentProtocol"];
        NSString * action = param[@"action"];
        
        STWalletResp *resp = [[STWalletResp alloc] init];
        resp.currentProtocol = currentProtocol;
        resp.action = param[@"action"];
        resp.code = [param[@"code"] integerValue];
        resp.message = param[@"message"];
        resp.data = param[@"data"];
        
        if ([action isEqualToString:@"login"] && resp.data.allKeys.count > 0) {
            [[NSUserDefaults standardUserDefaults]setObject:resp.data forKey:STCurrentAccounts];
            [[NSUserDefaults standardUserDefaults]synchronize];
        }
        return resp;
    } @catch (NSException *exception) {
        NSLog(@"---->%@",exception);
        return nil;
    } @finally {}
}

/**!
 * @brief obj->JSON String
 */
+(NSString *)toJSONString:(id)obj {
    NSError *error;
    NSData *data = [NSJSONSerialization dataWithJSONObject:obj options:0 error:&error];
    if (!error){
        return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    }
    return nil;
}
/**!
 * @brief Open URL
 */
+(BOOL)openURL:(NSURL *)url {
    if([[UIApplication sharedApplication] canOpenURL:url]){
        if (@available(iOS 10.0, *)) {
            [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
        } else {
            [[UIApplication sharedApplication] openURL:url];
        }
        return YES;
    }else{
        NSLog(@"error : 未安装starteos钱包");
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:STDownloadPath]];
        return NO;
    }

}
/**
 * @brief Open URL截取URL中的参数
 */
+ (NSMutableDictionary *)getURLParameters:(NSString *)parameterString {
    // 以字典形式将参数返回
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    // 判断参数是单个参数还是多个参数
    if ([parameterString containsString:@"&"]) {
        NSArray *urlComponents = [parameterString componentsSeparatedByString:@"&"];
        for (NSString *keyValuePair in urlComponents) {
            NSArray *pairComponents = [keyValuePair componentsSeparatedByString:@"="];
            NSString *key = [pairComponents.firstObject stringByRemovingPercentEncoding];
            NSString *value = [pairComponents.lastObject stringByRemovingPercentEncoding];
            
            if (key == nil || value == nil) {
                continue;
            }
            [params setValue:value forKey:key];
        }
        
    } else {            // 单个参数
        NSArray *pairComponents = [parameterString componentsSeparatedByString:@"="];
        if (pairComponents.count == 1) {
            return nil;
        }
        NSString *key = [pairComponents.firstObject stringByRemovingPercentEncoding];
        NSString *value = [pairComponents.lastObject stringByRemovingPercentEncoding];
        if (key == nil || value == nil) {
            return nil;
        }
        [params setValue:value forKey:key];
        
    }
    return params;
    
}
@end
