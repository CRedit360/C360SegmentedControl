//
//  C360SegmentedControl.m
//  C360SegmentedControlDemo
//
//  Created by Simon Booth on 28/05/2014.
//  Copyright (c) 2014 CRedit360. All rights reserved.
//

#import "C360SegmentedControl.h"
#import "C360SegmentedControlSegment.h"

@interface C360SegmentedControl ()

@property (nonatomic, strong) NSMutableArray *items;
@property (nonatomic, strong) NSMutableArray *segments;

@property (nonatomic) CGFloat minimumRowHeight;

@end

@implementation C360SegmentedControl

- (id)initWithItems:(NSArray *)items
{
    self = [self init];
    if (self)
    {
        for (NSUInteger i = 0; i < items.count; i++)
        {
            [self insertSegmentWithItem:items[i] atIndex:i animated:NO];
        }
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self commonSetup];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        [self commonSetup];
    }
    return self;
}

- (void)commonSetup
{
    _items = [NSMutableArray array];
    _segments = [NSMutableArray array];
    _selectedSegmentIndex = C360SegmentedControlNoSegment;
    _minimumRowHeight = 29;
}

- (NSUInteger)numberOfSegments
{
    return self.items.count;
}

- (void)insertSegmentWithItem:(id)item atIndex:(NSUInteger)index animated:(BOOL)animated
{
    __block C360SegmentedControlSegment *newSegment;
    
    if (animated)
    {
        [UIView animateWithDuration:0.25 animations:^{
            
            [self insertSegmentWithItem:item atIndex:index animated:NO];
            newSegment = self.segments[index];
            newSegment.hidden = YES;
            [self layoutIfNeeded];
            
        } completion:^(BOOL finished) {
            
            newSegment.hidden = NO;
            
        }];
        
        return;
    }
    
    [self.items insertObject:item atIndex:index];
    
    if ((self.selectedSegmentIndex != C360SegmentedControlNoSegment) && (index <= self.selectedSegmentIndex))
    {
        // direct access to ivar to avoid side-effects
        _selectedSegmentIndex++;
        
        NSLog(@"Selected index is now %zd", self.selectedSegmentIndex);
    }
    
    newSegment = [[C360SegmentedControlSegment alloc] init];
    newSegment.title = [item isKindOfClass:[NSString class]] ? item : nil;
    newSegment.image = [item isKindOfClass:[UIImage class]] ? item : nil;
    newSegment.highlightColor = self.highlightColor;
    [self.segments insertObject:newSegment atIndex:index];
    [self insertSubview:newSegment atIndex:index];
    
    [newSegment addTarget:self action:@selector(segmentTouchDown:) forControlEvents:UIControlEventTouchDown];
    
    [self invalidateIntrinsicContentSize];
    [self setNeedsLayout];
}

- (void)insertSegmentWithTitle:(NSString *)title atIndex:(NSUInteger)index animated:(BOOL)animated
{
    [self insertSegmentWithItem:title atIndex:index animated:animated];
}

- (void)insertSegmentWithImage:(UIImage *)image atIndex:(NSUInteger)index animated:(BOOL)animated
{
    [self insertSegmentWithItem:image atIndex:index animated:animated];
}

- (void)removeSegmentAtIndex:(NSUInteger)index animated:(BOOL)animated
{
    if (index == self.selectedSegmentIndex)
    {
        self.selectedSegmentIndex = C360SegmentedControlNoSegment;
    }
    else if ((self.selectedSegmentIndex != C360SegmentedControlNoSegment) && (index < self.selectedSegmentIndex))
    {
        // direct access to ivar to avoid side-effects
        _selectedSegmentIndex--;
        
        NSLog(@"Selected index is now %zd", self.selectedSegmentIndex);
    }
    
    if (animated)
    {
        [UIView animateWithDuration:0.25 animations:^{
            
            C360SegmentedControlSegment *oldSegment = self.segments[index];
            oldSegment.title = nil;
            oldSegment.image = nil;
            [self setNeedsLayout];
            [self layoutIfNeeded];
            
        } completion:^(BOOL finished) {
            
            [self removeSegmentAtIndex:index animated:NO];
            
        }];
        return;
    }
    
    C360SegmentedControlSegment *oldSegment = self.segments[index];
    [oldSegment removeFromSuperview];
    
    [self.segments removeObjectAtIndex:index];
    [self.items removeObjectAtIndex:index];
    
    [self invalidateIntrinsicContentSize];
    [self setNeedsLayout];
}

