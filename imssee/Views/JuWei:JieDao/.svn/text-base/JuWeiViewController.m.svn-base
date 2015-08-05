//
//  JuWeiViewController.m
//  imssee
//
//  Created by app001.cn on 15-2-9.
//  Copyright (c) 2015年 鑫易. All rights reserved.
//

#import "JuWeiViewController.h"
#import "JuWeiFirstPageViewController.h"
#import "JuWeiNewsViewController.h"

@interface JuWeiViewController ()<UITextViewDelegate>

@end

@implementation JuWeiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  //  self.view.backgroundColor = [UIColor clearColor];
    [self creatViewControllers];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)creatViewControllers{
    JuWeiNewsViewController *newsVC = [[JuWeiNewsViewController alloc]init];
    [self addChildViewController:newsVC];
    JuWeiFirstPageViewController *firstVC = [[JuWeiFirstPageViewController alloc]init];
    firstVC.imgArray = @[@[@"jieshao",@"jieshao1",@"介绍"],@[@"phone",@"phone1",@"常用电话"],@[@"zhinan",@"zhinan1",@"办事指南"],@[@"zhinan",@"zhinan1",@"群发"]];
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
