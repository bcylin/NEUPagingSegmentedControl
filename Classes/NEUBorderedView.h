//
//  NEUBorderedView.h
//  NEUPagingSegmentedControl
//
//  Draw a 1px border of specified colour in the clear-background UIView.
//
//  Created by Ben on 07/05/2014.
//  Copyright (c) 2014 bcylin. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_OPTIONS(NSInteger, NEUBorderType) {
    NEUBorderTypeNone   = 0,
    NEUBorderTypeTop    = 1 << 0,
    NEUBorderTypeRight  = 1 << 1,
    NEUBorderTypeBottom = 1 << 2,
    NEUBorderTypeLeft   = 1 << 3,
    NEUBorderTypeAllBorders = NEUBorderTypeTop | NEUBorderTypeRight | NEUBorderTypeBottom | NEUBorderTypeLeft
};

@interface NEUBorderedView : UIView

@property (nonatomic) NEUBorderType borderType;
@property (nonatomic, copy) UIColor *borderColor;

@end
