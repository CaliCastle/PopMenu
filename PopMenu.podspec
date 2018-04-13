Pod::Spec.new do |spec|
  spec.name         = 'PopMenu'
  spec.version      = '1.0.0'
  spec.license      = { :type => 'MIT', :file => "LICENSE" }
  spec.homepage     = 'https://github.com/CaliCastle/PopMenu'
  spec.authors      = { 'Cali Castle' => 'cali@calicastle.com' }
  spec.summary      = 'A pop-style floating menu for iOS apps'
  spec.source       = { :git => 'https://github.com/tonymillion/Reachability.git', :tag => 'v1.0.0' }
  spec.source_files = 'PopMenu/**/*.{h,swift}'
  spec.framework    = 'SystemConfiguration'

  spec.platform = :ios, "9.0"
  spec.ios.deployment_target = "9.0"
  spec.swift_version = '4.0'
  spec.requires_arc = true
  spec.frameworks  = "UIKit"

end
