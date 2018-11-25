# Starteos NativeSDK 



## 集成
### 手动集成
下载STWalletSDK工程或Demo,将`STWalletSDK `文件夹拖入你的工程







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
    [STWalletAPI registerAppURLSchemes:@"STWallet"];
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

```



## 使用说明

### STProtocol协议用法：

#### 登录

> 调用：

```objectivec

STWalletLoginReq *loginReq = [[STWalletLoginReq alloc] init];
loginReq.dappName = @"Demo";//第三方登录者
    
BOOL result = [STWalletAPI sendReq:loginReq]; 
    
```


> 结果: 

```objectivec
{
    accountAddress = EOS6qsKUyr8Em5QHLUEhkoX1YjbJeWMSDf4fprZJwAgVMaFbkVJeV;
    accountName = lazyloadingg;
}
```

#### 转账

> 调用 

```objectivec
    STWalletTransferReq * req = [[STWalletTransferReq alloc] init];
    
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

> 结果

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


### SimpleWallet协议用法：







