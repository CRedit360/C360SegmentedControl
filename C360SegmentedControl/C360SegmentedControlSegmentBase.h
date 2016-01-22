//
//  C360SegmentedControlSegment.h
//  C360SegmentedControlDemo
//
//  Created by Simon Booth on 28/05/2014.
//  Copyright (c) 2014 CRedit360. All rights reserved.
//

#import "C360SegmentedControl.h"

@interface C360SegmentedControlSegmentBase : UIControl <C360SegmentedControlSegmentProtocol>

@property (nonatomic) UIEdgeInsets contentEdgeInsets;
@property (nonatomic) UILabel *titleLabel;
@property (nonatomic) UIImageView *imageView;

@end

@interface C360SegmentedControlShapeSegment : C360SegmentedControlSegmentBase

@end
