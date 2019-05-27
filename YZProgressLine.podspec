Pod::Spec.new do |s|

   s.platform = :ios
   s.ios.deployment_target = '11.0'
   s.name = "YZProgressLine"
   s.summary = "YZProgressLine this is simple bar line to show progress"
   s.requires_arc = true

   s.version = "1.0.0"

   s.author = { "Yaroslav Zavyalov" => "yaroslavzavyalov1@gmail.com" }

   s.homepage = "https://github.com/YarZav/YZProgressLine"

   s.source = { :git => "https://github.com/YarZav/YZProgressLine.git", :tag => "#{s.version}"}

   s.framework = "UIKit"

   s.source_files = "YZProgressLine/**/*.{swift}"

   s.resources = "YZProgressLine/**/*.{png,jpeg,jpg,storyboard,xib}"
   s.resource_bundles = {
      'YZProgressLine' => ['YZProgressLine/**/*.xcassets']
   }
end
