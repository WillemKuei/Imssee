//
//  YeZhuViewController.m
//  imssee
//
//  Created by app001.cn on 15-2-12.
//  Copyright (c) 2015年 鑫易. All rights reserved.
//

#import "YeZhuViewController.h"
#import "YeZhuFirstPageViewController.h"
#import "YeZhuNewsViewController.h"

@interface YeZhuViewController ()

@end

@implementation YeZhuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self creatViewControllers];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)creatViewControllers{
    YeZhuNewsViewController *newsVC = [[YeZhuNewsViewController alloc]init];
    [self addChildViewController:newsVC];
    YeZhuFirstPageViewController *firstVC = [[YeZhuFirstPageViewController alloc]init];
    firstVC.imgArray = @[@[@"chengyuan",@"chengyuan1",@"成员"],@[@"jieshao",@"jieshao1",@"介绍"],@[@"jieshao",@"jieshao1",@"群发"]];
    [self addChildViewController:firstVC];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
