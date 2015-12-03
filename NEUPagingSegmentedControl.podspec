Pod::Spec.new do |s|
  s.name          = "NEUPagingSegmentedControl"
  s.version       = "0.3.0"
  s.summary       = "A horizontal segmented control that works with UIScrollView paging."
  s.screenshots   = "https://bcylin.github.io/NEUPagingSegmentedControl/img/screenshot.png"

  s.homepage      = "https://github.com/bcylin/NEUPagingSegmentedControl"
  s.license       = { type: "MIT", file: "LICENSE.md" }
  s.author        = "bcylin"

  s.platform      = :ios, "7.0"
  s.requires_arc  = true
  s.source        = { git: "https://github.com/bcylin/NEUPagingSegmentedControl.git", tag: "v#{s.version}" }
  s.source_files  = "Source/*.{h,m}"
  s.public_header_files = "Source/NEUPagingSegmentedControl.h"
end
