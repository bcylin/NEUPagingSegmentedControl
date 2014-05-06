//
//  NEUPagingSegmentedControl.h
//  NEUPagingSegmentedControl
//
//  Created by Ben on 06/05/2014.
//  Copyright (c) 2014 bcylin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NEUPagingSegmentedControl : UIView

@property (nonatomic, assign, readonly) NSUInteger currentIndex;

// Set up paging segments with given titles
@property (nonatomic, copy) NSArray *segmentTitles;

@end