- (void)removeAllSegments
{
    self.selectedSegmentIndex = C360SegmentedControlNoSegment;
    
    for (C360SegmentedControlSegment *oldSegment in self.segments)
    {
        [oldSegment removeFromSuperview];
    }
    
    [self.segments removeAllObjects];
    [self.items removeAllObjects];
    
    [self invalidateIntrinsicContentSize];
    [self setNeedsLayout];
}

- (void)setTitle:(NSString *)title forSegmentAtIndex:(NSUInteger)index
{
    NSString *oldTitle = [self titleForSegmentAtIndex:index];
    if ([oldTitle isEqual:title]) return;
    
    C360SegmentedControlSegment *segment = self.segments[index];
    segment.title = title;
    [self.items replaceObjectAtIndex:index withObject:title];
    
    [self invalidateIntrinsicContentSize];
    [self setNeedsLayout];
}

- (NSString *)titleForSegmentAtIndex:(NSUInteger)index
{
    id item = self.items[index];
    if ([item isKindOfClass:[NSString class]])
    {
        return item;
    }
    return nil;
}

- (void)setImage:(UIImage *)image forSegmentAtIndex:(NSUInteger)index
{
    UIImage *oldImage = [self imageForSegmentAtIndex:index];
    if ([oldImage isEqual:image]) return;
    
    C360SegmentedControlSegment *segment = self.segments[index];
    segment.image = image;
    [self.items replaceObjectAtIndex:index withObject:image];
    
    [self invalidateIntrinsicContentSize];
    [self setNeedsLayout];
}

- (UIImage *)imageForSegmentAtIndex:(NSUInteger)index
{
    id item = self.items[index];
    if ([item isKindOfClass:[UIImage class]])
    {
        return item;
    }
    return nil;
}

- (void)setContentOffset:(CGSize)offset forSegmentAtIndex:(NSUInteger)index
{
    C360SegmentedControlSegment *segment = self.segments[index];
    segment.contentOffset = offset;
    [self invalidateIntrinsicContentSize];
    [self setNeedsLayout];
}

- (CGSize)contentOffsetForSegmentAtIndex:(NSUInteger)index
{
    C360SegmentedControlSegment *segment = self.segments[index];
    return segment.contentOffset;
}

#pragma mark - Selection

- (void)setMomentary:(BOOL)momentary
{
    if (momentary && (self.selectedSegmentIndex != C360SegmentedControlNoSegment))
    {
        C360SegmentedControlSegment *segment = self.segments[self.selectedSegmentIndex];
        segment.selected = NO;
    }
    
    _momentary = momentary;
}

- (void)setEnabled:(BOOL)enabled forSegmentAtIndex:(NSUInteger)index
{
    C360SegmentedControlSegment *segment = self.segments[index];
    segment.enabled = enabled;
}

- (BOOL)isEnabledForSegmentAtIndex:(NSUInteger)index
{
    C360SegmentedControlSegment *segment = self.segments[index];
    return segment.enabled;
}

- (void)setSelectedSegmentIndex:(NSInteger)selectedSegmentIndex
{
    if (selectedSegmentIndex != _selectedSegmentIndex)
    {
        _selectedSegmentIndex = selectedSegmentIndex;
        
        for (NSUInteger i = 0; i < self.numberOfSegments; i++)
        {
            C360SegmentedControlSegment *segment = self.segments[i];
            BOOL selected = !self.momentary && ((NSInteger)i == selectedSegmentIndex);
            [segment setSelected:selected];
        }
    }
}

- (void)segmentTouchDown:(C360SegmentedControlSegment *)sender
{
    sender.momentarilySelected = YES;
    
    NSDate *selectionDate = [NSDate date];
    sender.lastMomentarySelectionDate = selectionDate;
    
    NSUInteger index = [self.segments indexOfObject:sender];
    if (self.momentary || (index != self.selectedSegmentIndex))
    {
        self.selectedSegmentIndex = index;
        [self sendActionsForControlEvents:UIControlEventValueChanged];
    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        if (sender.lastMomentarySelectionDate == selectionDate)
        {
            sender.momentarilySelected = NO;
        }
        
    });
}


