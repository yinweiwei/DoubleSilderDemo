//
//  ViewController.m
//  YSDoubleSilderDemo
//
//  Created by bm on 2017/11/8.
//  Copyright © 2017年 bm. All rights reserved.
//

#import "ViewController.h"
#import "YSDoubleSilderV.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    YSDoubleSilderV *doubleSilderV =[[YSDoubleSilderV alloc]init];
    doubleSilderV.frame=CGRectMake(15, 400, [UIScreen mainScreen].bounds.size.width-30, 50);
    doubleSilderV.max=60;
    doubleSilderV.min=30;
    doubleSilderV.firstS=35;
    doubleSilderV.lastS=55;
    [self.view addSubview:doubleSilderV];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
