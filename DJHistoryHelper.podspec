Pod::Spec.new do |s|

  s.name         = "DJHistoryHelper"
  s.version      = "0.0.1"
  s.summary      = "DJHistoryHelper supplies unitization of interface for iOS APP cache with sqlite、coredata and plist."
  s.description  = <<-DESC
                   DJHistoryHelper was used to supply unitization of interface for multiple cache ways.
                   DESC

  s.homepage     = "http://douzhongxu.com"
  s.license      = { :type => "MIT", :file => "LICENSE" }

  s.author             = { "Dokay" => "dokay.dou@gmail.com" }
  s.platform     = :ios, "6.0"

  s.source       = { :git => "https://github.com/Dokay/DJHistoryHelper.git", :tag => s.version.to_s }

  s.source_files  = "Classes", "DJComponentHistoryHelper/DJHistoryHelper/*.{h,m}"
  s.public_header_files = "DJComponentHistoryHelper/DJHistoryHelper/*.h"

  s.requires_arc = true
  s.library   = "sqlite3"

end