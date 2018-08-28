//
//  ViewController.m
//  RGPopoverTagView
//
//  Created by Rain on 2018/8/21.
//  Copyright © 2018年 Rain. All rights reserved.
//

#import "ViewController.h"
#import "RGPopoverTagView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)popoverTagView:(UIButton *)sender {
    NSArray *content = @[@"余罪",@"恐怖游轮",@"放牛班的春天",@"当幸福来敲门",@"哈利波特",@"死亡密码",@"源代码",@"盗梦空间",@"疯狂动物城",@"X战警",@"西游降魔篇",@"这个男人来自地球",@"致命ID致命ID致命ID致命ID",@"搏击俱乐部",@"冰雪世界"];
    CGRect popoverFrame = CGRectMake(16.0, 100.0,
                              [[UIScreen mainScreen] bounds].size.width - 32.0,
                              [[UIScreen mainScreen] bounds].size.height - 200.0);
    RGPopoverTagView *popView = [[RGPopoverTagView alloc] initWithFrame:popoverFrame];
    popView.title = @"text title";
    popView.tagPadding = UIEdgeInsetsMake(10, 8, 10, 8);
    popView.tagCornerRadius = 15.0;
    popView.tagBorderWidth = 1.0;
    popView.tagBgColor = [UIColor clearColor];
    popView.tagBorderColor = [UIColor colorWithRed:88.0 / 255.0 green:129.0 / 255.0 blue:216.0 / 255.0 alpha:1.0];
    popView.tagTextColor = [UIColor colorWithRed:88.0 / 255.0 green:129.0 / 255.0 blue:216.0 / 255.0 alpha:1.0];
    popView.tagEnable = YES;
    popView.dataSource = content;
    [popView show];
}



@end
