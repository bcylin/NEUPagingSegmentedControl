//
//  NEUPagingSegmentedControl.m
//  NEUPagingSegmentedControl
//
//  Created by Ben on 06/05/2014.
//  Copyright (c) 2014 bcylin. All rights reserved.
//

#import "NEUPagingSegmentedControl.h"

@interface NEUPagingSegmentedControl ()
@property (nonatomic, strong) NSArray *segmentButtons;
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
    }
}

#pragma mark - UIView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.clipsToBounds = NO;
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin;
    }
    return self;
}

#pragma mark - Private Methods

- (UIButton *)buttonWithTitle:(NSString *)title
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button setTitle:[title description] forState:UIControlStateNormal];
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

        thisButton.backgroundColor = (idx % 2 == 0) ? [UIColor grayColor] : [UIColor lightGrayColor];

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

@end
