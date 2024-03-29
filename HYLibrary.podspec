#
# Be sure to run `pod lib lint HYLibrary.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'HYLibrary'
  s.version          = '0.1.0'
  s.summary          = '快速开发库'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/hillyoung/HYLibrary'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'hillyoung' => '1666487339@qq.com' }
  s.source           = { :git => 'https://github.com/hillyoung/HYLibrary.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.platform = :ios
  s.ios.deployment_target = '9.0'

  s.ios.source_files = 'HYLibrary/Classes/*.h'
  
  # s.resource_bundles = {
  #   'HYLibrary' => ['HYLibrary/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
    s.dependency 'Masonry'
    s.dependency 'YYModel'
    s.dependency 'MGJRouter'
  
  s.subspec 'Basic' do |ss|
    ss.source_files = 'HYLibrary/Classes/Basic/**/*'
  end
  s.subspec 'Category' do |ss|
    ss.source_files = 'HYLibrary/Classes/Category/**/*'
  end
  s.subspec 'FormProgram' do |ss|
    ss.source_files = 'HYLibrary/Classes/FormProgram/**/*'
  end
  s.subspec 'Map' do |ss|
    ss.source_files = 'HYLibrary/Classes/Map/**/*'
  end
  s.subspec 'Router' do |ss|
    ss.source_files = 'HYLibrary/Classes/Router/**/*'
  end
  s.subspec 'Utility' do |ss|
    ss.source_files = 'HYLibrary/Classes/Utility/**/*'
  end
  
end
