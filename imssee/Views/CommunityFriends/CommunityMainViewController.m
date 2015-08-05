//
//  CommunityMainViewController.m
//  imssee
//
//  Created by 鑫易 on 15/1/29.
//  Copyright (c) 2015年 鑫易. All rights reserved.
//

#import "CommunityMainViewController.h"
#import "NextViewController.h"
#import "SHPageViewController.h"

@interface CommunityMainViewController ()

@end

@implementation CommunityMainViewController
- (void)dealloc
{
    Release(self.SHPageVC);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)buttonAction:(id)sender{
//    [UIHelper alertWithTitle:@"温馨提示" andMSG:@"点击了!"];
    NextViewController *nextVC = [[NextViewController alloc] init];
    [self.SHPageVC.navigationController pushViewController:nextVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
