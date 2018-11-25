//
//  STWalletResp.h
//  STWalletSDK
//
//  Created by 梁唐 on 2018/10/31.
//  Copyright © 2018 梁唐. All rights reserved.
//

#import <Foundation/Foundation.h>

/*!
 * @brief 处理结果
 */
typedef NS_ENUM(NSUInteger, STWalletRespResult) {
    STWalletRespResultCanceled = 0,               // 取消
    STWalletRespResultSuccess,                    // 成功
    STWalletRespResultFailure,                    // 失败
};

/*!
 * @brief   响应回调
 * @discuss data    action=transfer -> data={"txID":"交易ID"}
 *                  action=login -> data=nil
 */

@interface STWalletResp : NSObject
@property (nonatomic, assign) STWalletRespResult result;      // 处理结果
@property (nonatomic, copy) NSString *action;      // 处理类型
@property (nonatomic, copy) NSDictionary *data;                 // 附加数据
@property(nonatomic,copy)NSString * currentProtocol;
/**协议为STProtocol时有以下字段*/
@property(nonatomic,assign)NSInteger code;
@property(nonatomic,copy)NSString * message;
@end

