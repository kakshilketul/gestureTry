//
//  ViewController.m
//  gestureTry
//
//  Created by Kakshil shah on 02/04/13.
//  Copyright (c) 2013 Kakshil shah. All rights reserved.
//

#import "ViewController.h"
#import "WinnerViewController.h"
@interface ViewController ()
{
    int countTop;
    int countBottom;
}
@property (nonatomic,strong) NSString* Winner;
@property (nonatomic,strong) UIView* BottomView;
@property (nonatomic,strong) UIView* TopView;
@property (nonatomic,strong) UIImageView* BottomViewImage;
@property (nonatomic,strong) UIImageView* TopViewImage;


@end

@implementation ViewController

@synthesize Winner = _Winner;

#define MIN_VALUE 0;
#define MAX_VALUE 4;

 -(void) addGesture
{
    [self.TopView addGestureRecognizer :[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(toppan:)]];
   [self.BottomView addGestureRecognizer:[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(bottompan:)]];
}




- (void) toppan:(UIPanGestureRecognizer *)recognizer
{
    CGPoint start;
    start.x = 0;
    start.y = 0;
    if (recognizer.state == UIGestureRecognizerStateBegan ) {
        start = [recognizer translationInView:self.TopView];
    }
    if (recognizer.state == UIGestureRecognizerStateEnded) {
        CGPoint end = [recognizer translationInView:self.TopView];
        if ((start.x - end.x) <= 1) {
            countTop++;
            if (countTop > 4 ) {
                self.Winner = @"Top";
                [self performSegueWithIdentifier:@"MainSegue" sender:nil];
            }
            else
            {
               self.TopViewImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"%i.png",countTop]];
            }
        }
    }
}


- (void)bottompan:(UIPanGestureRecognizer *)recognizer
{
    CGPoint start;
    start.x = 0;
    start.y = 0;
    if (recognizer.state == UIGestureRecognizerStateBegan ) {
        start = [recognizer translationInView:self.BottomView];
    }
    if (recognizer.state == UIGestureRecognizerStateEnded) {
        CGPoint end = [recognizer translationInView:self.BottomView];
        if ((start.x - end.x) <= 1) {
            countBottom--;
            if (countBottom < 0 ) {
                self.Winner = @"Bottom";
                [self performSegueWithIdentifier:@"MainSegue" sender:nil];
            }
            else
            {
                self.BottomViewImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"%i.png",countBottom]];
            }
        }
    }
}
 

#define HEIGHT_BOUNDS 480;
#define WIDTH_BOUNDS 320;
#define HEIGHT_HALF 240;
-(void) loadViews
{
    countBottom = 4;
    countTop = 0;
    CGRect bottomRect;
    bottomRect.size.width = WIDTH_BOUNDS;
    bottomRect.size.height = HEIGHT_HALF;
    bottomRect.origin.x = 0;
    bottomRect.origin.y = HEIGHT_HALF;
    self.BottomView= [[UIView alloc]initWithFrame:bottomRect];
    self.BottomViewImage = [[UIImageView alloc]initWithFrame:bottomRect];
    self.BottomViewImage.image = [UIImage imageNamed:@"4.png"];
    [self.view addSubview:self.BottomView];
    [self.view addSubview:self.BottomViewImage];
    CGRect topRect;
    topRect.size.width = WIDTH_BOUNDS;
    topRect.size.height = HEIGHT_HALF;
    topRect.origin.x = 0;
    topRect.origin.y = 0;
    self.TopView= [[UIView alloc]initWithFrame:topRect];
    self.TopViewImage = [[UIImageView alloc]initWithFrame:topRect];
    self.TopViewImage.image = [UIImage imageNamed:@"0.png"];
    [self.view addSubview:self.TopView];
    [self.view addSubview:self.TopViewImage];

}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES];
    [[UIApplication sharedApplication] setStatusBarHidden:YES];

}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self loadViews];
    [self addGesture];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"MainSegue"] ) {
        WinnerViewController *w = segue.destinationViewController;
        w.Winner = self.Winner;
    }
}


@end
