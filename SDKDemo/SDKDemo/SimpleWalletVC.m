//
//  SimpleWalletVC.m
//  SDKDemo
//
//  Created by 圣光 on 2018/12/3.
//  Copyright © 2018年 圣光. All rights reserved.
//

#import "SimpleWalletVC.h"
#import <STWalletSDK/STWalletAPI.h>
@interface SimpleWalletVC ()

@end

@implementation SimpleWalletVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = NSStringFromClass([self class]);
    
}
- (IBAction)login:(id)sender {
    STWalletLoginReq *loginReq = [[STWalletLoginReq alloc] init];
    // 公链标识
    loginReq.blockchain = @"eosio";   // eosio、eosforce、ethereum
    // DApp信息
    loginReq.dappIcon = @"https://newdex.io/static/logoicon.png";
    loginReq.dappName = @"Demos";
    // DApp Server
    loginReq.uuID = @"web-7c2ab24b-ded9-42e0-36d6-f37bc498cf78";
    loginReq.loginUrl = @"https://newdex.io/api/account/walletVerify";
    loginReq.expired = [NSNumber numberWithLong:([NSDate date].timeIntervalSince1970 + 60)];
    loginReq.loginMemo = @"Memo";
    NSLog(@"%@", loginReq);
    [STWalletAPI sendReq:loginReq];

}
- (IBAction)transfer:(id)sender {
    STWalletTransferReq * req = [[STWalletTransferReq alloc] init];
    req.dappName = @"myDApp";
    req.dappIcon = nil;
    req.blockchain = @"eosio";
    req.action = @"transfer";
    //此处账号为登录后获取到的信息  demo写固定值仅作为参考
    req.from = @"lazyloadingg";
    req.to = @"zijin.x";
    req.amount = @"0.0001";
    req.contract = @"eosio.token";
    req.symbol = @"EOS";
    req.precision = @(4);
    req.dappData = @"测试转账";
    req.desc = @"转账操作";
    req.expired = [NSNumber numberWithLong:([NSDate date].timeIntervalSince1970 + 60)];
    [STWalletAPI sendReq:req];

}
- (IBAction)cusaction:(id)sender {
    NSDictionary * action = @{@"code": @"eosio.token",@"action": @"transfer",@"binargs":@"00000"};
    
    STWalletTransactionReq * reqest = [[STWalletTransactionReq alloc] init];
    reqest.from = @"strarteosbaba";
    reqest.actions = @[action];
    reqest.desc = @"自定义action";
    reqest.expired = [NSNumber numberWithLong:([NSDate date].timeIntervalSince1970 + 60)];
    [STWalletAPI sendReq:reqest];

}


@end
