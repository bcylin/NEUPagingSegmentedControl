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
    CGContextClearRect(context, rect);

    // Draw background
    [self.backgroundColor setFill];
    CGContextFillRect(context, rect);

    if (self.borderType == NEUBorderTypeNone) {
        return;
    }

    // Draw borders
    [self.borderColor setStroke];
    CGFloat strokeWidth = 1 / [[UIScreen mainScreen] scale];

    CGContextSetShouldAntialias(context, NO);
    CGContextSetLineWidth(context, strokeWidth);

    if (self.borderType & NEUBorderTypeTop) {
        CGContextMoveToPoint(context, CGRectGetMinX(rect), CGRectGetMinY(rect) + strokeWidth);
        CGContextAddLineToPoint(context, CGRectGetMaxX(rect), CGRectGetMinY(rect) + strokeWidth);
        CGContextDrawPath(context, kCGPathStroke);
    }

    if (self.borderType & NEUBorderTypeRight) {
        CGContextMoveToPoint(context, CGRectGetMaxX(rect) - strokeWidth, CGRectGetMinY(rect));
        CGContextAddLineToPoint(context, CGRectGetMaxX(rect) - strokeWidth, CGRectGetMaxY(rect));
        CGContextDrawPath(context, kCGPathStroke);
    }

    if (self.borderType & NEUBorderTypeBottom) {
        CGContextMoveToPoint(context, CGRectGetMinX(rect), CGRectGetMaxY(rect));
        CGContextAddLineToPoint(context, CGRectGetMaxX(rect), CGRectGetMaxY(rect));
        CGContextDrawPath(context, kCGPathStroke);
    }

    if (self.borderType & NEUBorderTypeLeft) {
        CGContextMoveToPoint(context, CGRectGetMinX(rect), CGRectGetMaxY(rect));
        CGContextAddLineToPoint(context, CGRectGetMinX(rect), CGRectGetMinY(rect));
        CGContextDrawPath(context, kCGPathStroke);
    }
}

@end
