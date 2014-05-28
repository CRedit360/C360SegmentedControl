//
//  C360SegmentedControlSegment.h
//  C360SegmentedControlDemo
//
//  Created by Simon Booth on 28/05/2014.
//  Copyright (c) 2014 CRedit360. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface C360SegmentedControlSegment : UIControl

@property (nonatomic) CGSize contentOffset;
@property (nonatomic) NSString *title;
@property (nonatomic) UIImage *image;

@property (nonatomic) UIColor *highlightColor;
@property (nonatomic) BOOL momentarilySelected;
@property (nonatomic) NSDate *lastMomentarySelectionDate;

@property (nonatomic) BOOL firstRow;
@property (nonatomic) BOOL lastRow;
@property (nonatomic) BOOL firstColumn;
@property (nonatomic) BOOL lastColumn;

- (void)updateTintColors;

@end
