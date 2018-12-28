
Pod::Spec.new do |s|

  s.name         = "VVCompositeButton"
  s.version      = "0.0.1"
  s.platform = :ios
  s.ios.deployment_target = '10.0'
  s.summary      = "powerful UIButton with additional buttons(twitter style)!"
  s.requires_arc = true

  s.homepage     = "https://github.com/volga-volga/VVCompositeButton"

  s.license = { :type => "MIT", :file => "LICENSE" }

  s.author             = { "Konstantin" => "n1kron92@gmail.com" }
  s.source       = { :git => "https://github.com/volga-volga/VVCompositeButton.git", :tag => "#{s.version}" }
  s.framework = "UIKit"

  s.source_files = "VVCompositeButton/**/*.{swift}"
  s.resources = "VVCompositeButton/**/*.{png,jpeg,jpg,storyboard,xib,xcassets}"
  s.swift_version = "4.2"

end
