NEUPagingSegmentedControl
=========================

[![Build Status](https://travis-ci.org/bcylin/NEUPagingSegmentedControl.svg?branch=release/0.1.0)](https://travis-ci.org/bcylin/NEUPagingSegmentedControl)

A horizontal segmented control that works with UIScrollView paging.

* Indicate the corresponding segment as the scroll view scrolls.
* Scroll to a page by selecting the segment title.
* Support device rotation.

![Screenshot](https://bcylin.github.io/NEUPagingSegmentedControl/img/screenshot.png)

## Usage

```objc
[[NEUPagingSegmentedControl alloc] initWithFrame:CGRectMake(0, 0, 320, 44)
                                   segmentTitles:@[@"Title 1", @"Title 2", @"Title 3"];
                                      scrollView:scrollView];
```

Delegate method (optional):

```objc
- (void)pagingSegmentedControl:(NEUPagingSegmentedControl *)segmentedControl didSelectSegmentAtIndex:(NSInteger)index;
```

## Requirements

NEUPagingSegmentedControl requires ARC with iOS 7 and above.

## Installation

* Install via [CocoaPods](http://guides.cocoapods.org/) by adding the following specification to `Podfile`.

```ruby
platform :ios, '7.0'

pod 'NEUPagingSegmentedControl', :git => 'http://github.com/bcylin/NEUPagingSegmentedControl.git'
```

or

* Add files in `NEUPagingSegmentedControl` folder to an iOS project.

## License

NEUPagingSegmentedControl is released under the MIT license. See [LICENSE.md](https://github.com/bcylin/NEUPagingSegmentedControl/blob/master/LICENSE.md) for more info.
