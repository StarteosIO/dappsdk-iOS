# Starteos NativeSDK 



## 集成
### 手动集成
下载STWalletSDK Demo,将`STWalletSDK.framework`文件加入你的工程







### 配置

##### 添加白名单
```objectivec
<key>LSApplicationQueriesSchemes</key>
<array>
	<string>starteoswallet</string>
</array>
```

##### 注册URL Schemes

```objectivec
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [STWalletAPI registerAppURLSchemes:@"STWallet"];//你的应用的Schemes
    return YES;
}
```


##### 在AppDelegate中接收回调数据

```objectivec
-(BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options{

    BOOL result = [STWalletAPI handleURL:url result:^(STWalletResp *resq) {
        NSLog(@"解析结果对象-->\n%@--->\n%@",resq,resq.data);
        @try {
            //处理
        } @catch (NSException *exception) {
            NSLog(@"error--->%@",exception);
        } @finally {}
    }];
    return YES;
}

```

## 错误码
```
 10000 -> 成功
-10003 -> params错误
-10004 -> 用户取消了操作
-10005 -> 当前没有钱包
-10006 -> 网络错误
-10007 -> 交易失败
-10008 -> 没有找到转出的钱包
-10009 -> 没有安装Starteos钱包
-10011 -> 暂不支持
```



## 使用说明

### STProtocol协议用法：

#### 登录

> 调用：

```objectivec

    STWalletLoginReq *loginReq = [[STWalletLoginReq alloc] init];
    loginReq.currentProtocol = STProtocol;
    loginReq.dappName = @"DAppName";//第三方登录者
    BOOL result = [STWalletAPI sendReq:loginReq]; 
    
```


> 结果: 

```objectivec
{
    accountAddress = EOS6qsKUyr8Em5QHLUEhkoX1YjbJeWMSDf4fprZJwAgVMaFbkVJeV;
    accountName = lazyloadingg;
}
```

#### 身份验证

> 调用:

```objectivec
    STWalletAuthenticate *  authenticate = [[STWalletAuthenticate alloc]init];
    authenticate.currentProtocol = STProtocol;
    authenticate.from = @"验证账户名";
    authenticate.fromAddress = @"验证账户公钥";
    authenticate.nonce = self.authenticateText.text;
    BOOL result = [STWalletAPI sendReq:authenticate];
```

> 结果:

```objectivec
{
    signature = "SIG_K1_KBFEo8bVfzy78NdDkDpdAnWJKcqzjaLvafsg3m2STzCYUHDV5wfM3pZQ1txTzz5f3rc3bQUoQDGvcsUafZVziw9G5YEW32";
}
```

#### 退出登录
> 调用:

```objectivec
    STWalletLogoutReq * logout = [STWalletLogoutReq new];
    logout.currentProtocol = STProtocol;
    BOOL result = [STWalletAPI sendReq:logout];

```


#### 转账

**钱包直接转账**

> 调用:

```objectivec
    STWalletTransferReq * req = [[STWalletTransferReq alloc] init];
    req.currentProtocol = STProtocol;
    
    /**登录状态下可不传*/
    req.fromAddress = @"转出公钥";
    req.from = @"转出账户"; 
    req.dappName = @"第三方应用";//转账发起者
    req.to = @"zijin.x";//转入账户
    req.contract = @"eosio.token";//合约地址
    req.amount = @"10.0000";//转账金额
    req.symbol = @"EOS";
    req.desc = @"转账描述";
	req.memo = @"转账备注";
    BOOL result = [STWalletAPI sendReq:req];
    
```

> 结果:

