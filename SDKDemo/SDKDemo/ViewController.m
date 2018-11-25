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
    
    // 暂不可用
    
    //    STWalletTransactionReq * transaction = [[STWalletTransactionReq alloc]init];
    //
    //    /**STProtocol 协议 登录状态下可不传*/
    //    //    req.fromAddress = @"转出公钥";
    //    //    req.from = @"转出账户";
    ////    transaction.from = app.account;
    ////    transaction.fromAddress = app.address;
    //
    //    //示例
    //    transaction.actions = @[
    //                            @{@"code": @"eosio.token",@"action": @"transfer",@"args":@{}},
    //                            @{@"code": @"eosio.token",@"action": @"transfer",@"args" : @{
    //                                      @"from" : @"123123123123",
    //                                      @"to" : @"565656565656",
    //                                      @"quantity" : @"10.0000 EOS",
    //                                      @"memo" : @"备注"
    //                                      }},
    //                            ];
    //     BOOL result =   [STWalletAPI sendReq:transaction];
    //      NSLog(@"自定义action调用---%d",result);
}
-(void)transfer{
    
    STWalletTransferReq * req = [[STWalletTransferReq alloc] init];
    //    req.currentProtocol = STProtocolSimpleWallet;
    
    /**STProtocol 协议 登录状态下可不传*/
    //    req.fromAddress = @"转出公钥";
    //    req.from = @"转出账户";
    
    
    req.dappName = @"第三方应用";
    req.dappIcon = nil;
    req.blockchain = @"eosio";
    req.action = @"transfer";
    req.to = @"zijin.x";
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
//        loginReq.currentProtocol = STProtocolSimpleWallet;
    // 公链标识
    loginReq.blockchain = @"eosio";   // eosio、eosforce、ethereum
    // DApp信息
    loginReq.dappIcon = @"http://www.mathwallet.org/images/download/wallet_cn.png";
    loginReq.dappName = @"Demos";
    // DApp Server
    loginReq.uuID = @"uid";
    loginReq.loginUrl = @"longaaa";
    loginReq.expired = [NSNumber numberWithLong:([NSDate date].timeIntervalSince1970 + 60)];
    loginReq.loginMemo = @"Memo";
    
    BOOL result = [STWalletAPI sendReq:loginReq];
    
    NSLog(@"登录调用---%d",result);
}
-(void)logout{
    STWalletLogoutReq * logout = [STWalletLogoutReq new];
    BOOL result = [STWalletAPI sendReq:logout];
    NSLog(@"退出调用---%d",result);
}
#pragma mark >_<! 👉🏻 🐷Lazy loading🐷
#pragma mark >_<! 👉🏻 🐷Init SubViews🐷

-(void)loadDefaultsSetting{
    
}
-(void)initSubViews{
    UIButton * login = [[UIButton alloc]initWithFrame:CGRectMake(130, 100, 150, 30)];
    [login setTitle:@"登录" forState:UIControlStateNormal];
    [login setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    [login addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:login];
    
    UIButton * transfer = [[UIButton alloc]initWithFrame:CGRectMake(130, 150, 150, 30)];
    [transfer setTitle:@"转账" forState:UIControlStateNormal];
    [transfer setTitleColor:[UIColor purpleColor] forState:UIControlStateNormal];
    [transfer addTarget:self action:@selector(transfer) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:transfer];
    
    UIButton * cusaction = [[UIButton alloc]initWithFrame:CGRectMake(130, 200, 150, 30)];
    [cusaction setTitle:@"自定义action" forState:UIControlStateNormal];
    [cusaction setTitleColor:[UIColor cyanColor] forState:UIControlStateNormal];
    [cusaction addTarget:self action:@selector(cusaction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cusaction];
    
    UIButton * logout = [[UIButton alloc]initWithFrame:CGRectMake(130, 250, 150, 30)];
    [logout setTitle:@"退出" forState:UIControlStateNormal];
    [logout setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [logout addTarget:self action:@selector(logout) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:logout];
}

@end
