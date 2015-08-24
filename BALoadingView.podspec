#
# Be sure to run `pod lib lint BALoadingView.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "BALoadingView"
  s.version          = "0.1.0"
  s.summary          = "A UIView with loading animations."

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!  
  s.description      = <<-DESC
                          A UIView that offers several loading animations.
                       DESC

  s.homepage        = "https://github.com/antiguab/BALoadingView"
  s.screenshots     = "https://github.com/antiguab/BALoadingView/blob/master/readmeAssets/screenshot1.png?raw=true","https://github.com/antiguab/BALoadingView/blob/master/readmeAssets/screenshot2.png?raw=true","https://github.com/antiguab/BALoadingView/blob/master/readmeAssets/screenshot3.png?raw=true"
  s.license          = 'MIT'
  s.author           = { "Bryan Antigua" => "antigua.b@gmail.com" }
  s.source           = { :git => "https://github.com/antiguab/BALoadingView.git", :tag => s.version.to_s }

  s.platform     = :ios, '8.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'
  s.resource_bundles = {
    'BALoadingView' => ['Pod/Assets/*.png']
  }

  s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'UIKit'
end
