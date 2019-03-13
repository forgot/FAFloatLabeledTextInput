#
# Be sure to run `pod lib lint FAFloatLabeledTextInput.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'FAFloatLabeledTextInput'
  s.version          = '1.0.2'
  s.summary          = 'Floating Labels For UITextField And UITextView'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
  Like it says on the box, FAFloatLabeledTextInput contains subclasses for UITextField and UITextView that allow for floating labels.\n\nAlso included are some UITableViewCell subclasses that wrap the UITextField and UITextView subclasses, with the latter allowing for automatic height adjustment so it can grow as you add new lines.
                         DESC

  s.homepage         = 'https://github.com/forgot/FAFloatLabeledTextInput'
  s.screenshots      = 'https://user-images.githubusercontent.com/2170669/54080457-b255ec00-42b5-11e9-85c7-2a89d5c8ff92.gif', 'https://user-images.githubusercontent.com/2170669/54080460-c26dcb80-42b5-11e9-89d2-340089101619.gif'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'forgot' => 'jesse@apprhythmia.com' }
  s.source           = { :git => 'https://github.com/forgot/FAFloatLabeledTextInput.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/forgot'
  s.swift_version    = '4.2'


  s.ios.deployment_target = '9.0'

  s.source_files = 'FAFloatLabeledTextInput/Classes/**/*'
  
  # s.resource_bundles = {
  #   'FAFloatLabeledTextInput' => ['FAFloatLabeledTextInput/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
