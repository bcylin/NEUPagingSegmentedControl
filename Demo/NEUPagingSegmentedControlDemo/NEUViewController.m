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
@property (nonatomic, strong) NEUPagingSegmentedControl *segmentedControl;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) NSArray *segments;
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
    [self customizeAppearance];

    self.scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    self.scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:self.scrollView];

    self.segments = @[@"0.2 Gray", @"0.3 Gray", @"0.4 Gray", @"0.5 Gray"];
    for (id segment in self.segments) {
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:[segment floatValue]];
        [self.scrollView addSubview:view];
    }

    CGRect frame = CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 44);
    self.segmentedControl = [[NEUPagingSegmentedControl alloc] initWithFrame:frame];
    self.segmentedControl.segmentTitles = self.segments;
    self.segmentedControl.scrollView = self.scrollView;
    self.segmentedControl.delegate = self;
    [self.view addSubview:self.segmentedControl];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    [self layoutScrollViewPages];
}

#pragma mark - NEUPagingSegmentedControlDelegate

- (void)pagingSegmentedControl:(NEUPagingSegmentedControl *)segmentedControl didSelectSegmentAtIndex:(NSInteger)index
{
    NSLog(@"%s \n[Line:%03d] index %d selected", __PRETTY_FUNCTION__, __LINE__, index);
}

#pragma mark - Private Methods

- (void)customizeAppearance
{
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:65/255.0 green:105/255.0 blue:225/255.0 alpha:1];
    self.navigationController.navigationBar.barStyle = UIStatusBarStyleLightContent;
}

- (void)layoutScrollViewPages
{
    CGSize pageSize = self.view.bounds.size;
    self.scrollView.contentSize = CGSizeMake(pageSize.width * [self.segments count], pageSize.height);
    [self.scrollView.subviews enumerateObjectsUsingBlock:^(UIView *view, NSUInteger idx, BOOL *stop) {
        view.frame = (CGRect) {
            .origin.x = pageSize.width * idx,
            .origin.y = 0,
            .size = pageSize
        };
    }];
    CGPoint contentOffset = CGPointMake(pageSize.width * self.segmentedControl.currentIndex, 0);
    [self.scrollView setContentOffset:contentOffset animated:NO];
}

@end