#pragma mark - Layout

- (void)setPackingAlgorithm:(C360SegmentedControlPackingAlgorithm)packingAlgorithm
{
    _packingAlgorithm = packingAlgorithm;
    
    [self invalidateIntrinsicContentSize];
    [self setNeedsLayout];
}

- (void)setApportionsSegmentWidthsByContent:(BOOL)apportionsSegmentWidthsByContent
{
    _apportionsSegmentWidthsByContent = apportionsSegmentWidthsByContent;
    
    [self invalidateIntrinsicContentSize];
    [self setNeedsLayout];
}

- (void)setApportionsRowHeightsByContent:(BOOL)apportionsRowHeightsByContent
{
    _apportionsRowHeightsByContent = apportionsRowHeightsByContent;
    
    [self invalidateIntrinsicContentSize];
    [self setNeedsLayout];
}

- (CGSize)intrinsicContentSize
{
    return [self sizeThatFits:self.bounds.size];
}

- (CGSize)sizeThatFits:(CGSize)size
{
    size.height = [self performLayoutCalculationsReturningHeightForWidth:size.width performLayout:NO];
    return size;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self performLayoutCalculationsReturningHeightForWidth:self.bounds.size.width performLayout:YES];
}

- (CGFloat)performLayoutCalculationsReturningHeightForWidth:(CGFloat)width performLayout:(BOOL)performLayout
{
    NSUInteger numberOfSegments = self.numberOfSegments;
    NSMutableArray *sizes = [NSMutableArray arrayWithCapacity:numberOfSegments];
    
    CGSize availableSize = CGSizeMake(width, CGFLOAT_MAX);
    
    for (NSUInteger i = 0; i < numberOfSegments; i++)
    {
        C360SegmentedControlSegment *segment = self.segments[i];
        CGSize size = [segment sizeThatFits:availableSize];
        size.width = ceilf(size.width);
        size.height = ceilf(size.height);
        if (size.height < self.minimumRowHeight) size.height = self.minimumRowHeight;
        sizes[i] = [NSValue valueWithCGSize:size];
    }
    
    CGFloat top = 0, left = 0;
    
    NSArray *rows = nil;
    BOOL equalSegmentWidths = !self.apportionsSegmentWidthsByContent;
    switch (self.packingAlgorithm)
    {
        case C360SegmentedControlPackingHorizontal:
            {
                NSMutableArray *mutableColumns = [NSMutableArray arrayWithCapacity:numberOfSegments];
                for (NSUInteger i = 0; i < numberOfSegments; i++)
                {
                    [mutableColumns addObject:@(i)];
                }
                rows = @[ mutableColumns ];
            }
            break;
            
        case C360SegmentedControlPackingVertical:
            {
                NSMutableArray *mutableRows = [NSMutableArray arrayWithCapacity:numberOfSegments];
                for (NSUInteger i = 0; i < numberOfSegments; i++)
                {
                    [mutableRows addObject:@[ @(i) ]];
                }
                rows = mutableRows;
            }
            break;
            
        case C360SegmentedControlPackingEvenDistribution:
            rows = [self groupSizesByEvenDistribution:sizes intoRowsWithWidth:width equalSegmentWidths:equalSegmentWidths];
            break;
            
        case C360SegmentedControlPackingNextFit:
            rows = [self groupSizesByNextFit:sizes intoRowsWithWidth:width equalSegmentWidths:equalSegmentWidths];
            break;
            
        case C360SegmentedControlPackingBestFit:
            rows = [self groupSizesByBestFit:sizes intoRowsWithWidth:width equalSegmentWidths:equalSegmentWidths];
            break;
    }
    
    CGFloat minimumRowHeight = self.minimumRowHeight;
    if (!self.apportionsRowHeightsByContent)
    {
        for (NSArray *columns in rows)
        {
            for (NSNumber *itemIndexNumber in columns)
            {
                CGSize size = [sizes[itemIndexNumber.integerValue] CGSizeValue];
                minimumRowHeight = MAX(minimumRowHeight, size.height);
            }
        }
    }
    
    for (NSUInteger rowIndex = 0; rowIndex < rows.count; rowIndex++)
    {
        BOOL isLastRow = (rowIndex == rows.count - 1);
        
        NSArray *columns = rows[rowIndex];
        CGFloat rowHeight = minimumRowHeight, rowWidth = 0;
        
        for (NSNumber *indexNumber in columns)
        {
            CGSize size = [sizes[indexNumber.integerValue] CGSizeValue];
            rowHeight = MAX(rowHeight, size.height);
            rowWidth += size.width;
        }
        
        if (performLayout)
        {
            CGFloat rowWidthScale = width / rowWidth;
            CGFloat usedWidth = 0;
            
            for (NSUInteger columnIndex = 0; columnIndex < columns.count; columnIndex++)
            {
                BOOL isLastColumn = columnIndex == (columns.count - 1);
                NSInteger itemIndex = [columns[columnIndex] integerValue];
                
                CGFloat itemWidth;
                if (isLastColumn)
                {
                    itemWidth = width - usedWidth;
                }
                else if (equalSegmentWidths)
                {
                    itemWidth = roundf(width / columns.count);
                }
                else
                {
                    CGSize size = [sizes[itemIndex] CGSizeValue];
                    itemWidth = roundf(size.width * rowWidthScale);
                }
                
                C360SegmentedControlSegment *segment = self.segments[itemIndex];
                segment.frame = CGRectMake(left + usedWidth, top, itemWidth, rowHeight);
                segment.firstRow = (rowIndex == 0);
                segment.lastRow = isLastRow;
                segment.firstColumn = (columnIndex == 0);
                segment.lastColumn = isLastColumn;
                usedWidth += itemWidth;
            }
        }
        
        top += rowHeight;
    }
    
    return top;
}

