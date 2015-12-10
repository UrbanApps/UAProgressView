Pod::Spec.new do |s|
  s.name                  = "UAProgressView"
  s.version               = "0.1.3"
  s.summary               = "UAProgressView is a simple and lightweight, yet powerful animated circular progress view."
  s.homepage              = "https://github.com/UrbanApps/UAProgressView"
  s.author                = { "Matt Coneybeare" => "coneybeare@urbanapps.com" }
  s.license               = 'MIT'
  s.ios.deployment_target = '6.0'
  s.requires_arc          = true
  s.source                = { :git => "https://github.com/UrbanApps/UAProgressView.git", :tag => s.version.to_s }
  s.source_files          = "UAProgressView.{h,m}"
end