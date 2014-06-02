//
//  C360DemoControllerViewController.m
//  C360SegmentedControlDemo
//
//  Created by Simon Booth on 28/05/2014.
//  Copyright (c) 2014 CRedit360. All rights reserved.
//

#import "C360DemoController.h"

typedef NS_ENUM(NSInteger, C360DemoControllerActivityPosition)
{
    C360DemoControllerActivityStart,
    C360DemoControllerActivityMiddle,
    C360DemoControllerActivityEnd
};

typedef NS_ENUM(NSInteger, C360DemoControllerActivityContent)
{
    C360DemoControllerActivityShortTitle,
    C360DemoControllerActivityLongTitle,
    C360DemoControllerActivityImage
};

@interface C360DemoController ()

@property (nonatomic, strong) IBOutlet C360SegmentedControl *segmentedControl;
@property (nonatomic, assign) C360DemoControllerActivityPosition activityPosition;
@property (nonatomic, assign) C360DemoControllerActivityContent activityContent;

@end

@implementation C360DemoController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
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

- (IBAction)changePackingAlgorithm:(UISegmentedControl *)sender
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

- (IBAction)changeActivityPosition:(UISegmentedControl *)sender
{
    self.activityPosition = (C360DemoControllerActivityPosition)sender.selectedSegmentIndex;
}

- (IBAction)changeActivityContent:(UISegmentedControl *)sender
{
    self.activityContent = (C360DemoControllerActivityContent)sender.selectedSegmentIndex;
}

#define kShortTitle @"Short"
#define kLongTitle @"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec sit amet molestie ipsum, ut condimentum lacus. Donec vulputate id est id venenatis. Nunc rutrum purus nunc, sed egestas massa malesuada id. Nullam mattis justo sit amet odio elementum posuere. Vestibulum nec sem blandit, volutpat lacus posuere, euismod sem. Morbi tempor elit eu commodo sodales. Nullam bibendum convallis enim nec lobortis."

- (IBAction)insert:(id)sender
{
    NSInteger index;
    switch (self.activityPosition) {
        case C360DemoControllerActivityStart:
            index = 0;
            break;
            
        case C360DemoControllerActivityMiddle:
            index = self.segmentedControl.numberOfSegments / 2;
            break;
            
        case C360DemoControllerActivityEnd:
            index = self.segmentedControl.numberOfSegments;
            break;
    }
    
    switch (self.activityContent) {
        case C360DemoControllerActivityShortTitle:
            [self.segmentedControl insertSegmentWithTitle:kShortTitle atIndex:index animated:YES];
            break;
            
        case C360DemoControllerActivityLongTitle:
            [self.segmentedControl insertSegmentWithTitle:kLongTitle atIndex:index animated:YES];
            break;
            
        case C360DemoControllerActivityImage:
            [self.segmentedControl insertSegmentWithImage:[UIImage imageNamed:@"first"] atIndex:index animated:YES];
            break;
    }
}

- (IBAction)replace:(id)sender
{
    NSInteger index;
    switch (self.activityPosition) {
        case C360DemoControllerActivityStart:
            index = 0;
            break;
            
        case C360DemoControllerActivityMiddle:
            index = self.segmentedControl.numberOfSegments / 2;
            break;
            
        case C360DemoControllerActivityEnd:
            index = self.segmentedControl.numberOfSegments - 1;
            break;
    }
    
    if (index < 0) return;
    
    switch (self.activityContent) {
        case C360DemoControllerActivityShortTitle:
            [self.segmentedControl setTitle:kShortTitle forSegmentAtIndex:index];
            break;
            
        case C360DemoControllerActivityLongTitle:
            [self.segmentedControl setTitle:kLongTitle forSegmentAtIndex:index];
            break;
            
        case C360DemoControllerActivityImage:
            [self.segmentedControl setImage:[UIImage imageNamed:@"first"] forSegmentAtIndex:index];
            break;
    }
}

- (IBAction)select:(id)sender
{
    NSInteger index;
    switch (self.activityPosition) {
        case C360DemoControllerActivityStart:
            index = 0;
            break;
            
        case C360DemoControllerActivityMiddle:
            index = self.segmentedControl.numberOfSegments / 2;
            break;
            
        case C360DemoControllerActivityEnd:
            index = self.segmentedControl.numberOfSegments - 1;
            break;
    }
    
    if (index < 0) return;
    
    self.segmentedControl.selectedSegmentIndex = index;
}

- (IBAction)remove:(id)sender
{
    NSInteger index;
    switch (self.activityPosition) {
        case C360DemoControllerActivityStart:
            index = 0;
            break;
            
        case C360DemoControllerActivityMiddle:
            index = self.segmentedControl.numberOfSegments / 2;
            break;
            
        case C360DemoControllerActivityEnd:
            index = self.segmentedControl.numberOfSegments - 1;
            break;
    }
    
    if (index < 0) return;
    
    [self.segmentedControl removeSegmentAtIndex:index animated:YES];
}

- (IBAction)deselect:(id)sender
{
    self.segmentedControl.selectedSegmentIndex = C360SegmentedControlNoSegment;
}

- (IBAction)toggleMomentary:(UIButton *)sender
{
    self.segmentedControl.momentary = !self.segmentedControl.momentary;
    sender.selected = self.segmentedControl.momentary;
}

- (IBAction)removeAllSegments:(id)sender
{
    [self.segmentedControl removeAllSegments];
}

@end
