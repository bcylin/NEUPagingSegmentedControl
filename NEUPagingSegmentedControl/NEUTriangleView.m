//
//  NEUTriangleView.m
//  NEUPagingSegmentedControl
//
//  Created by Ben on 06/05/2014.
//  Copyright (c) 2014 bcylin. All rights reserved.
//

#import "NEUTriangleView.h"

@implementation NEUTriangleView

- (void)setInnerColor:(UIColor *)innerColor
{
    if (![_innerColor isEqual:innerColor]) {
        _innerColor = [innerColor copy];
        [self setNeedsDisplay];
    }
}

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
        self.opaque = NO;
        self.innerColor = [UIColor whiteColor];
        self.borderColor = [UIColor blackColor];
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextClearRect(context, self.bounds);

    [self.innerColor setFill];

    CGContextBeginPath(context);
    CGContextMoveToPoint(context, CGRectGetMinX(self.bounds), CGRectGetMinY(self.bounds));
    CGContextAddLineToPoint(context, CGRectGetMidX(self.bounds), CGRectGetMaxY(self.bounds));
    CGContextAddLineToPoint(context, CGRectGetMaxX(self.bounds), CGRectGetMinY(self.bounds));
    CGContextClosePath(context);
    CGContextFillPath(context);

    [self.borderColor setStroke];

    CGContextMoveToPoint(context, CGRectGetMinX(self.bounds), CGRectGetMinY(self.bounds));
    CGContextAddLineToPoint(context, CGRectGetMidX(self.bounds), CGRectGetMaxY(self.bounds));
    CGContextAddLineToPoint(context, CGRectGetMaxX(self.bounds), CGRectGetMinY(self.bounds));
    CGContextSetLineWidth(context, 1 / [[UIScreen mainScreen] scale]);
    CGContextDrawPath(context, kCGPathStroke);

    // Trim 1 pt off the border from the top
    [self.innerColor setStroke];

    CGContextMoveToPoint(context, CGRectGetMinX(self.bounds), CGRectGetMinY(self.bounds));
    CGContextAddLineToPoint(context, CGRectGetMaxX(self.bounds), CGRectGetMinY(self.bounds));
    CGContextSetLineWidth(context, 1);
    CGContextDrawPath(context, kCGPathStroke);
}

@end
