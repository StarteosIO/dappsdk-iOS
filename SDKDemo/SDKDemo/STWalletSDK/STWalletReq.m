//
//  STWalletReq.m
//  STWalletSDK
//
//  Created by 梁唐 on 2018/10/31.
//  Copyright © 2018 梁唐. All rights reserved.
//

#import "STWalletReq.h"


@implementation STWalletReq
-(instancetype)init{
    self = [super init];
    if (self) {
        _protocol = @"SimpleWallet";
        _version = @"1.0";
    }
    return self;
}

//-(NSString *)protocol{
//    if (self.currentProtocol == STProtocol) {
//        return @"STProtocol";
//    }else{
//        return @"SimpleWallet";
//    }
//}

-(void)setCurrentProtocol:(STWalletProtocol)currentProtocol{
    _currentProtocol = currentProtocol;
    if (currentProtocol == STProtocol) {
        _protocol = @"STProtocol";
    }else{
        _protocol = @"SimpleWallet";
    }
}

-(NSDictionary *)toParams{
    NSMutableDictionary *params = [NSMutableDictionary new];
    if (self.currentProtocol == STProtocol) {
        params[@"protocol"] = @"STProtocol";
    }else{
        params[@"protocol"] = @"SimpleWallet";
    }
   
    params[@"version"] = self.version;
    params[@"blockchain"] = self.blockchain;
    params[@"dappName"] = self.dappName;
    params[@"dappIcon"] = self.dappIcon;
    params[@"action"] = self.action;
    return params.copy;
}
@end


@implementation STWalletLoginReq
-(instancetype)init{
    self = [super init];
    if (self) {
        self.action = @"login";
    }
    return self;
}

-(NSDictionary *)toParams{
    NSMutableDictionary *params = [super toParams].mutableCopy;
    params[@"uuID"] = self.uuID;
    params[@"loginUrl"] = self.loginUrl;
    params[@"expired"] = self.expired;
    params[@"loginMemo"] = self.loginMemo;
    return params.copy;
}
@end

@implementation STWalletLogoutReq
-(instancetype)init{
    self = [super init];
    if (self) {
        self.action = @"logout";
    }
    return self;
}
@end

@implementation STWalletTransferReq
-(instancetype)init{
    self = [super init];
    if (self) {
        self.action = @"transfer";
    }
    return self;
}

-(NSDictionary *)toParams{
    NSMutableDictionary *params = [super toParams].mutableCopy;
    params[@"from"] = self.from;
    params[@"to"] = self.to;
    params[@"amount"] = self.amount;
    params[@"contract"] = self.contract;
    params[@"symbol"] = self.symbol;
    params[@"precision"] = self.precision;
    params[@"dappData"] = self.dappData;
    params[@"fromAddress"] = self.fromAddress;
    params[@"desc"] = self.desc;
    params[@"expired"] = self.expired;
    return params.copy;
}
@end

@implementation STWalletTransactionReq
-(instancetype)init{
    self = [super init];
    if (self) {
        self.action = @"transaction";
        self.isPush = YES;
    }
    return self;
}

-(NSDictionary *)toParams{
    NSMutableDictionary *params = [super toParams].mutableCopy;
    params[@"from"] = self.from;
    params[@"actions"] = self.actions;
    params[@"desc"] = self.desc;
    params[@"expired"] = self.expired;
    params[@"fromAddress"] = self.fromAddress;
    params[@"isPush"] = [NSString stringWithFormat:@"%d",self.isPush];
    NSMutableArray * actorArray = [NSMutableArray array];
    for (STSignAccount * model in self.actors) {
        NSDictionary * actorDic = [model toParams];
        if (actorDic) {
            [actorArray addObject:actorDic];
        }
    }
    params[@"actors"] = actorArray;
    return params.copy;
}
@end

@implementation STWalletReqSignature

-(NSDictionary *)toParams{
    NSMutableDictionary *params = [super toParams].mutableCopy;
    NSMutableArray * array = [NSMutableArray array];
    for (STSignAccount *account  in self.multiSign) {
        NSDictionary * dict = [account toParams];
        [array addObject:dict];
    }
    if (array.count > 0) {
        params[@"multiSign"] = array;
    }
    return params.copy;
}

@end

@implementation STSignAccount
-(NSDictionary *)toParams{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"actor"] = self.actor;
    params[@"permission"] = self.permission;
    return params.copy;
}

@end
