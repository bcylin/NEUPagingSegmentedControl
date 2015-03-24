//
//  NEUBorderedView.m
//  NEUPagingSegmentedControl
//
//  Created by Ben on 07/05/2014.
//  Copyright (c) 2014 bcylin. All rights reserved.
//

#import "NEUBorderedView.h"

@implementation NEUBorderedView

- (void)setBorderColor:(UIColor *)borderColor
{
    if (![_borderColor isEqual:borderColor]) {
        _borderColor = [borderColor copy];
        [self setNeedsDisplay];
    }
}

#pragma mark - UIView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        self.borderColor = [UIColor blackColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextClearRect(context, self.bounds);

    // Draw background
    [self.backgroundColor setFill];
    CGContextFillRect(context, self.bounds);

    if (self.borderType == NEUBorderTypeNone) {
        return;
    }

    // Draw borders
    [self.borderColor setStroke];
    CGFloat strokeWidth = 1 / [[UIScreen mainScreen] scale];

    CGContextSetShouldAntialias(context, NO);
    CGContextSetLineWidth(context, strokeWidth);

    if (self.borderType & NEUBorderTypeTop) {
        CGContextMoveToPoint(context, CGRectGetMinX(self.bounds), CGRectGetMinY(self.bounds) + strokeWidth);
        CGContextAddLineToPoint(context, CGRectGetMaxX(self.bounds), CGRectGetMinY(self.bounds) + strokeWidth);
        CGContextDrawPath(context, kCGPathStroke);
    }

    if (self.borderType & NEUBorderTypeRight) {
        CGContextMoveToPoint(context, CGRectGetMaxX(self.bounds) - strokeWidth, CGRectGetMinY(self.bounds));
        CGContextAddLineToPoint(context, CGRectGetMaxX(self.bounds) - strokeWidth, CGRectGetMaxY(self.bounds));
        CGContextDrawPath(context, kCGPathStroke);
    }

    if (self.borderType & NEUBorderTypeBottom) {
        CGContextMoveToPoint(context, CGRectGetMinX(self.bounds), CGRectGetMaxY(self.bounds));
        CGContextAddLineToPoint(context, CGRectGetMaxX(self.bounds), CGRectGetMaxY(self.bounds));
        CGContextDrawPath(context, kCGPathStroke);
    }

    if (self.borderType & NEUBorderTypeLeft) {
        CGContextMoveToPoint(context, CGRectGetMinX(self.bounds), CGRectGetMaxY(self.bounds));
        CGContextAddLineToPoint(context, CGRectGetMinX(self.bounds), CGRectGetMinY(self.bounds));
        CGContextDrawPath(context, kCGPathStroke);
    }
}

@end
