//
//  ViewController.m
//  SDKDemo
//
//  Created by 圣光 on 2018/11/23.
//  Copyright © 2018年 圣光. All rights reserved.
//

#import "ViewController.h"
#import "STWalletSDK/STWalletAPI.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadDefaultsSetting];
    [self initSubViews];
}
#pragma mark >_<! 👉🏻 🐷Life cycle🐷
#pragma mark >_<! 👉🏻 🐷System Delegate🐷
#pragma mark >_<! 👉🏻 🐷Custom Delegate🐷
#pragma mark >_<! 👉🏻 🐷Event  Response🐷
#pragma mark >_<! 👉🏻 🐷Private Methods🐷
-(void)cusaction{
    //暂不可用
}

-(void)transfer{
    
    STWalletTransferReq * req = [[STWalletTransferReq alloc] init];
    //目前只支持SimpleWallet协议！
    req.currentProtocol = STProtocolSimpleWallet;
    req.dappName = @"第三方应用";
    req.dappIcon = nil;
    req.blockchain = @"eosio";
    req.action = @"transfer";
    req.to = @"starteosio22";
    //For the convenience of operation, please fill in the valid eos account name in starteos wallet
    req.from = @"starteosio11";
    req.amount = @"0.0001";
    req.contract = @"eosio.token";
    req.symbol = @"EOS";
    req.precision = @(4);
    req.dappData = @"测试转账";
    req.desc = @"转账操作";
    req.expired = [NSNumber numberWithLong:([NSDate date].timeIntervalSince1970 + 60)];
    BOOL result = [STWalletAPI sendReq:req];
    NSLog(@"转账调用---%d",result);
}
-(void)login{
    
    STWalletLoginReq *loginReq = [[STWalletLoginReq alloc] init];
    //目前只支持SimpleWallet协议！
    loginReq.currentProtocol = STProtocolSimpleWallet;
    // 公链标识
    loginReq.blockchain = @"eosio";   // eosio、eosforce、ethereum 目前只支持eosio
    // DApp信息
    loginReq.dappIcon = @"http://yourIcon.png";
    loginReq.dappName = @"Demos";
    // DApp Server
    loginReq.uuID = @"uid";
    loginReq.loginUrl = @"https://newdex.340wan.com/api/account/walletVerify/";
    loginReq.expired = [NSNumber numberWithLong:([NSDate date].timeIntervalSince1970 + 60)];
    loginReq.loginMemo = @"Memo";
    
    BOOL result = [STWalletAPI sendReq:loginReq];
    
    NSLog(@"登录调用---%d",result);
}

