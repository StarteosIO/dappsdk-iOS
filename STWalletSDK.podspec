

Pod::Spec.new do |s|

  s.name         = "STWalletSDK"
  s.version      = "1.0.1"
  s.summary      = "ST钱包原生集成SDK"
  s.description  = <<-DESC  
                  ST钱包iOS原生SDK，集成此SDK可调起ST钱包进行登录，转账等操作，且支持多种协议
                  DESC
  s.homepage     = "https://github.com/shengguangdaren/NativeSDK"
  #s.license     = { :type => "MIT", :file => "LICENSE"}
  s.license      = 'MIT'
  s.author       = { "lazyloading" => "lazyloading@163.com" }
  s.ios.deployment_target = "10.0"
  s.source       = { :git => "https://github.com/shengguangdaren/NativeSDK.git", :tag => s.version }
  s.source_files  =  "STWalletSDK/STWalletSDK/Classes/**/*.{h,m}"
  s.requires_arc = true


end
