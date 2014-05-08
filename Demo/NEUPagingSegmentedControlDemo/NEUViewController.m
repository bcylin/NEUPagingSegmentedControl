//
//  NEUViewController.m
//  NEUPagingSegmentedControlDemo
//
//  Created by Ben on 06/05/2014.
//  Copyright (c) 2014 bcylin. All rights reserved.
//

#import "NEUViewController.h"
#import "NEUPagingSegmentedControl.h"
#import "NEUBorderedView.h"

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

    CGRect slice, remainder;
    CGRectDivide(self.view.bounds, &slice, &remainder, 44, CGRectMinYEdge);

    self.scrollView = [[UIScrollView alloc] initWithFrame:remainder];
    self.scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.scrollView.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1];

    self.segments = @[@"Title 1", @"Title 2", @"Title 3", @"Title 4"];
    for (NSInteger i = 0, count = [self.segments count]; i < count; i++) {
        NEUBorderedView *view = [[NEUBorderedView alloc] init];
        view.borderType = NEUBorderTypeAllBorders;
        view.backgroundColor = [UIColor whiteColor];
        view.borderColor = [UIColor grayColor];
        [self.scrollView addSubview:view];
    }

    self.segmentedControl = [[NEUPagingSegmentedControl alloc] initWithFrame:slice];
    self.segmentedControl.segmentTitles = self.segments;
    self.segmentedControl.scrollView = self.scrollView;
    self.segmentedControl.delegate = self;

    [self.view addSubview:self.scrollView];
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
    NSLog(@"%s \n[Line:%03d] index %@ selected", __PRETTY_FUNCTION__, __LINE__, @(index));
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
    CGSize pageSize = self.scrollView.bounds.size;
    self.scrollView.contentSize = CGSizeMake(pageSize.width * [self.segments count], pageSize.height);
    [self.scrollView.subviews enumerateObjectsUsingBlock:^(UIView *view, NSUInteger idx, BOOL *stop) {
        CGRect pageFrame = (CGRect) {
            .origin.x = pageSize.width * idx,
            .origin.y = 0,
            .size = pageSize
        };
        view.frame = CGRectInset(pageFrame, 20, 20);
        [view setNeedsDisplay];
    }];
    CGPoint contentOffset = CGPointMake(pageSize.width * self.segmentedControl.currentIndex, 0);
    [self.scrollView setContentOffset:contentOffset animated:NO];
}

@end
