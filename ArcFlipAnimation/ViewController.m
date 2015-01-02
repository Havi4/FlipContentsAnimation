//
//  ViewController.m
//  ArcFlipAnimation
//
//  Created by 臧其龙 on 15/1/2.
//  Copyright (c) 2015年 臧其龙. All rights reserved.
//

#import "ViewController.h"
#import "ArcView.h"

@interface ViewController ()
{
    ArcView *arc;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    arc = [[ArcView alloc] initWithFrame:CGRectMake(200, 200, 88, 88)];
   // arc.layer.cornerRadius = 44;
    arc.layer.masksToBounds = YES;
    [self.view addSubview:arc];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)startAnimation:(id)sender
{
    [arc startAnimation];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
