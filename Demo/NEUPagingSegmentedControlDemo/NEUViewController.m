//
//  NEUViewController.m
//  NEUPagingSegmentedControlDemo
//
//  Created by Ben on 06/05/2014.
//  Copyright (c) 2014 bcylin. All rights reserved.
//

#import "NEUViewController.h"
#import "NEUPagingSegmentedControl.h"

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
    [self.view addSubview:segmentedControl];
}

@end
