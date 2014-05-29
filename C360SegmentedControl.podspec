Pod::Spec.new do |s|
  s.name         = "C360SegmentedControl"
  s.version      = "1.1.1"
  s.summary      = "A UISegmentedControl replacement which supports multiple rows."
  s.description  = <<-DESC
                   A UISegmentedControl replacement which supports multiple rows.
                   This is useful when embedding segmented controls with large numbers
                   of segments in a fixed-width parent such as a table view.

                   The control is intended to be a drop-in replacement as far as possible.
                   Segments can be packed into rows in an order-preserving manner, or a 
                   more space-efficient manner which may reorder the segments.
                   DESC
  s.homepage     = "https://github.com/CRedit360/C360SegmentedControl"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author       = 'Simon Booth'
  s.platform     = :ios, "7.0"
  s.source       = { :git => "https://github.com/CRedit360/C360SegmentedControl.git", :tag => s.version.to_s }
  s.source_files  = "C360SegmentedControl", "C360SegmentedControl/**/*.{h,m}"
  s.requires_arc = true
end
