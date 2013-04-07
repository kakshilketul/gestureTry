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
@property (nonatomic,strong) NSString* Winner;
@property (nonatomic,strong) UIView* ViewYellow;
@property (nonatomic,strong) UIView* ViewRed;
@end

@implementation ViewController

@synthesize Winner = _Winner;

 -(void) addGesture
{
    [self.ViewRed addGestureRecognizer :[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(redpan:)]];
   [self.ViewYellow addGestureRecognizer:[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(yellowpan:)]];
}




- (void) redpan:(UIPanGestureRecognizer *)recognizer
{
    CGPoint start;
    start.x = 0;
    start.y = 0;
    if (recognizer.state == UIGestureRecognizerStateBegan ) {
        start = [recognizer translationInView:self.ViewRed];
    }
    if (recognizer.state == UIGestureRecognizerStateEnded) {
        CGPoint end = [recognizer translationInView:self.ViewRed];
        if ((start.y - end.y) <= 1) {
            CGRect yellowRect = self.ViewYellow.frame;
            CGRect redRect = self.ViewRed.frame;
            if (yellowRect.origin.y > 410 ) {
                self.Winner = @"Red";
                NSLog(@"Segue");
                [self performSegueWithIdentifier:@"MainSegue" sender:self.Winner];
            }
            else
            {
                yellowRect.origin = CGPointMake(yellowRect.origin.x, yellowRect.origin.y +  10);
                redRect.origin = CGPointMake(redRect.origin.x, redRect.origin.y +  10);
                self.ViewYellow.frame = yellowRect;
                self.ViewRed.frame = redRect;
                
            }
        }
    }
}


- (void)yellowpan:(UIPanGestureRecognizer *)recognizer
{
    CGPoint start;
    start.x = 0;
    start.y = 0;
    if (recognizer.state == UIGestureRecognizerStateBegan ) {
        start = [recognizer translationInView:self.ViewYellow];
    }
    if (recognizer.state == UIGestureRecognizerStateEnded) {
        CGPoint end = [recognizer translationInView:self.ViewYellow];
        if ((start.y - end.y) >= 1) {
            CGRect yellowRect = self.ViewYellow.frame;
            CGRect redRect = self.ViewRed.frame;
            if (yellowRect.origin.y  < 10 ) {
                self.Winner = @"Yellow";
                NSLog(@"Segue");
                [self performSegueWithIdentifier:@"MainSegue" sender:self.Winner];
            }
            else
            {
            yellowRect.origin = CGPointMake(yellowRect.origin.x, yellowRect.origin.y -  10);
            redRect.origin = CGPointMake(redRect.origin.x, redRect.origin.y -  10);
            self.ViewYellow.frame = yellowRect;
                self.ViewRed.frame = redRect;

            }
        }
    }
}
 

#define HEIGHT_BOUNDS 504;
#define WIDTH_BOUNDS 320;
-(void) loadViews
{
    CGRect yellowRect;
    yellowRect.size.width = WIDTH_BOUNDS;
    yellowRect.size.height = HEIGHT_BOUNDS;
    yellowRect.origin.x = 0;
    yellowRect.origin.y = 220;
    self.ViewYellow= [[UIView alloc]initWithFrame:yellowRect];
    self.ViewYellow.backgroundColor = [UIColor yellowColor];
   // self.ViewYellow.image = [UIImage imageNamed:@"push-up-exercise-routines.jpg"];
    [self.view addSubview:self.ViewYellow];
    CGRect redRect;
    redRect.size.width = WIDTH_BOUNDS;
    redRect.size.height = HEIGHT_BOUNDS ;
    redRect.origin.x = 0;
    redRect.origin.y = -284;
    self.ViewRed= [[UIView alloc]initWithFrame:redRect];
    self.ViewRed.backgroundColor = [UIColor redColor];
    //self.ViewRed.image = [UIImage imageNamed:@"32851-b.JPG"];
    [self.view addSubview:self.ViewRed];

}
- (void)viewDidLoad
{
    [super viewDidLoad];
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.title = @"MyGame";
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
        w.WinnerLabel.text = self.Winner;
        self.title =@"Play Again";
    }
}


@end
