#
# Be sure to run `pod lib lint MGAutoLayoutWithX.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'MGAutoLayoutWithX'
  s.version          = '0.0.5'
  s.summary          = ' MG 自适应iphone x'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
                   自适应iphone x,自适应iphone x
                       DESC

  s.homepage         = 'https://github.com/spf-iOS/MGAutoLayoutWithX'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'spf' => 'spf_ios@163.com' }
  s.source           = { :git => 'https://github.com/spf-iOS/MGAutoLayoutWithX.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'MGAutoLayoutWithX/Classes/**/*'
  s.frameworks = 'UIKit', 'MapKit', 'WebKit'
  
  # s.resource_bundles = {
  #   'MGAutoLayoutWithX' => ['MGAutoLayoutWithX/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