```objectivec
{
    processed =     {
        "action_traces" =         (
                        {
                "account_ram_deltas" =                 (
                );
                act =                 {
                    account = "eosio.token";
                    authorization =                     (
                                                {
                            actor = lazyloadingg;
                            permission = active;
                        }
                    );
                    data =                     {
                        from = lazyloadingg;
                        memo = "";
                        quantity = "0.0001 EOS";
                        to = "zijin.x";
                    };
                    "hex_data" = c0d874c9d0e8bf89000000a083e99efb010000000000000004454f530000000000;
                    name = transfer;
                };
                "block_num" = 28421099;
                "block_time" = "2018-11-23T09:37:00.500";
                console = "";
                "context_free" = 0;
                "cpu_usage" = 0;
                elapsed = 290;
                "inline_traces" =                 (
                                        {
                        "account_ram_deltas" =                         (
                        );
                        act =                         {
                            account = "eosio.token";
                            authorization =                             (
                                                                {
                                    actor = lazyloadingg;
                                    permission = active;
                                }
                            );
                            data =                             {
                                from = lazyloadingg;
                                memo = "";
                                quantity = "0.0001 EOS";
                                to = "zijin.x";
                            };
                            "hex_data" = c0d874c9d0e8bf89000000a083e99efb010000000000000004454f530000000000;
                            name = transfer;
                        };
                        "block_num" = 28421099;
                        "block_time" = "2018-11-23T09:37:00.500";
                        console = "";
                        "context_free" = 0;
                        "cpu_usage" = 0;
                        elapsed = 5;
                        "inline_traces" =                         (
                        );
                        "producer_block_id" = "";
                        receipt =                         {
                            "abi_sequence" = 2;
                            "act_digest" = 7265528ef84e682472f1416def2f2e77eff6f724e31f4e51d677d5a2fb6dbef0;
                            "auth_sequence" =                             (
                                                                (
                                    lazyloadingg,
                                    1119
                                )
                            );
                            "code_sequence" = 2;
                            "global_sequence" = 1971589802;
                            receiver = lazyloadingg;
                            "recv_sequence" = 881;
                        };
                        "total_cpu_usage" = 0;
                        "trx_id" = f65f6e107c599f42eea0621835472985ac39174ea5a08cd75d99e787efd7649a;
                    },
                                        {
                        "account_ram_deltas" =                         (
                        );
                        act =                         {
                            account = "eosio.token";
                            authorization =                             (
                                                                {
                                    actor = lazyloadingg;
                                    permission = active;
                                }
                            );
                            data =                             {
                                from = lazyloadingg;
                                memo = "";
                                quantity = "0.0001 EOS";
                                to = "zijin.x";
                            };
                            "hex_data" = c0d874c9d0e8bf89000000a083e99efb010000000000000004454f530000000000;
                            name = transfer;
                        };
                        "block_num" = 28421099;
                        "block_time" = "2018-11-23T09:37:00.500";
                        console = "";
                        "context_free" = 0;
                        "cpu_usage" = 0;
                        elapsed = 10;
                        "inline_traces" =                         (
                        );
                        "producer_block_id" = "";
                        receipt =                         {
                            "abi_sequence" = 2;
                            "act_digest" = 7265528ef84e682472f1416def2f2e77eff6f724e31f4e51d677d5a2fb6dbef0;
                            "auth_sequence" =                             (
                                                                (
                                    lazyloadingg,
                                    1120
                                )
                            );
                            "code_sequence" = 2;
                            "global_sequence" = 1971589803;
                            receiver = "zijin.x";
                            "recv_sequence" = 4;
                        };
                        "total_cpu_usage" = 0;
                        "trx_id" = f65f6e107c599f42eea0621835472985ac39174ea5a08cd75d99e787efd7649a;
                    }
                );
                "producer_block_id" = "";
                receipt =                 {
                    "abi_sequence" = 2;
                    "act_digest" = 7265528ef84e682472f1416def2f2e77eff6f724e31f4e51d677d5a2fb6dbef0;
                    "auth_sequence" =                     (
                                                (
                            lazyloadingg,
                            1118
                        )
                    );
                    "code_sequence" = 2;
                    "global_sequence" = 1971589801;
                    receiver = "eosio.token";
                    "recv_sequence" = 303372091;
                };
                "total_cpu_usage" = 0;
                "trx_id" = f65f6e107c599f42eea0621835472985ac39174ea5a08cd75d99e787efd7649a;
            }
        );
        "block_num" = 28421099;
        "block_time" = "2018-11-23T09:37:00.500";
        elapsed = 529;
        except = "";
        id = f65f6e107c599f42eea0621835472985ac39174ea5a08cd75d99e787efd7649a;
        "net_usage" = 128;
        "producer_block_id" = "";
        receipt =         {
            "cpu_usage_us" = 529;
            "net_usage_words" = 16;
            status = executed;
        };
        scheduled = 0;
    };
    "transaction_id" = f65f6e107c599f42eea0621835472985ac39174ea5a08cd75d99e787efd7649a;
}

```

