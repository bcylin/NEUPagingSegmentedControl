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

    CGRect frame = CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 44);
    NEUPagingSegmentedControl *segmentedControl = [[NEUPagingSegmentedControl alloc] initWithFrame:frame];
    segmentedControl.segmentTitles = @[@"A", @"B", @"C", @"D", @"E",];
    segmentedControl.delegate = self;
    [self.view addSubview:segmentedControl];
}

#pragma mark - NEUPagingSegmentedControlDelegate

- (void)pagingSegmentedControl:(NEUPagingSegmentedControl *)segmentedControl didSelectSegmentAtIndex:(NSInteger)index
{
    NSLog(@"%s \n[Line:%03d] index %d selected", __PRETTY_FUNCTION__, __LINE__, index);
}

@end
