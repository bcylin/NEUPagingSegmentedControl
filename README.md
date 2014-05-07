NEUPagingSegmentedControl
=========================

A horizontal segmented control that works with UIScrollView.

* Indicates the corresponding segment as the scroll view scrolls.
* Scrolls to a page by selecting the segment title.

## Usage

```objc
[[NEUPagingSegmentedControl alloc] initWithFrame:CGRectMake(0, 0, 320, 44)
                                   segmentTitles:@[@"Title A", @"Title B", @"Title C"];
                                      scrollView:scrollView];
```

Delegate method (optional):

```objc
- (void)pagingSegmentedControl:(NEUPagingSegmentedControl *)segmentedControl didSelectSegmentAtIndex:(NSInteger)index;
```

## Requirements

NEUPagingSegmentedControl requires ARC with iOS 7 and above.

## Installation

Add files in `NEUPagingSegmentedControl` folder to an iOS project.