- (CGFloat)rowWidthByAddingSegmentWithWidth:(CGFloat)width sizes:(NSArray *)sizes currentRow:(NSArray *)currentRow equalSegmentWidths:(BOOL)equalSegmentWidths
{
    CGFloat rowWidthWithSegment = 0;
    if (equalSegmentWidths)
    {
        CGFloat maxItemWidth = width;
        
        for (NSNumber *itemIndex in currentRow)
        {
            CGFloat itemWidth = [sizes[itemIndex.integerValue] CGSizeValue].width;
            maxItemWidth = MAX(maxItemWidth, itemWidth);
        }
        
        rowWidthWithSegment = maxItemWidth * (currentRow.count + 1);
    }
    else
    {
        for (NSNumber *itemIndex in currentRow)
        {
            CGFloat itemWidth = [sizes[itemIndex.integerValue] CGSizeValue].width;
            rowWidthWithSegment += itemWidth;
        }
        
        rowWidthWithSegment += width;
    }
    return rowWidthWithSegment;
}

- (NSArray *)groupSizesByEvenDistribution:(NSArray *)sizes
                        intoRowsWithWidth:(CGFloat)width
                       equalSegmentWidths:(BOOL)equalSegmentWidths
{
    CGFloat totalItemWidths = 0, minimumItemWidth = 0, maximumItemWidth = 0;
    for (NSUInteger i = 0; i < sizes.count; i++)
    {
        CGFloat itemWidth = [sizes[i] CGSizeValue].width;
        totalItemWidths += itemWidth;
        minimumItemWidth = minimumItemWidth ? MIN(minimumItemWidth, itemWidth) : itemWidth;
        maximumItemWidth = MAX(maximumItemWidth, itemWidth);
    }
    
    if (equalSegmentWidths)
    {
        totalItemWidths = maximumItemWidth * sizes.count;
    }
    
    NSInteger numberOfRows = ceilf(totalItemWidths / width);
    CGFloat maximumRowWidth = (totalItemWidths / numberOfRows) + minimumItemWidth;
    
    NSMutableArray *rows = [NSMutableArray arrayWithCapacity:sizes.count];
    NSMutableArray *currentRow = nil;
    CGFloat currentRowWidth = 0;
    
    for (NSUInteger i = 0; i < sizes.count; i++)
    {
        CGFloat itemWidth = [sizes[i] CGSizeValue].width;
        if (equalSegmentWidths) itemWidth = maximumItemWidth;
        
        if (currentRowWidth + itemWidth >= maximumRowWidth)
        {
            currentRow = nil;
        }
        
        if (!currentRow)
        {
            currentRow = [NSMutableArray arrayWithCapacity:sizes.count];
            currentRowWidth = 0;
            [rows addObject:currentRow];
        }
        
        [currentRow addObject:@(i)];
        currentRowWidth += itemWidth;
    }
    
    return rows;
}

