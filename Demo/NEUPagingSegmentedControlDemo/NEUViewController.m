//
//  NEUViewController.m
//  NEUPagingSegmentedControlDemo
//
//  Created by Ben on 06/05/2014.
//  Copyright (c) 2014 bcylin. All rights reserved.
//

#import "NEUViewController.h"
#import "NEUPagingSegmentedControl.h"

@interface NEUViewController () <NEUPagingSegmentedControlDelegate>

@end

@implementation NEUViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        self.title = @"NEUPagingSegmentedControl";
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    return self;
}

- (void)loadView
{
    [super loadView];

    NSArray *segments = @[@"0.2 Gray", @"0.3 Gray", @"0.4 Gray", @"0.5 Gray"];
    CGSize pageSize = self.view.bounds.size;

    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    scrollView.contentSize = CGSizeMake(pageSize.width * [segments count], pageSize.height);
    [self.view addSubview:scrollView];

    [segments enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:[obj floatValue]];
        view.frame = (CGRect) {
            .origin.x = pageSize.width * idx,
            .origin.y = 0,
            .size = pageSize
        };
        [scrollView addSubview:view];
    }];

    CGRect frame = CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 44);
    NEUPagingSegmentedControl *segmentedControl = [[NEUPagingSegmentedControl alloc] initWithFrame:frame];
    segmentedControl.segmentTitles = segments;
    segmentedControl.scrollView = scrollView;
    segmentedControl.delegate = self;
    [self.view addSubview:segmentedControl];
}

#pragma mark - NEUPagingSegmentedControlDelegate

- (void)pagingSegmentedControl:(NEUPagingSegmentedControl *)segmentedControl didSelectSegmentAtIndex:(NSInteger)index
{
    NSLog(@"%s \n[Line:%03d] index %d selected", __PRETTY_FUNCTION__, __LINE__, index);
}

@end
