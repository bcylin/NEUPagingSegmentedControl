//
//  NEUHorizontalLine.m
//  NEUPagingSegmentedControl
//
//  Created by Ben on 07/05/2014.
//  Copyright (c) 2014 bcylin. All rights reserved.
//

#import "NEUHorizontalLine.h"

@implementation NEUHorizontalLine

- (void)setColor:(UIColor *)color
{
    if (![_color isEqual:color]) {
        _color = [color copy];
        [self setNeedsDisplay];
    }
}

#pragma mark - UIView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        self.color = [UIColor blackColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextClearRect(context, rect);
    CGContextSetShouldAntialias(context, NO);

    [self.color setStroke];

    CGContextMoveToPoint(context, CGRectGetMinX(rect), CGRectGetMaxY(rect));
    CGContextAddLineToPoint(context, CGRectGetMaxX(rect), CGRectGetMaxY(rect));
    CGContextSetLineWidth(context, 1 / [[UIScreen mainScreen] scale]);
    CGContextDrawPath(context, kCGPathStroke);
}

@end
