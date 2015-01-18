Pod::Spec.new do |s|
  s.name = 'NoNetworkViewController'
  s.version = '1.0.0'
  s.summary = 'View controller that covers app when network connection is lost. It removes itself when connection is regained'
  s.homepage = 'https://github.com/williamFalcon/NoNetworkViewController'
  s.license = 'MIT'
  s.author = { 'williamFalcon' => 'will@hacstudios.com' }
  s.social_media_url = 'https://twitter.com/_willfalcon'
  s.source = { :git => 'https://github.com/williamFalcon/NoNetworkViewController.git', :tag => "v#{s.version}" }
  s.source_files = 'WFHttp/**/*.{h,m}'
  s.public_header_files = 'WFHttp/Public/**/*.{h,m}'
  s.requires_arc = true
  s.platform = :ios, '7.0'
  s.dependency = 'Reachability'
end