- (NSArray *)groupSizesByNextFit:(NSArray *)sizes
               intoRowsWithWidth:(CGFloat)width
              equalSegmentWidths:(BOOL)equalSegmentWidths
{
    NSMutableArray *rows = [NSMutableArray arrayWithCapacity:sizes.count];
    NSMutableArray *currentRow = nil;
    
    for (NSUInteger i = 0; i < sizes.count; i++)
    {
        CGFloat itemWidth = [sizes[i] CGSizeValue].width;
        CGFloat rowWidthWithSegment = [self rowWidthByAddingSegmentWithWidth:itemWidth sizes:sizes currentRow:currentRow equalSegmentWidths:equalSegmentWidths];
        
        if (rowWidthWithSegment > width)
        {
            currentRow = nil;
        }
        
        if (!currentRow)
        {
            currentRow = [NSMutableArray arrayWithCapacity:sizes.count];
            [rows addObject:currentRow];
        }
        
        [currentRow addObject:@(i)];
    }
    
    return rows;
}

- (NSArray *)groupSizesByBestFit:(NSArray *)sizes
               intoRowsWithWidth:(CGFloat)width
              equalSegmentWidths:(BOOL)equalSegmentWidths
{
    NSMutableDictionary *sizesByIndex = [NSMutableDictionary dictionaryWithCapacity:sizes.count];
    for (NSUInteger i = 0; i < sizes.count; i++)
    {
        sizesByIndex[@(i)] = sizes[i];
    }
    
    NSArray *sortedItemIndices = [sizesByIndex.allKeys sortedArrayUsingComparator:^NSComparisonResult(NSNumber *index1, NSNumber *index2) {
        
        CGFloat height1 = [sizesByIndex[index1] CGSizeValue].height;
        CGFloat height2 = [sizesByIndex[index2] CGSizeValue].height;
        
        if (height1 < height2) return NSOrderedDescending;
        if (height1 > height2) return NSOrderedAscending;
        
        if (index1.integerValue < index2.integerValue) return NSOrderedAscending;
        if (index1.integerValue > index2.integerValue) return NSOrderedDescending;
        
        return NSOrderedSame;
        
    }];
    
    NSMutableArray *rows = [NSMutableArray arrayWithCapacity:sizes.count];
    
    for (NSNumber *itemIndex in sortedItemIndices)
    {
        CGFloat itemWidth = [sizes[itemIndex.integerValue] CGSizeValue].width;
        
        CGFloat bestFitRemainder = 0;
        NSInteger bestFitRowIndex = NSNotFound;
        
        for (NSUInteger rowIndex = 0; rowIndex < rows.count; rowIndex++)
        {
            NSArray *currentRow = rows[rowIndex];
            CGFloat rowWidthWithSegment = [self rowWidthByAddingSegmentWithWidth:itemWidth sizes:sizes currentRow:currentRow equalSegmentWidths:equalSegmentWidths];
            
            CGFloat remainder = width - rowWidthWithSegment;
            
            if (remainder > bestFitRemainder)
            {
                bestFitRemainder = remainder;
                bestFitRowIndex = rowIndex;
            }
        }
        
        if (bestFitRowIndex == NSNotFound)
        {
            bestFitRowIndex = rows.count;
            
            [rows addObject:[NSMutableArray array]];
        }
        
        [rows[bestFitRowIndex] addObject:itemIndex];
    }
    
    return rows;
}

- (void)setHighlightColor:(UIColor *)highlightColor
{
    _highlightColor = highlightColor;
    
    for (C360SegmentedControlSegment *segment in self.segments)
    {
        segment.highlightColor = highlightColor;
    }
}

@end
