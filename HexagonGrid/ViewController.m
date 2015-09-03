//
//  ViewController.m
//  hexGrid
//
//  Created by Bartosz Olszanowski on 03.09.2015.
//  Copyright (c) 2015 Vorm. All rights reserved.
//

#import "ViewController.h"
#import "HexagonGrid.h"
#import "RectView.h"
#import "RoundView.h"
#import <QuartzCore/QuartzCore.h>

@interface ViewController () <UIScrollViewDelegate>

@property (nonatomic, strong) HexagonGrid *hexGrid;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation ViewController

#pragma mark - Constants

static const CGFloat kScrollViewWidth = 1000;
static const CGFloat kScrollViewHeight = 1000;
static const NSInteger kNumberOfViews = 19;

#pragma mark - Properties

- (void)setScrollView:(UIScrollView *)scrollView
{
    _scrollView = scrollView;
    _scrollView.minimumZoomScale = 1;
    _scrollView.maximumZoomScale = 3.0;
    _scrollView.delegate = self;
    self.scrollView.contentSize = CGSizeMake(kScrollViewWidth, kScrollViewHeight);
}

#pragma mark - VC's Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    // Initialize hexGrid
    self.hexGrid = [[HexagonGrid alloc] init];
    // Set optional parameters
    self.hexGrid.viewsAreAppearingClockwise = YES;
    self.hexGrid.mainViewRadius = 80;
    self.hexGrid.surroundingViewRadius = 40;
    self.hexGrid.offsetBetweeenViews = 20;
    // Set required parameters
    self.hexGrid.viewFrame = self.scrollView.frame;
    self.hexGrid.numberOfViews = kNumberOfViews;
    
    // Produce UIViews
    for (int i = 0; i < kNumberOfViews; i++) {
        [self performSelector:@selector(drawViewAtIndex:) withObject:@(i) afterDelay:i];
    }
    
}

#pragma mark - Drawing

- (void)drawViewAtIndex:(NSNumber *)i
{
    // Take frame from grid
    CGRect aFrame = [self.hexGrid frameOfViewAtIndex:i.intValue];
    
    // RectView
    //RectView *newView = [[RectView alloc] initWithFrame:aFrame];
    //newView.backgroundColor = [UIColor clearColor];
    
    // RoundView
    //RoundView *newView = [[RoundView alloc] initWithFrame:aFrame];
    //newView.backgroundColor = [UIColor clearColor];
    
    // Image View
    UIImageView *newView = [[UIImageView alloc] initWithFrame:aFrame];
    int randNum = arc4random() % 10;
    newView.image = [UIImage imageNamed:[[self VORMTeamImages] objectAtIndex:randNum]];
    // Set layer
    newView.layer.backgroundColor=[[UIColor clearColor] CGColor];
    newView.layer.cornerRadius = i.intValue == 0 ? self.hexGrid.mainViewRadius : self.hexGrid.surroundingViewRadius;
    newView.layer.borderWidth = 2.0;
    newView.layer.masksToBounds = YES;
    newView.layer.borderColor=[[UIColor redColor] CGColor];
    
    [self.scrollView addSubview:newView];
}

- (NSArray *)VORMTeamImages
{
    return @[@"janposz.jpg", @"antonio.jpg", @"andrew.jpg", @"mike.jpg", @"agajucha.jpg", @"simon.jpg", @"bart.jpg", @"aparcik.jpg", @"bartosz.jpg", @"blazej.jpg"];
}

#pragma mark - ScrollView Delegate

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.view;
}

@end
