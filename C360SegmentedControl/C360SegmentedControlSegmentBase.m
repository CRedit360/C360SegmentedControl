//
//  C360SegmentedControlSegment.m
//  C360SegmentedControlDemo
//
//  Created by Simon Booth on 28/05/2014.
//  Copyright (c) 2014 CRedit360. All rights reserved.
//

#import "C360SegmentedControlSegmentBase.h"

@interface C360SegmentedControlSegmentBase ()

@end

@implementation C360SegmentedControlSegmentBase

@synthesize contentOffset = _contentOffset;
@synthesize title = _title;
@synthesize image = _image;

@synthesize highlightColor = _highlightColor;
@synthesize momentarilySelected = _momentarilySelected;
@synthesize lastMomentarySelectionDate = _lastMomentarySelectionDate;

@synthesize firstRow = _firstRow;
@synthesize lastRow = _lastRow;
@synthesize firstColumn = _firstColumn;
@synthesize lastColumn = _lastColumn;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        _contentEdgeInsets = UIEdgeInsetsMake(4, 4, 4, 4);
        
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
        _titleLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleFootnote];
        _titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        _titleLabel.numberOfLines = 0;
        [self addSubview:_titleLabel];
        
        _imageView = [[UIImageView alloc] init];
        _imageView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
        _imageView.contentMode = UIViewContentModeCenter;
        [self addSubview:_imageView];
        
        self.accessibilityTraits |= UIAccessibilityTraitButton;
    }
    return self;
}

- (BOOL)isAccessibilityElement
{
    return YES;
}

- (NSString *)accessibilityLabel
{
    return self.title.accessibilityLabel ?: self.title ?: self.image.accessibilityLabel;
}

- (UIColor *)highlightColor
{
    return _highlightColor ?: [UIColor whiteColor];
}

- (void)setHighlightColor:(UIColor *)highlightColor
{
    _highlightColor = highlightColor;
    [self setNeedsLayout];
}

- (NSString *)title
{
    return self.titleLabel.text;
}

- (void)setTitle:(NSString *)title
{
    if ((title != self.title) && ![title isEqual:self.title])
    {
        self.titleLabel.text = title;
        self.imageView.image = nil;
    }
}

- (UIImage *)image
{
    return self.imageView.image;
}

- (void)setImage:(UIImage *)image
{
    if ((image != self.image) && ![image isEqual:self.image])
    {
        if (image.renderingMode == UIImageRenderingModeAutomatic)
        {
            image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        }
        
        self.titleLabel.text = nil;
        self.imageView.image = image;
    }
}

- (void)setContentOffset:(CGSize)contentOffset
{
    _contentOffset = contentOffset;
    [self setNeedsLayout];
}

- (void)setFirstRow:(BOOL)firstRow
{
    _firstRow = firstRow;
    [self setNeedsLayout];
}

- (void)setLastRow:(BOOL)lastRow
{
    _lastRow = lastRow;
    [self setNeedsLayout];
}

- (void)setFirstColumn:(BOOL)firstColumn
{
    _firstColumn = firstColumn;
    [self setNeedsLayout];
}

- (void)setLastColumn:(BOOL)lastColumn
{
    _lastColumn = lastColumn;
    [self setNeedsLayout];
}

- (CGSize)sizeThatFits:(CGSize)size
{
    CGFloat horizontalPadding = self.contentEdgeInsets.left + self.contentEdgeInsets.right;
    CGFloat verticalPadding = self.contentEdgeInsets.left + self.contentEdgeInsets.right;
    
    CGSize contentSize = CGSizeZero;
    size.width -= horizontalPadding;
    size.height -= verticalPadding;
    
    if (self.title)
    {
        NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
        style.alignment = self.titleLabel.textAlignment;
        style.lineBreakMode = self.titleLabel.lineBreakMode;
        
        contentSize = [self.title boundingRectWithSize:size
                                               options:NSStringDrawingUsesLineFragmentOrigin
                                            attributes:@{ NSFontAttributeName           : self.titleLabel.font,
                                                          NSParagraphStyleAttributeName : style }
                                               context:nil].size;
    }
    else if (self.image)
    {
        contentSize = self.image.size;
    }
    else
    {
        return CGSizeZero;
    }
    
    return CGSizeMake(contentSize.width + horizontalPadding, contentSize.height + verticalPadding);
}

@end

@interface C360SegmentedControlShapeSegment ()

@property (nonatomic) CAShapeLayer *shapeLayer;

