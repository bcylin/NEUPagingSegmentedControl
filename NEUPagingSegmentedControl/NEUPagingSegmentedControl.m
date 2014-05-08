//
//  NEUPagingSegmentedControl.m
//  NEUPagingSegmentedControl
//
//  Created by Ben on 06/05/2014.
//  Copyright (c) 2014 bcylin. All rights reserved.
//

#import "NEUPagingSegmentedControl.h"
#import "NEUBorderedView.h"
#import "NEUTriangleView.h"

static const CGFloat kDefaultIndicatorWidth = 12;
static const CGFloat kDefaultIndicatorHeight = 8;

static void * kNEUScrollViewObservationContext = &kNEUScrollViewObservationContext;
static NSString * const kNEUScrollViewContentOffsetKeyPath = @"contentOffset";

@interface NEUPagingSegmentedControl ()
@property (nonatomic, assign, readwrite) NSUInteger currentIndex;
@property (nonatomic, assign, getter = isMovingIndicatorWithButtonSelection) BOOL movingIndicatorWithButtonSelection;
@property (nonatomic, assign) CGFloat buttonWidth;
@property (nonatomic, strong) NSArray *segmentButtons;
@property (nonatomic, strong) NSMutableArray *buttonSeparators;
@property (nonatomic, strong) NEUBorderedView *bottomBorder;
@property (nonatomic, strong) NEUTriangleView *indicatorView;
@end

@implementation NEUPagingSegmentedControl

#pragma mark - Public Properties

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

- (void)setScrollView:(UIScrollView *)scrollView
{
    [_scrollView removeObserver:self
                     forKeyPath:kNEUScrollViewContentOffsetKeyPath
                        context:kNEUScrollViewObservationContext];

    _scrollView = scrollView;
    _scrollView.scrollsToTop = NO;
    _scrollView.pagingEnabled = YES;
    _scrollView.directionalLockEnabled = YES;
    _scrollView.alwaysBounceVertical = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;

    [_scrollView addObserver:self
                  forKeyPath:kNEUScrollViewContentOffsetKeyPath
                     options:NSKeyValueObservingOptionNew
                     context:kNEUScrollViewObservationContext];
}

- (void)setBackgroundColor:(UIColor *)backgroundColor
{
    [super setBackgroundColor:backgroundColor];
    self.indicatorView.innerColor = backgroundColor;
}

- (void)setBorderColor:(UIColor *)borderColor
{
    if (![_borderColor isEqual:borderColor]) {
        _borderColor = [borderColor copy];
        self.bottomBorder.borderColor= borderColor;
        self.indicatorView.borderColor = borderColor;
    }
}

- (void)setButtonSeparatorColor:(UIColor *)buttonSeparatorColor
{
    if (![_buttonSeparatorColor isEqual:buttonSeparatorColor]) {
        _buttonSeparatorColor = [buttonSeparatorColor copy];
        for (NEUBorderedView *view in self.buttonSeparators) {
            view.borderColor = buttonSeparatorColor;
        }
    }
}

- (void)setSegmentTitleColor:(UIColor *)segmentTitleColor
{
    if (![_segmentTitleColor isEqual:segmentTitleColor]) {
        _segmentTitleColor = segmentTitleColor;
        for (UIButton *button in self.segmentButtons) {
            [button setTitleColor:segmentTitleColor forState:UIControlStateNormal];
        }
    }
}

- (void)setSelectedSegmentTitleColor:(UIColor *)selectedSegmentTitleColor
{
    if (![_selectedSegmentTitleColor isEqual:selectedSegmentTitleColor]) {
        _selectedSegmentTitleColor = selectedSegmentTitleColor;
        for (UIButton *button in self.segmentButtons) {
            [button setTitleColor:selectedSegmentTitleColor forState:UIControlStateSelected];
        }
    }
}

#pragma mark - Private Properties

- (CGFloat)buttonWidth
{
    return (_buttonWidth > 0) ? _buttonWidth : CGRectGetWidth(self.bounds);
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
        [self moveIndicatorToIndex:0 animated:NO completion:nil];
    }
}

- (NSMutableArray *)buttonSeparators
{
    if (!_buttonSeparators) {
        _buttonSeparators = [[NSMutableArray alloc] init];
    }
    return _buttonSeparators;
}

- (NEUBorderedView *)bottomBorder
{
    if (!_bottomBorder) {
        _bottomBorder = [[NEUBorderedView alloc] init];
        _bottomBorder.borderType = NEUBorderTypeBottom;
        _bottomBorder.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    }
    return _bottomBorder;
}

- (NEUTriangleView *)indicatorView
{
    if (!_indicatorView) {
        _indicatorView = [[NEUTriangleView alloc] init];
        _indicatorView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    }
    return _indicatorView;
}

