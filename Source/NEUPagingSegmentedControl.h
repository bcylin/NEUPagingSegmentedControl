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

/**
 The protocol defines the methods to interact with the `NEUPagingSegmentedControl`.
 */
@protocol NEUPagingSegmentedControlDelegate <NSObject>
@optional

/**
 Tells the delegate that the specific segment is selected.

 @param segmentedControl A paging segmented control object informing the delegate about the selected segment.
 @param index An index locating the selected segment.
 */
- (void)pagingSegmentedControl:(NEUPagingSegmentedControl *)segmentedControl
       didSelectSegmentAtIndex:(NSInteger)index;

@end


#pragma mark -


/**
 A horizontal segmented control that works with `UIScrollView` paging.
 */
@interface NEUPagingSegmentedControl : UIView

#pragma mark - Properties

/**
 The index of the segment that's currently highlighted.
 */
@property (nonatomic, assign, readonly) NSUInteger currentIndex;

/**
 The object that acts as the delegate of the paging segmented control.
 */
@property (nonatomic, weak) id<NEUPagingSegmentedControlDelegate> delegate;

/**
 Set up paging segments with an array of titles.
 */
@property (nonatomic, copy) NSArray *segmentTitles;

/**
 The scroll view that moves its contents along with the indicator.
 */
@property (nonatomic, strong) UIScrollView *scrollView;

/**
 The indicator view below the segment titles.
 */
@property (nonatomic, strong, readonly) UIView *indicatorView;

#pragma mark - UI Colors

/**
 The color of the bottom border.
 */
@property (nonatomic, copy) UIColor *borderColor;

/**
 The color of the vertical separators between segments.
 */
@property (nonatomic, copy) UIColor *buttonSeparatorColor;

/**
 The text color for each segment.
 */
@property (nonatomic, copy) UIColor *segmentTitleColor;

/**
 The text color for the highlighted segment.
 */
@property (nonatomic, copy) UIColor *selectedSegmentTitleColor;

#pragma mark - Initializer

/**
 *  Initializes a paging segmented control with given parameters.
 *
 *  @param frame      The frame rectangle for the view.
 *  @param titles     An array of NSString objects for segment titles.
 *  @param scrollView The scroll view that corresponds to the paging indicator.
 *
 *  @return An initialized paging segmented control.
 */
- (instancetype)initWithFrame:(CGRect)frame
                segmentTitles:(NSArray *)titles
                   scrollView:(UIScrollView *)scrollView;

@end