@end

@implementation C360SegmentedControlShapeSegment

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        _shapeLayer = [[CAShapeLayer alloc] init];
        [self.layer insertSublayer:_shapeLayer atIndex:0];
        self.layer.masksToBounds = NO;
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGRect contentBounds = self.bounds;
    contentBounds = UIEdgeInsetsInsetRect(contentBounds, self.contentEdgeInsets);
    contentBounds = CGRectOffset(contentBounds, self.contentOffset.width, self.contentOffset.height);
    
    self.titleLabel.frame = contentBounds;
    self.imageView.frame = contentBounds;
    
    CGFloat width = self.bounds.size.width, height = self.bounds.size.height;
    CGFloat lineWidth = 1;
    
    UIBezierPath *bezierPath = [[UIBezierPath alloc] init];
    
    CGFloat minX = lineWidth/2;
    CGFloat midX = width/2;
    CGFloat maxX = self.lastColumn ? width - lineWidth/2 : width + lineWidth/2;
    CGFloat minY = lineWidth/2;
    CGFloat maxY = self.lastRow ? height - lineWidth/2 : height + lineWidth/2;
    
    CGFloat radius = 4;
    if (radius > width/2) radius = width/2;
    if (radius > height/2) radius = height/2;
    
    [bezierPath moveToPoint:CGPointMake(midX, minY)];
    
    if (self.firstRow && self.lastColumn)
    {
        [bezierPath addLineToPoint:CGPointMake(maxX - radius, minY)];
        [bezierPath addArcWithCenter:CGPointMake(maxX - radius, minY + radius)
                              radius:radius
                          startAngle:3 * M_PI_2
                            endAngle:4 * M_PI_2
                           clockwise:YES];
    }
    else
    {
        [bezierPath addLineToPoint:CGPointMake(maxX, minY)];
    }
    
    if (self.lastRow && self.lastColumn)
    {
        [bezierPath addLineToPoint:CGPointMake(maxX, maxY - radius)];
        [bezierPath addArcWithCenter:CGPointMake(maxX - radius, maxY - radius)
                              radius:radius
                          startAngle:0 * M_PI_2
                            endAngle:1 * M_PI_2
                           clockwise:YES];
    }
    else
    {
        [bezierPath addLineToPoint:CGPointMake(maxX, maxY)];
    }
    
    if (self.lastRow && self.firstColumn)
    {
        [bezierPath addLineToPoint:CGPointMake(minX + radius, maxY)];
        [bezierPath addArcWithCenter:CGPointMake(minX + radius, maxY - radius)
                              radius:radius
                          startAngle:1 * M_PI_2
                            endAngle:2 * M_PI_2
                           clockwise:YES];
    }
    else
    {
        [bezierPath addLineToPoint:CGPointMake(minX, maxY)];
    }
    
    if (self.firstRow && self.firstColumn)
    {
        [bezierPath addLineToPoint:CGPointMake(minX, minY + radius)];
        [bezierPath addArcWithCenter:CGPointMake(minX + radius, minY + radius)
                              radius:radius
                          startAngle:2 * M_PI_2
                            endAngle:3 * M_PI_2
                           clockwise:YES];
    }
    else
    {
        [bezierPath addLineToPoint:CGPointMake(minX, minY)];
    }
    
    [bezierPath addLineToPoint:CGPointMake(midX, minY)];
    
    self.shapeLayer.lineWidth = lineWidth;
    self.shapeLayer.path = bezierPath.CGPath;
    
    [self updateTintColors];
}

- (void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    [self updateTintColors];
}

- (void)setMomentarilySelected:(BOOL)momentarilySelected
{
    [super setMomentarilySelected:momentarilySelected];
    [self updateTintColors];
}

- (void)tintColorDidChange
{
    [super tintColorDidChange];
    [self updateTintColors];
}

- (void)updateTintColors
{
    self.shapeLayer.strokeColor = self.tintColor.CGColor;
    
    if (self.selected || self.momentarilySelected)
    {
        self.shapeLayer.fillColor = self.tintColor.CGColor;
        self.titleLabel.textColor = self.highlightColor;
        self.imageView.tintColor = self.highlightColor;
    }
    else
    {
        self.shapeLayer.fillColor = nil;
        self.titleLabel.textColor = self.tintColor;
        self.imageView.tintColor = self.tintColor;
    }
    
    [self.shapeLayer setNeedsDisplay];
}

@end