-(void)customAction{
    STWalletTransactionReq * req = [[STWalletTransactionReq alloc] init];
    // DApp信息
    req.dappIcon = @"http://yourIcon.png";
    req.dappName = @"Demos";
    //starteos会根据该字段查找本地钱包
    req.from = @"starteosio11";
    //合约调用参数
    NSDictionary * dic = @{
        @"code":@"eosio.token",
        @"action":@"transfer",
        @"args":@{@"from":@"starteosio11",@"to":@"starteosio22",@"quantity":@"0.0001 EOS",@"memo":@"自定义action 1"}};
    NSDictionary * dic1 = @{
           @"code":@"eosio.token",
           @"action":@"transfer",
           @"args":@{@"from":@"starteosio11",@"to":@"starteosio22",@"quantity":@"0.0001 EOS",@"memo":@"自定义action 2"}};
    NSDictionary * dic2 = @{
           @"code":@"eosio.token",
           @"action":@"transfer",
           @"args":@{@"from":@"starteosio11",@"to":@"starteosio22",@"quantity":@"0.0001 EOS",@"memo":@"自定义action 3"}};
    //actions
    req.actions = @[dic,dic1,dic2];
    //将展示在界面上供客户观看
    req.desc = @"自定义转账测试";
    //固定搭配
    req.currentProtocol = STProtocolSimpleWallet;
    //链类型，该接口目前支持 EOS:eosio  BOS:bosio MEETONE:meetoneio FIBOS:fibosio
    req.blockchain = @"eosio";
    //过期时间，该过期时间只用于starteos判断是否进行签名，不作为交易过期时间，交易过期时间由starteos设置为当前节点时间+60s
    req.expired = [NSNumber numberWithLong:([NSDate date].timeIntervalSince1970 + 60)];
    
    //如果不设置则默认会选择from账号下合适的私钥进行签名，如果设置，则优先会找from账号下fromAddress公钥对应的私钥进行签名
//    req.fromAddress = @"EOSxxx"
    
    //设置签名账号及权限，如果不设置则starteos会默认使用from字段对应账下公钥为fromAdress的权限，如果没有fromAdress，starteos会自动选择from账号下合适的权限(优先级active>owner>其他)
    STSignAccount * account = [[STSignAccount alloc] init];
    account.actor = @"starteosio11";
    account.permission = @"active";
    //如果不涉及多签，建议您不要设置 actors 和 fromAddress 字段，starteos钱包会默认帮您选择合适的权限进行相关操作。注意⚠️：如果传了该字段，则starteos不会自动为该交易做资源代付
//    req.actors = @[account];
    BOOL result = [STWalletAPI sendReq:req];
    NSLog(@"自定义合约调用---%d",result);
    
    /*
     isPush == NO
     param.data = {
        sign:{
            compression:none,
            packed_context_free_data = 00,
            packed_trx = c2f2a35e34458d90a1f4000000000100a6823403ea3055000000572d3ccdcd003010027598aa7c4dc620047598aa7c4dc6010000000000000004454f53000000000fe887aae5ae9ae4b989616374696f6e00,
            signatures = [
                SIG_K1_KhH8UpitzvV3Ls83Q1Km4ARkwqHYUqhGffbmSgga3VdKJ1R9f9HCdjqc4EKeSer9bJEdrXYRUWXNNnW2UUtNjdCzjD4dvA,
            ]
     
        },
         params:{
            actions = [
                        {
                    account = "eosio.token";
                    authorization = [
                        actor : starteosio11,
                        permission : active
                    ];
                    data = 10027598aa7c4dc620047598aa7c4dc6010000000000000004454f53000000000fe887aae5ae9ae4b989616374696f6e;
                    name = transfer;
                }
            ];
            expiration = "2020-04-25T08:20:18.500";
            "ref_block_num" = 117327156;
            "ref_block_prefix" = 4104229005;
         }
     }
     返回参数解释
     返回的param中data 为本次签名数据，其中
     sign 为push参数，您可以直接将该字段下的数据调用"v1_push_transaction"
     如果您涉及多签，可以将 sign.packed_trx 中的数据补齐相应链id 和 32个0 后进行 ECC签名
     如果您想要重新对交易进行序列化，可以使用data.params 中的参数进行序列化
     
     isPush == YES
     返回参数解释
     返回参数为原始push结果
     
     */
}

-(void)logout{
   //暂不可用
}
#pragma mark >_<! 👉🏻 🐷Lazy loading🐷
#pragma mark >_<! 👉🏻 🐷Init SubViews🐷

-(void)loadDefaultsSetting{
    
}
-(void)initSubViews{
    UIButton * login = [[UIButton alloc]initWithFrame:CGRectMake(130, 100, 150, 30)];
    [login setTitle:@"Login" forState:UIControlStateNormal];
    [login setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    [login addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:login];
    
    UIButton * transfer = [[UIButton alloc]initWithFrame:CGRectMake(130, 150, 150, 30)];
    [transfer setTitle:@"transfer" forState:UIControlStateNormal];
    [transfer setTitleColor:[UIColor purpleColor] forState:UIControlStateNormal];
    [transfer addTarget:self action:@selector(transfer) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:transfer];
    
    UIButton * logout = [[UIButton alloc]initWithFrame:CGRectMake(130, 250, 150, 30)];
    [logout setTitle:@"退出" forState:UIControlStateNormal];
    [logout setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [logout addTarget:self action:@selector(logout) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:logout];
    
    UIButton * customAction = [[UIButton alloc]initWithFrame:CGRectMake(130, 300, 150, 30)];
    [customAction setTitle:@"自定义Action" forState:UIControlStateNormal];
    [customAction setTitleColor:[UIColor cyanColor] forState:UIControlStateNormal];
    [customAction addTarget:self action:@selector(customAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:customAction];
}

@end
