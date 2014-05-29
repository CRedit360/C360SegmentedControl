//
//  C360DemoControllerViewController.m
//  C360SegmentedControlDemo
//
//  Created by Simon Booth on 28/05/2014.
//  Copyright (c) 2014 CRedit360. All rights reserved.
//

#import "C360DemoController.h"

@interface C360DemoController ()

@property (nonatomic, strong) IBOutlet C360SegmentedControl *segmentedControl;

@end

@implementation C360DemoController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.segmentedControl insertSegmentWithTitle:@"One" atIndex:0 animated:NO];
    [self.segmentedControl insertSegmentWithImage:[UIImage imageNamed:@"second"] atIndex:1 animated:NO];
    [self.segmentedControl insertSegmentWithTitle:@"Three, that's the magic number, I said three, that's the magic number" atIndex:2 animated:NO];
}

- (IBAction)insertSegmentWithShortTitle:(id)sender
{
    NSString *title = @[@"Short", @"Tiny", @"Little"][arc4random() % 3];
    NSInteger index = self.segmentedControl.numberOfSegments ? arc4random() % (self.segmentedControl.numberOfSegments + 1) : 0;
    [self.segmentedControl insertSegmentWithTitle:title atIndex:index animated:YES];
}

- (IBAction)insertSegmentWithLongTitle:(id)sender
{
    NSString *title = @[
        @"Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
        @"Nulla blandit lectus sit amet erat consectetur, sit amet accumsan nunc porttitor. Vestibulum vestibulum nunc vel velit cursus eleifend.",
        @"Quisque iaculis elementum eros, in ullamcorper purus ultrices eget. Duis ornare lobortis diam ultricies iaculis. Quisque placerat condimentum quam, at congue tortor dignissim id. Pellentesque non enim tristique, dictum ipsum a, aliquet urna."
        ][arc4random() % 3];
    NSInteger index = self.segmentedControl.numberOfSegments ? arc4random() % (self.segmentedControl.numberOfSegments + 1) : 0;
    [self.segmentedControl insertSegmentWithTitle:title atIndex:index animated:YES];
}

- (IBAction)insertSegmentWithImage:(id)sender
{
    UIImage *image = [UIImage imageNamed:@"first"];
    NSInteger index = self.segmentedControl.numberOfSegments ? arc4random() % self.segmentedControl.numberOfSegments : 0;
    [self.segmentedControl insertSegmentWithImage:image atIndex:index animated:YES];
}

- (IBAction)removeSegment:(id)sender
{
    if (self.segmentedControl.numberOfSegments > 0)
    {
        NSInteger index = arc4random() % self.segmentedControl.numberOfSegments;
        [self.segmentedControl removeSegmentAtIndex:index animated:YES];
    }
}

- (IBAction)removeAllSegments:(id)sender
{
    [self.segmentedControl removeAllSegments];
}

- (IBAction)replaceSegmentWithTitle:(id)sender
{
    if (self.segmentedControl.numberOfSegments > 0)
    {
        NSInteger index = arc4random() % self.segmentedControl.numberOfSegments;
        [self.segmentedControl setTitle:@"Hi! We're the replacements." forSegmentAtIndex:index];
    }
}

- (IBAction)replaceSegmentWithImage:(id)sender
{
    if (self.segmentedControl.numberOfSegments > 0)
    {
        NSInteger index = arc4random() % self.segmentedControl.numberOfSegments;
        [self.segmentedControl setImage:[UIImage imageNamed:@"second"] forSegmentAtIndex:index];
    }
}

- (IBAction)selectSegment:(id)sender
{
    if (self.segmentedControl.numberOfSegments > 0)
    {
        NSInteger index = arc4random() % self.segmentedControl.numberOfSegments;
        [self.segmentedControl setSelectedSegmentIndex:index];
    }
}

- (IBAction)deselectSegment:(id)sender
{
    [self.segmentedControl setSelectedSegmentIndex:C360SegmentedControlNoSegment];
}

- (IBAction)toggleMomentary:(UIButton *)sender
{
    self.segmentedControl.momentary = !self.segmentedControl.momentary;
    sender.selected = self.segmentedControl.momentary;
}

- (IBAction)changeOrdering:(UISegmentedControl *)sender
{
    self.segmentedControl.packingAlgorithm = (C360SegmentedControlPackingAlgorithm)sender.selectedSegmentIndex;
}

- (IBAction)toggleApportionWidthsByContent:(UIButton *)sender
{
    self.segmentedControl.apportionsSegmentWidthsByContent = !self.segmentedControl.apportionsSegmentWidthsByContent;
    sender.selected = self.segmentedControl.apportionsSegmentWidthsByContent;
}

- (IBAction)toggleApportionHeightsByContent:(UIButton *)sender
{
    self.segmentedControl.apportionsRowHeightsByContent = !self.segmentedControl.apportionsRowHeightsByContent;
    sender.selected =  self.segmentedControl.apportionsRowHeightsByContent;
}

@end
