//
//  C360SegmentedControl.h
//  C360SegmentedControlDemo
//
//  Created by Simon Booth on 28/05/2014.
//  Copyright (c) 2014 CRedit360. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, C360SegmentedControlPackingAlgorithm)
{
    C360SegmentedControlPackingHorizontal,
    C360SegmentedControlPackingVertical,
    C360SegmentedControlPackingEvenDistribution,
    C360SegmentedControlPackingNextFit,
    C360SegmentedControlPackingBestFit
};

#define C360SegmentedControlNoSegment UISegmentedControlNoSegment

@interface C360SegmentedControl : UIControl

- (id)initWithItems:(NSArray *)items;
@property (nonatomic, getter=isMomentary) BOOL momentary;
@property (nonatomic, readonly) NSUInteger numberOfSegments;

@property (nonatomic) BOOL apportionsSegmentWidthsByContent;
@property (nonatomic) BOOL apportionsRowHeightsByContent;

- (void)insertSegmentWithTitle:(NSString *)title atIndex:(NSUInteger)segment animated:(BOOL)animated;
- (void)insertSegmentWithImage:(UIImage *)image  atIndex:(NSUInteger)segment animated:(BOOL)animated;
- (void)removeSegmentAtIndex:(NSUInteger)segment animated:(BOOL)animated;
- (void)removeAllSegments;

- (void)setTitle:(NSString *)title forSegmentAtIndex:(NSUInteger)segment;
- (NSString *)titleForSegmentAtIndex:(NSUInteger)segment;

- (void)setImage:(UIImage *)image forSegmentAtIndex:(NSUInteger)segment;
- (UIImage *)imageForSegmentAtIndex:(NSUInteger)segment;

- (void)setContentOffset:(CGSize)offset forSegmentAtIndex:(NSUInteger)segment;
- (CGSize)contentOffsetForSegmentAtIndex:(NSUInteger)segment;

- (void)setEnabled:(BOOL)enabled forSegmentAtIndex:(NSUInteger)segment;
- (BOOL)isEnabledForSegmentAtIndex:(NSUInteger)segment;

@property (nonatomic) NSInteger selectedSegmentIndex;

@property (nonatomic) UIColor *highlightColor;
@property (nonatomic) C360SegmentedControlPackingAlgorithm packingAlgorithm;

@end
