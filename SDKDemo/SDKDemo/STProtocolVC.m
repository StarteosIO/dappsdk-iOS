//
//  STProtocolVC.m
//  SDKDemo
//
//  Created by 圣光 on 2018/12/3.
//  Copyright © 2018年 圣光. All rights reserved.
//

#import "STProtocolVC.h"
#import <STWalletSDK/STWalletAPI.h>
@interface STProtocolVC ()
@property (weak, nonatomic) IBOutlet UITextField *authenticateText;

@end

@implementation STProtocolVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = NSStringFromClass([self class]);
}
- (IBAction)login:(id)sender {
    
    STWalletLoginReq *loginReq = [[STWalletLoginReq alloc] init];
    loginReq.protocol = STProtocol;
    loginReq.dappName = @"Demos";    
    BOOL result = [STWalletAPI sendReq:loginReq];
        NSLog(@"登录调用---%d",result);
}
- (IBAction)logout:(id)sender {
    STWalletLogoutReq * logout = [STWalletLogoutReq new];
    logout.protocol = STProtocol;
    BOOL result = [STWalletAPI sendReq:logout];
    NSLog(@"退出调用---%d",result);
}
- (IBAction)transfer:(id)sender {
    
    STWalletTransferReq * req = [[STWalletTransferReq alloc] init];
    req.protocol = STProtocol;
    
    /**STProtocol 协议 登录状态下可不传*/
    //    req.fromAddress = @"转出公钥";
    //    req.from = @"转出账户";
    
    
//    req.actor = STProtocolTransferActorServer;
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
    req.actor = 1;
    req.remarks = @"第三方用户的备注信息";
    req.notifyUrl = @"回调地址 服务器转账成功后通过此地址回调信息";
    BOOL result = [STWalletAPI sendReq:req];
    NSLog(@"转账调用---%d",result);
}
- (IBAction)cusaction:(id)sender {
    
    // 暂不可用
    
//        STWalletTransactionReq * transaction = [[STWalletTransactionReq alloc]init];
//    transaction.protocol = STProtocol;
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)authenticate:(id)sender {
    
    STWalletAuthenticate *  authenticate = [[STWalletAuthenticate alloc]init];
    authenticate.protocol = STProtocol;
    authenticate.from = @"lazyloadingg";
    authenticate.fromAddress = @"EOS6qsKUyr8Em5QHLUEhkoX1YjbJeWMSDf4fprZJwAgVMaFbkVJeV";
    authenticate.nonce = self.authenticateText.text;
    BOOL result = [STWalletAPI sendReq:authenticate];
    NSLog(@"登录调用---%d",result);
}

@end
