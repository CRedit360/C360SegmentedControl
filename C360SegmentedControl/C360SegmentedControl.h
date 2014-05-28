//
//  C360SegmentedControl.h
//  C360SegmentedControlDemo
//
//  Created by Simon Booth on 28/05/2014.
//  Copyright (c) 2014 CRedit360. All rights reserved.
//

#import <UIKit/UIKit.h>

// see http://cgi.csc.liv.ac.uk/~epa/surveyhtml.html
typedef NS_ENUM(NSInteger, C360SegmentedControlPackingAlgorithm)
{
    C360SegmentedControlNextFitPreserveOrdering,
    C360SegmentedControlBestFitDecreasingHeight
};

#define C360SegmentedControlNoSegment UISegmentedControlNoSegment

@interface C360SegmentedControl : UIControl

- (id)initWithItems:(NSArray *)items;
@property (nonatomic, getter=isMomentary) BOOL momentary;
@property (nonatomic, readonly) NSUInteger numberOfSegments;

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
