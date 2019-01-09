//
//  STWalletReq.h
//  STWalletSDK
//
//  Created by 梁唐 on 2018/10/31.
//  Copyright © 2018 梁唐. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, STWalletProtocol) {
    /**SimpleWallet*/
    STProtocolSimpleWallet,
    /**STProtocol*/
    STProtocol
};

/*!
 * @class STWalletReq
 * @brief 基础数据
 */
@interface STWalletReq : NSObject

@property (nonatomic, readonly) NSString *version;            // 协议版本信息，如1.0
@property (nonatomic, assign) STWalletProtocol protocol;           // 协议名，钱包用来区分不同协议，默认为 STProtocolSimpleWallet
@property (nonatomic, copy) NSString *dappName;               // dapp名字，用于在钱包APP中展示
@property (nonatomic, copy) NSString *dappIcon;               // dapp图标Url，用于在钱包APP中展示
@property (nonatomic, copy) NSString *blockchain;             // 公链标识（eosio、ont、ethereum等）
@property (nonatomic, copy) NSString *action;                 // 登录时，赋值为login。支付时，赋值为transfer 退出登录 logout;
// Req->NSDictionary
-(NSDictionary *)toParams;
@end

#pragma mark - 登录
/*!
 * @class STWalletLoginReq
 * @brief 登录附加数据
 */
@interface STWalletLoginReq : STWalletReq

@property (nonatomic, copy) NSString *uuID;                     // dapp生成的，用于dapp登录验证唯一标识
@property (nonatomic, copy) NSString *loginUrl;                 // dapp server生成的，用于接受此次登录验证的URL
@property (nonatomic, copy) NSNumber *expired;                  // 登录过期时间，unix时间戳
@property (nonatomic, copy) NSString *loginMemo;                // 登录备注信息，钱包用来展示

@end

#pragma mark - 退出登录
@interface STWalletLogoutReq : STWalletReq


@end

typedef NS_ENUM(NSUInteger, STProtocolTransferActor) {
    /**wallet发起转账*/
    STProtocolTransferActorWallet,
    /**server发起转账*/
    STProtocolTransferActorServer
};
#pragma mark - 转账
/*!
 * @class STWalletTransferReq
 * @brief 转账附加数据
 */
@interface STWalletTransferReq : STWalletReq

@property (nonatomic, copy) NSString *from;                     // 付款人的账户或地址
@property (nonatomic, copy) NSString *fromAddress;        //付款账户公钥
@property (nonatomic, copy) NSString *to;                       // 收款人的账户或地址
@property (nonatomic, copy) NSString *amount;                   // 转账数量。如果精度为4、转账数量为1，则为1.0000；
@property (nonatomic, copy) NSString *contract;                 // 转账的token所属的contract账号名或地址
@property (nonatomic, copy) NSString *symbol;                   // 转账的token symbol
@property (nonatomic, copy) NSNumber *precision;                // 转账的token的精度，小数点后面的位数
@property (nonatomic, copy) NSString *dappData;                 // 由dapp生成的业务参数信息，需要钱包在转账时附加在memo或data中发出去
@property (nonatomic, copy) NSString *desc;                     // 交易的说明信息，钱包在付款UI展示给用户，最长不要超过128个字节
@property (nonatomic, copy) NSNumber *expired;                  // 交易过期时间，unix时间戳

//STProtocolTransferActorServer 下需传如下参数
@property(nonatomic,assign)STProtocolTransferActor actor;   //转账发起者 默认STProtocolTransferActorWallet
@property(nonatomic,copy)NSString * notifyUrl;  // STProtocolTransferActorServer 下回调地址
@property(nonatomic,copy)NSString * remarks;  // 第三方备注
@end

#pragma mark - 自定义Trasaction
/*!
 * @class STWalletTransactionReq
 * @brief 自定义Trasaction数据
 */
@interface STWalletTransactionReq : STWalletReq

@property (nonatomic, copy) NSString *from;                     // 付款人的账户或地址
/**
 actions结构示例 以转账为例
 
 STProtocol协议 结构: [{"code": "eosio.token","action": "transfer","args":@{from:"转出账户"，to : "转入账户",quantity : "金额",memo : "备注"}}]
 SimpleWallet协议 结构: [{"code": "eosio.token","action": "transfer","binargs":"00000"}]
 */
@property (nonatomic, copy) NSArray<NSDictionary *> *actions;
@property (nonatomic, copy) NSString *desc;                     // 交易的说明信息，钱包在付款UI展示给用户，最长不要超过128个字节
@property (nonatomic, copy) NSNumber *expired;                  // 交易过期时间，unix时间戳
/**STProtocol协议 需传*/
@property (nonatomic, copy) NSString *fromAddress;        //付款账户公钥

@end

/**STProtocol协议方法*/
#pragma mark - 自定义Trasaction
@interface STWalletAuthenticate : STWalletReq
@property (nonatomic, copy) NSString *from;     //账户名
@property (nonatomic, copy) NSString *fromAddress;        //账户公钥
/**不大于12位*/
@property (nonatomic, copy) NSString *nonce;        //签名内容
@end

