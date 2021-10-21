Pod::Spec.new do |spec|
  spec.name         = 'NewPopMenu'
  spec.version      = '2.1.3'
  spec.license      = { :type => 'MIT', :file => "LICENSE" }
  spec.homepage     = 'https://github.com/CaliCastle/PopMenu'
  spec.authors      = { 'Cali Castle' => 'cali@calicastle.com' }
  spec.summary      = 'A fully customizable popup style menu'
  spec.source       = { :git => 'https://github.com/CaliCastle/PopMenu.git', :tag => 'v2.1.3' }
  spec.source_files = 'PopMenu/**/*.{h,swift}'

  spec.module_name = "PopMenu"
  spec.platform = :ios, "10.0"
  spec.ios.deployment_target = "10.0"
  spec.swift_version = '4.2'
  spec.requires_arc = true
  spec.frameworks  = "UIKit"
  spec.documentation_url = "https://calicastle.github.io/PopMenu"
end
