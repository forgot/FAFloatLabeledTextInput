#
# Be sure to run `pod lib lint FAFloatLabeledTextInput.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'FAFloatLabeledTextInput'
  s.version          = '1.0'
  s.summary          = 'Floating Labels For UITextField And UITextView'
  s.swift_version = '4.2'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
Like it says on the box, FAFloatLabeledTextInput contains subclasses for UITextField and UITextView that allow for floating labels.

Also included are some UITableViewCell subclasses that wrap the UITextField and UITextView subclasses, with the latter allowing for automatic height adjustment so it can grow as you add new lines.
                       DESC

  s.homepage         = 'https://github.com/forgot/FAFloatLabeledTextInput'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'forgot' => 'jesse@apprhythmia.com' }
  s.source           = { :git => 'https://github.com/forgot/FAFloatLabeledTextInput.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/forgot'

  s.ios.deployment_target = '12.0'

  s.source_files = 'FAFloatLabeledTextInput/Classes/**/*'
  
end
