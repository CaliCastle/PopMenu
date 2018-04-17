Pod::Spec.new do |spec|
  spec.name         = 'NewPopMenu'
  spec.version      = '1.0.1'
  spec.license      = { :type => 'MIT', :file => "LICENSE" }
  spec.homepage     = 'https://github.com/CaliCastle/PopMenu'
  spec.authors      = { 'Cali Castle' => 'cali@calicastle.com' }
  spec.summary      = 'A cool and customizable menu action sheet for iOS'
  spec.source       = { :git => 'https://github.com/CaliCastle/PopMenu.git', :tag => 'v1.0.1' }
  spec.source_files = 'PopMenu/**/*.{h,swift}'

  spec.platform = :ios, "9.0"
  spec.ios.deployment_target = "9.0"
  spec.swift_version = '4.0'
  spec.requires_arc = true
  spec.frameworks  = "UIKit"
  spec.documentation_url = "https://calicastle.github.io/PopMenu"

end
