//
//  NEUPagingSegmentedControl.h
//  NEUPagingSegmentedControl
//
//  Created by Ben on 06/05/2014.
//  Copyright (c) 2014 bcylin. All rights reserved.
//

#import <UIKit/UIKit.h>

//! Project version number for NEUPagingSegmentedControl.
FOUNDATION_EXPORT double NEUPagingSegmentedControlVersionNumber;

//! Project version string for NEUPagingSegmentedControl.
FOUNDATION_EXPORT const unsigned char NEUPagingSegmentedControlVersionString[];


@class NEUPagingSegmentedControl;

@protocol NEUPagingSegmentedControlDelegate <NSObject>
@optional
- (void)pagingSegmentedControl:(NEUPagingSegmentedControl *)segmentedControl didSelectSegmentAtIndex:(NSInteger)index;
@end


@interface NEUPagingSegmentedControl : UIView

@property (nonatomic, assign, readonly) NSUInteger currentIndex;
@property (nonatomic, weak) id<NEUPagingSegmentedControlDelegate> delegate;

/// Set up paging segments with an array of titles.
@property (nonatomic, copy) NSArray *segmentTitles;

/// The scroll view that moves its contents along with the indicator.
@property (nonatomic, strong) UIScrollView *scrollView;

/// The indicator view below the segment titles.
@property (nonatomic, strong, readonly) UIView *indicatorView;

#pragma mark - Component Colors

@property (nonatomic, copy) UIColor *borderColor;
@property (nonatomic, copy) UIColor *buttonSeparatorColor;
@property (nonatomic, copy) UIColor *segmentTitleColor;
@property (nonatomic, copy) UIColor *selectedSegmentTitleColor;

/**
 *  Initializes a paging segmented control with given parameters.
 *
 *  @param frame      The frame rectangle for the view.
 *  @param titles     An array of NSString objects for segment titles.
 *  @param scrollView The scroll view that corresponds to the paging indicator.
 *
 *  @return An initialized paging segmented control.
 */
- (instancetype)initWithFrame:(CGRect)frame segmentTitles:(NSArray *)titles scrollView:(UIScrollView *)scrollView;

@end
