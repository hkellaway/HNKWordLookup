Pod::Spec.new do |s|
  s.name         = "HNKWordLookup"
  s.version      = "1.0"
  s.summary      = "Provides dictionary information about words."
  s.description  = <<-DESC
Provides dictionary information about words, such as definitions, pronunciations, random words, and word of the day.
DESC
  s.homepage     = "https://github.com/hkellaway/HNKWordLookup"
  # s.screenshots  = "www.example.com/screenshots_1.gif", "www.example.com/screenshots_2.gif"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author             = { "Harlan Kellaway" => "hello@harlankellaway.com" }
  s.source       = { :git => "https://github.com/hkellaway/HNKWordLookup.git", :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITER_USERNAME>'
  
  s.platform     = :ios, "7.0"
  s.requires_arc = true

  s.source_files  = "Pod/Classes/HNKWordLookup.h"

  s.subspec 'Models' do |ss|
    ss.source_files = 'Pod/Classes/Models/*.{h,m}'

  s.subspec 'Utility' do |ss|
    ss.source_files = 'Pod/Classes/Utility/*.{h,m}'

  # s.resources = 'Pod/Assets/*.png'  
  
  # s.public_header_files = "Classes/**/*.h"
  s.dependency "AFNetworking", "~> 2.5"
  s.dependency "Mantle", "~> 1.5"
end
