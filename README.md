NEUPagingSegmentedControl
=========================

[![Build Status](https://travis-ci.org/bcylin/NEUPagingSegmentedControl.svg?branch=release/0.1.0)](https://travis-ci.org/bcylin/NEUPagingSegmentedControl)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)

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

### Install via [CocoaPods](http://guides.cocoapods.org/)

* Create a `Podfile` with the following specification and run `pod install`.

```ruby
platform :ios, '7.0'

pod 'NEUPagingSegmentedControl', :git => 'http://github.com/bcylin/NEUPagingSegmentedControl.git'
```

### Install via [Carthage](https://github.com/Carthage/Carthage)

* Compatible with iOS 8 and above.
* Create a `Cartfile` with the following specification and run `carthage bootstrap`.

```
github "bcylin/NEUPagingSegmentedControl" "develop"
```

* Follow the [instructions](https://github.com/Carthage/Carthage#if-youre-building-for-ios) to add the framework to an iOS project.

### Install Manually

* Copy files in the `Class` directory to an iOS project.

## License

NEUPagingSegmentedControl is released under the MIT license. See [LICENSE.md](https://github.com/bcylin/NEUPagingSegmentedControl/blob/master/LICENSE.md) for more info.
