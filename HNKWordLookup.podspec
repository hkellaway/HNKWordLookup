Pod::Spec.new do |s|
  s.name         = "HNKWordLookup"
  s.version      = "1.1.4"
  s.summary      = "Performs standard English-language dictionary queries, such as definitions, pronunciations, random words, and Word of the Day."
  s.homepage     = "http://cocoapods.org/pods/HNKWordLookup"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author       = { "Harlan Kellaway" => "hello@harlankellaway.com" }
  s.source       = { :git => "https://github.com/hkellaway/HNKWordLookup.git", :tag => s.version.to_s }
  
  s.platform     = :ios, "7.0"
  s.requires_arc = true

  s.source_files  = "Pod/Classes/HNKWordLookup.h", 'Pod/Classes/HNKLookup.{h,m}', 'Pod/Classes/HNKWordDefinition.{h,m}', 'Pod/Classes/HNKWordOfTheDay.{h,m}', 'Pod/Classes/HNKWordPronunciation.{h,m}'

  s.subspec 'Utility' do |ss|
    ss.source_files = 'Pod/Classes/HNKHttpSessionManager.{h,m}', 'Pod/Classes/NSDate+HNKAdditions.{h,m}'
  end

  # s.resources = 'Pod/Assets/*.png'  
  
  # s.public_header_files = "Classes/**/*.h"
  s.dependency "AFNetworking", "~> 2.5"
  s.dependency "Mantle", "~> 1.5"
end
