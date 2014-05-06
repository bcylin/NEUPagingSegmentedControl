//
//  NEUPagingSegmentedControl.m
//  NEUPagingSegmentedControl
//
//  Created by Ben on 06/05/2014.
//  Copyright (c) 2014 bcylin. All rights reserved.
//

#import "NEUPagingSegmentedControl.h"
#import "NEUTriangleView.h"

static const CGFloat kDefaultIndicatorWidth = 12;
static const CGFloat kDefaultIndicatorHeight = 8;

@interface NEUPagingSegmentedControl ()
@property (nonatomic, assign, readwrite) NSUInteger currentIndex;
@property (nonatomic, strong) NSArray *segmentButtons;
@property (nonatomic, strong) NEUTriangleView *indicatorView;
@end

@implementation NEUPagingSegmentedControl

#pragma mark - Properties

- (void)setSegmentTitles:(NSArray *)segmentTitles
{
    if (![_segmentTitles isEqual:segmentTitles]) {
        _segmentTitles = [segmentTitles copy];
        NSMutableArray *buttons = [[NSMutableArray alloc] initWithCapacity:[_segmentTitles count]];
        for (NSString *title in _segmentTitles) {
            [buttons addObject:[self buttonWithTitle:title]];
        }
        self.segmentButtons = [buttons copy];
    }
}

- (void)setSegmentButtons:(NSArray *)segmentButtons
{
    if (_segmentButtons != segmentButtons) {
        for (UIButton *button in _segmentButtons) {
            // Remove existed buttons
            [button removeFromSuperview];
        }
        _segmentButtons = segmentButtons;
        [self layoutButtons:_segmentButtons];
        [self moveIndicatorToIndex:0 animated:NO];
    }
}

- (NEUTriangleView *)indicatorView
{
    if (!_indicatorView) {
        _indicatorView = [[NEUTriangleView alloc] init];
        _indicatorView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    }
    return _indicatorView;
}

#pragma mark - UIView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.clipsToBounds = NO;
        self.tintColor = [UIColor clearColor];
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin;
        self.indicatorView.frame = CGRectMake(0, frame.size.height, kDefaultIndicatorWidth, kDefaultIndicatorHeight);
        [self addSubview:self.indicatorView];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    // Reposition indicator to after rotation
    [self moveIndicatorToIndex:self.currentIndex animated:YES];
}

#pragma mark - Target Action

- (void)buttonSelected:(UIButton *)sender
{
    NSInteger index = [self.segmentButtons indexOfObject:sender];
    [self moveIndicatorToIndex:index animated:YES];
    if ([self.delegate conformsToProtocol:@protocol(NEUPagingSegmentedControlDelegate)] &&
        [self.delegate respondsToSelector:@selector(pagingSegmentedControl:didSelectSegmentAtIndex:)]) {
        [self.delegate pagingSegmentedControl:self didSelectSegmentAtIndex:index];
    }
}

#pragma mark - Private Methods

- (UIButton *)buttonWithTitle:(NSString *)title
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button setTitle:[title description] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blueColor] forState:UIControlStateSelected];
    [button addTarget:self action:@selector(buttonSelected:) forControlEvents:UIControlEventTouchUpInside];
    return button;
}

- (void)layoutButtons:(NSArray *)buttons
{
    if ([buttons count] == 0) {
        return;
    }

    for (NSInteger idx = 0, count = [buttons count]; idx < count; idx++) {
        UIButton *thisButton = buttons[idx];
        [thisButton setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self addSubview:thisButton];

        if (idx == 0) {
            continue;
        }

        [self addConstraint:[NSLayoutConstraint constraintWithItem:[buttons firstObject]
                                                         attribute:NSLayoutAttributeWidth
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:thisButton
                                                         attribute:NSLayoutAttributeWidth
                                                        multiplier:1
                                                          constant:0]];

        [self addConstraint:[NSLayoutConstraint constraintWithItem:[buttons firstObject]
                                                         attribute:NSLayoutAttributeHeight
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:thisButton
                                                         attribute:NSLayoutAttributeHeight
                                                        multiplier:1
                                                          constant:0]];

        [self addConstraint:[NSLayoutConstraint constraintWithItem:[buttons firstObject]
                                                         attribute:NSLayoutAttributeCenterY
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:thisButton
                                                         attribute:NSLayoutAttributeCenterY
                                                        multiplier:1
                                                          constant:0]];

        [self addConstraint:[NSLayoutConstraint constraintWithItem:buttons[idx - 1]
                                                         attribute:NSLayoutAttributeRight
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:thisButton
                                                         attribute:NSLayoutAttributeLeft
                                                        multiplier:1
                                                          constant:0]];
    }

    UIButton *firstButton = [buttons firstObject];
    UIButton *lastButton = [buttons lastObject];
    NSDictionary *viewDictionary = NSDictionaryOfVariableBindings(firstButton, lastButton);
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[firstButton]"
                                                                 options:kNilOptions
                                                                 metrics:nil
                                                                   views:viewDictionary]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[lastButton]|"
                                                                 options:kNilOptions
                                                                 metrics:nil
                                                                   views:viewDictionary]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[firstButton]|"
                                                                 options:kNilOptions
                                                                 metrics:nil
                                                                   views:viewDictionary]];
}

- (CGPoint)indicatorCenterAtIndex:(NSInteger)index
{
    NSInteger segmentsCount = MAX(1, [self.segmentButtons count]);
    CGFloat segmentWidth = CGRectGetWidth(self.bounds) / segmentsCount;
    return (CGPoint) {
        .x = floorf(segmentWidth / 2) + segmentWidth * index,
        .y = self.indicatorView.center.y
    };
}

- (void)moveIndicatorToIndex:(NSInteger)index animated:(BOOL)animated
{
    if (index < 0 || index >= [self.segmentTitles count]) {
        return;
    }

    self.currentIndex = index;
    CGPoint indicatorCenter = [self indicatorCenterAtIndex:index];

    __weak typeof(self)weakSelf = self;
    [UIView animateWithDuration:(animated ? 0.3 : 0) animations:^{
        weakSelf.indicatorView.center = indicatorCenter;
    } completion:^(BOOL finished) {
        [weakSelf.segmentButtons enumerateObjectsUsingBlock:^(UIButton *button, NSUInteger idx, BOOL *stop) {
            button.selected = (idx == index);
        }];
    }];
}

@end