**服务器执行转账**

> 调用

```objectivec
    STWalletTransferReq * req = [[STWalletTransferReq alloc] init];
    req.currentProtocol = STProtocol;
    
    /**登录状态下可不传*/
    req.fromAddress = @"转出公钥";
    req.from = @"转出账户"; 
    req.dappName = @"第三方应用";//转账发起者
    req.to = @"zijin.x";//转入账户
    req.contract = @"eosio.token";//合约地址
    req.amount = @"10.0000";//转账金额
    req.symbol = @"EOS";
    req.desc = @"转账描述";
    req.memo = @"转账备注";
    req.actor = STProtocolTransferActorServer;
    req.remarks = @"给服务器的备注信息";
    req.notifyUrl = @"回调地址 服务器转账成功后通过此地址回调信息";
    BOOL result = [STWalletAPI sendReq:req];

```




### SimpleWallet协议用法：
> 此Demo中出现数据仅做为开发参考用例 具体协议详情介绍参见[SimpleWallet](https://github.com/southex/SimpleWallet)

#### 登录

> 调用:
 
```objectivec
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

    [STWalletAPI sendReq:loginReq];
```

> 结果:

```objectivec
{
    action = login;
    currentProtocol = SimpleWallet;
    data = "授权成功";
    result = 1;
}

```

#### 转账

> 调用:

```objectivec
    STWalletTransferReq * req = [[STWalletTransferReq alloc] init];
    req.dappName = @"shaohong";
    req.dappIcon = nil;
    req.blockchain = @"eosio";
    req.action = @"transfer";
    //此处账号为登录后获取到的信息  demo写固定值仅作为参考
    req.from = @"lazyloadingg";
    req.to = @"zijin.x";
    req.amount = @"1.0000";
    req.contract = @"eosio.token";
    req.symbol = @"EOS";
    req.precision = @(4);
    req.dappData = @"测试转账";
    req.desc = @"这是个转账操作";
    req.expired = [NSNumber numberWithLong:([NSDate date].timeIntervalSince1970 + 60)];
    [STWalletAPI sendReq:req];
```

> 结果:

```objectivec
{
    action = transfer;
    currentProtocol = SimpleWallet;
    data =     {
        processed =         {
            "action_traces" =             (
                                {
                    "account_ram_deltas" =                     (
                    );
                    act =                     {
                        account = "eosio.token";
                        authorization =                         (
                                                        {
                                actor = lazyloadingg;
                                permission = owner;
                            }
                        );
                        data =                         {
                            from = lazyloadingg;
                            memo = "\U6d4b\U8bd5\U8f6c\U8d26";
                            quantity = "0.0001 EOS";
                            to = "zijin.x";
                        };
                        "hex_data" = c0d874c9d0e8bf89000000a083e99efb010000000000000004454f53000000000ce6b58be8af95e8bdace8b4a6;
                        name = transfer;
                    };
                    "block_num" = 30118546;
                    "block_time" = "2018-12-03T07:00:28.000";
                    console = "";
                    "context_free" = 0;
                    "cpu_usage" = 0;
                    elapsed = 379;
                    "inline_traces" =                     (
                                                {
                            "account_ram_deltas" =                             (
                            );
                            act =                             {
                                account = "eosio.token";
                                authorization =                                 (
                                                                        {
                                        actor = lazyloadingg;
                                        permission = owner;
                                    }
                                );
                                data =                                 {
                                    from = lazyloadingg;
                                    memo = "\U6d4b\U8bd5\U8f6c\U8d26";
                                    quantity = "0.0001 EOS";
                                    to = "zijin.x";
                                };
                                "hex_data" = c0d874c9d0e8bf89000000a083e99efb010000000000000004454f53000000000ce6b58be8af95e8bdace8b4a6;
                                name = transfer;
                            };
                            "block_num" = 30118546;
                            "block_time" = "2018-12-03T07:00:28.000";
                            console = "";
                            "context_free" = 0;
                            "cpu_usage" = 0;
                            elapsed = 17;
                            "inline_traces" =                             (
                            );
                            "producer_block_id" = "";
                            receipt =                             {
                                "abi_sequence" = 2;
                                "act_digest" = 80518c2e722a1eba0fa92acf32cec3be8ebd2d5530e1a6702c8591c809e5ee79;
                                "auth_sequence" =                                 (
                                                                        (
                                        lazyloadingg,
                                        1134
                                    )
                                );
                                "code_sequence" = 2;
                                "global_sequence" = 2405837055;
                                receiver = lazyloadingg;
                                "recv_sequence" = 912;
                            };
                            "total_cpu_usage" = 0;
                            "trx_id" = a7147f45c6aeab4d7626cfc25ff6ba50b7cf5fb4ce7b9ecdab3bebb9b493eb3f;
                        },
                                                {
                            "account_ram_deltas" =                             (
                            );
                            act =                             {
                                account = "eosio.token";
                                authorization =                                 (
                                                                        {
                                        actor = lazyloadingg;
                                        permission = owner;
                                    }
                                );
                                data =                                 {
                                    from = lazyloadingg;
                                    memo = "\U6d4b\U8bd5\U8f6c\U8d26";
                                    quantity = "0.0001 EOS";
                                    to = "zijin.x";
                                };
                                "hex_data" = c0d874c9d0e8bf89000000a083e99efb010000000000000004454f53000000000ce6b58be8af95e8bdace8b4a6;
                                name = transfer;
                            };
                            "block_num" = 30118546;
                            "block_time" = "2018-12-03T07:00:28.000";
                            console = "";
                            "context_free" = 0;
                            "cpu_usage" = 0;
                            elapsed = 23;
                            "inline_traces" =                             (
                            );
                            "producer_block_id" = "";
                            receipt =                             {
                                "abi_sequence" = 2;
                                "act_digest" = 80518c2e722a1eba0fa92acf32cec3be8ebd2d5530e1a6702c8591c809e5ee79;
                                "auth_sequence" =                                 (
                                                                        (
                                        lazyloadingg,
                                        1135
                                    )
                                );
                                "code_sequence" = 2;
                                "global_sequence" = 2405837056;
                                receiver = "zijin.x";
                                "recv_sequence" = 9;
                            };
                            "total_cpu_usage" = 0;
                            "trx_id" = a7147f45c6aeab4d7626cfc25ff6ba50b7cf5fb4ce7b9ecdab3bebb9b493eb3f;
                        }
                    );
                    "producer_block_id" = "";
                    receipt =                     {
                        "abi_sequence" = 2;
                        "act_digest" = 80518c2e722a1eba0fa92acf32cec3be8ebd2d5530e1a6702c8591c809e5ee79;
                        "auth_sequence" =                         (
                                                        (
                                lazyloadingg,
                                1133
                            )
                        );
                        "code_sequence" = 2;
                        "global_sequence" = 2405837054;
                        receiver = "eosio.token";
                        "recv_sequence" = 388796536;
                    };
                    "total_cpu_usage" = 0;
                    "trx_id" = a7147f45c6aeab4d7626cfc25ff6ba50b7cf5fb4ce7b9ecdab3bebb9b493eb3f;
                }
            );
            "block_num" = 30118546;
            "block_time" = "2018-12-03T07:00:28.000";
            elapsed = 705;
            except = "";
            id = a7147f45c6aeab4d7626cfc25ff6ba50b7cf5fb4ce7b9ecdab3bebb9b493eb3f;
            "net_usage" = 144;
            "producer_block_id" = "";
            receipt =             {
                "cpu_usage_us" = 705;
                "net_usage_words" = 18;
                status = executed;
            };
            scheduled = 0;
        };
        "transaction_id" = a7147f45c6aeab4d7626cfc25ff6ba50b7cf5fb4ce7b9ecdab3bebb9b493eb3f;
    };
    result = 1;
}

```







