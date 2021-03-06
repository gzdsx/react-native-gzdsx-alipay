
Pod::Spec.new do |s|
  s.name         = "RNAlipay"
  s.version      = "1.0.0"
  s.summary      = "RNAlipay"
  s.description  = <<-DESC
                  RNAlipay
                   DESC
  s.homepage     = "https://github.com/gzdsx/react-native-gzdsx-alipay.git"
  s.license      = "MIT"
  # s.license      = { :type => "MIT", :file => "FILE_LICENSE" }
  s.author             = { "author" => "songdewei@163.com" }
  s.platform     = :ios, "7.0"
  s.source       = { :git => "https://github.com/gzdsx/react-native-gzdsx-alipay.git", :tag => "master" }
  s.source_files  = "**/*.{h,m}"
  s.requires_arc = true


	s.dependency "React"
    s.resource = 'AlipaySDK.bundle'
    s.vendored_frameworks = 'AlipaySDK.framework'
    #s.vendored_libraries = "libAlipaySDK.a"
    s.frameworks = "SystemConfiguration", "CoreTelephony", "QuartzCore", "CoreText", "CoreGraphics", "UIKit", "Foundation", "CFNetwork", "CoreMotion"
    s.library = "c++", "z"
end