#pragma mark - Initializer

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.clipsToBounds = NO;
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin;

        self.bottomBorder.frame = CGRectMake(0, frame.size.height - 1, frame.size.width, 1);
        [self addSubview:self.bottomBorder];
        self.indicatorView.frame = CGRectMake(0, frame.size.height - 1, kDefaultIndicatorWidth, kDefaultIndicatorHeight);
        [self addSubview:self.indicatorView];

        // Default colours
        self.tintColor = [UIColor clearColor];
        self.backgroundColor = [UIColor whiteColor];
        self.borderColor = [UIColor grayColor];
        self.buttonSeparatorColor = [UIColor lightGrayColor];
        self.segmentTitleColor = [UIColor grayColor];
        self.selectedSegmentTitleColor = [UIColor blueColor];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame segmentTitles:(NSArray *)titles scrollView:(UIScrollView *)scrollView
{
    if (self = [self initWithFrame:frame]) {
        self.segmentTitles = titles;
        self.scrollView = scrollView;
    }
    return self;
}

#pragma mark - UIView

- (void)layoutSubviews
{
    [super layoutSubviews];
    // Reposition indicator to after rotation
    self.buttonWidth = CGRectGetWidth(self.bounds) / MAX(1, [self.segmentButtons count]);
    [self moveIndicatorToIndex:self.currentIndex animated:NO completion:nil];
}

- (void)dealloc
{
    self.scrollView = nil;
}

#pragma mark - Key-Value Observing

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if (context == kNEUScrollViewObservationContext && [keyPath isEqualToString:kNEUScrollViewContentOffsetKeyPath]) {
        if ([self isMovingIndicatorWithButtonSelection]) {
            return;
        }
        CGFloat scrollViewWidth = CGRectGetWidth(self.scrollView.bounds);
        CGPoint contentOffset = [change[NSKeyValueChangeNewKey] CGPointValue];

        // Shift indicator as scroll view scrolls
        CGFloat xOffsetFromCurrentIndex = contentOffset.x - CGRectGetWidth(self.scrollView.bounds) * self.currentIndex;
        [self shiftIndicatorByPercentage:(xOffsetFromCurrentIndex / CGRectGetWidth(self.scrollView.bounds))];

        NSInteger targetIndex = lroundf((float)contentOffset.x / scrollViewWidth);
        if (self.scrollView.bounds.origin.x == scrollViewWidth * targetIndex) {
            // Update section index when scroll view reaches target page
            [self moveIndicatorToIndex:targetIndex animated:NO completion:nil];
        }

    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

#pragma mark - Target Action

- (void)buttonSelected:(UIButton *)sender
{
    NSInteger index = [self.segmentButtons indexOfObject:sender];
    NSInteger scrollViewIndex = lroundf((float)self.scrollView.bounds.origin.x / CGRectGetWidth(self.scrollView.bounds));
    self.movingIndicatorWithButtonSelection = YES;
    __weak typeof(self)weakSelf = self;
    [self moveIndicatorToIndex:index animated:YES completion:^{
        weakSelf.movingIndicatorWithButtonSelection = NO;
    }];

    if (self.scrollView && index != scrollViewIndex) {
        CGPoint offset = CGPointMake(CGRectGetWidth(self.scrollView.bounds) * index, 0);
        [self.scrollView setContentOffset:offset animated:YES];
    }

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
    [button setTitleColor:self.segmentTitleColor forState:UIControlStateNormal];
    [button setTitleColor:self.selectedSegmentTitleColor forState:UIControlStateSelected];
    [button addTarget:self action:@selector(buttonSelected:) forControlEvents:UIControlEventTouchUpInside];
    return button;
}

- (void)layoutButtons:(NSArray *)buttons
{
    for (UIView *separator in self.buttonSeparators) {
        [separator removeFromSuperview];
    }
    [self.buttonSeparators removeAllObjects];

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

        // Add separator between buttons
        NEUBorderedView *separator = [[NEUBorderedView alloc] init];
        separator.borderType = NEUBorderTypeLeft;
        separator.borderColor = self.buttonSeparatorColor;
        [separator setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self.buttonSeparators addObject:separator];
        [self addSubview:separator];


        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(padding)-[separator]-(padding)-|"
                                                                     options:kNilOptions
                                                                     metrics:@{@"padding": @(10)}
                                                                       views:NSDictionaryOfVariableBindings(separator)]];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[separator(1)][thisButton]"
                                                                     options:kNilOptions
                                                                     metrics:nil
                                                                       views:NSDictionaryOfVariableBindings(separator, thisButton)]];
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
    return (CGPoint) {
        .x = floorf(self.buttonWidth / 2) + self.buttonWidth * index,
        .y = self.indicatorView.center.y
    };
}

- (void)moveIndicatorToIndex:(NSInteger)index animated:(BOOL)animated completion:(void (^)(void))completion
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
        if (completion) {
            completion();
        }
    }];
}

- (void)shiftIndicatorByPercentage:(float)offsetPercentage
{
    CGPoint indicatorCenter = [self indicatorCenterAtIndex:self.currentIndex];
    indicatorCenter.x += self.buttonWidth * offsetPercentage;
    self.indicatorView.center = indicatorCenter;

    // Hilight corresponding section
    NSInteger correspondingIndex = floorf(indicatorCenter.x / self.buttonWidth);
    [self.segmentButtons enumerateObjectsUsingBlock:^(UIButton *button, NSUInteger idx, BOOL *stop) {
        button.selected = (idx == correspondingIndex);
    }];
}

@end
