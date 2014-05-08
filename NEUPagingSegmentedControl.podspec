Pod::Spec.new do |s|
  s.name          = "NEUPagingSegmentedControl"
  s.version       = "0.1.0"
  s.summary       = "A horizontal segmented control that works with UIScrollView.."
  s.description   = <<-DESC
                    * Indicates the corresponding segment as the scroll view scrolls.
                    * Scrolls to a page by selecting the segment title.
                    DESC

  s.homepage      = "https://github.com/bcylin/NEUPagingSegmentedControl"
  s.license       = { :type => "MIT", :file => "LICENSE.md" }
  s.author        = "bcylin"

  s.platform      = :ios, "7.0"
  s.source        = { :git => "https://github.com/bcylin/NEUPagingSegmentedControl.git", :tag => "v#{s.version}" }
  s.source_files  = "NEUPagingSegmentedControl/*.{h,m}"
  s.requires_arc  = true
end
