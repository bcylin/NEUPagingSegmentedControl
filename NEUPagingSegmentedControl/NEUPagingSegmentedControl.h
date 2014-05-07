//
//  NEUPagingSegmentedControl.h
//  NEUPagingSegmentedControl
//
//  Created by Ben on 06/05/2014.
//  Copyright (c) 2014 bcylin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NEUPagingSegmentedControl;

@protocol NEUPagingSegmentedControlDelegate <NSObject>
@optional
- (void)pagingSegmentedControl:(NEUPagingSegmentedControl *)segmentedControl didSelectSegmentAtIndex:(NSInteger)index;
@end


@interface NEUPagingSegmentedControl : UIView

@property (nonatomic, assign, readonly) NSUInteger currentIndex;
@property (nonatomic, weak) id<NEUPagingSegmentedControlDelegate> delegate;

// Set up paging segments with given titles
@property (nonatomic, copy) NSArray *segmentTitles;

// Assign the scroll view that corresponds to the paging indicator
@property (nonatomic, strong) UIScrollView *scrollView;

// Component colours
@property (nonatomic, copy) UIColor *backgroundColor;
@property (nonatomic, copy) UIColor *borderColor;
@property (nonatomic, copy) UIColor *segmentTitleColor;
@property (nonatomic, copy) UIColor *selectedSegmentTitleColor;

@end
