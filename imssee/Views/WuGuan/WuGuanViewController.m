//
//  WuGuanViewController.m
//  imssee
//
//  Created by app001.cn on 15-2-11.
//  Copyright (c) 2015年 鑫易. All rights reserved.
//

#import "WuGuanViewController.h"
#import "WuGuanFirstPageViewController.h"
#import "WuGuanNewsViewController.h"

@interface WuGuanViewController ()

@end

@implementation WuGuanViewController

#pragma mark -Life Cycle
- (void)dealloc
{
    Release(self.segment);
    Release(self.contentView);
    Release(self.contentVC);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
    [self initTabBar];
    [self initUI];
    [self creatViewControllers];
    
    self.segment.selectedSegmentIndex = 0;
    [self segmentSelected:0];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -Private Methods
-(void)initTabBar{
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.frame = CGRectMake(5, 25, 33, 33);
    [leftButton addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    [leftButton setBackgroundImage:[UIImage imageNamed:@"back_btn"] forState:UIControlStateNormal];
    [self settingWGLeftBarButtonItem:leftButton];
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn setImage:[UIImage imageNamed:@"add.png"] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(addAction:) forControlEvents:UIControlEventTouchUpInside];
    [rightBtn setFrame:CGRectMake(SCREEN_WIDTH - 5 - 33, 25, 33, 33)];
    [self settingWGRightBarButtonItem:rightBtn];
    
    NSArray *segments = @[@"消息",@"首页"];
    _segment = [[UISegmentedControl alloc] initWithItems:segments];
    [_segment setFrame:CGRectMake((SCREEN_WIDTH - 100)/2, 25, 100, 29)];
    _segment.tintColor = [UIColor whiteColor];
    self.segment.layer.cornerRadius = 29/2.0;
    self.segment.layer.masksToBounds = YES;
    self.segment.layer.borderWidth = 1;
    self.segment.layer.borderColor = [UIColor whiteColor].CGColor;
    [self.segment setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} forState:UIControlStateNormal];
    [self.segment setTitleTextAttributes:@{NSForegroundColorAttributeName:PinkColor} forState:UIControlStateSelected];
    [self.segment addTarget:self action:@selector(segmentSelected:) forControlEvents:UIControlEventValueChanged];
    [self settingTitleView:_segment];
}

-(void)back:(UIButton *)btn{
    NSLog(@"back");
}

-(void)addAction:(UIButton *)btn{
    NSLog(@"add");
}

-(void)initUI{
    UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-74)];
    imgView.image = [UIImage imageNamed:@"background.jpg"];
    [self.view addSubview:imgView];
    
    _contentView = [[UIView alloc]initWithFrame:CGRectMake(0, 74, SCREEN_WIDTH, SCREEN_HEIGHT-74)];
    [self.view addSubview:_contentView];
    [self segmentSelected:0];
}

-(void)creatViewControllers{
    WuGuanNewsViewController *newsVC = [[WuGuanNewsViewController alloc]init];
    [self addChildViewController:newsVC];
    WuGuanFirstPageViewController *firstVC = [[WuGuanFirstPageViewController alloc]init];
    firstVC.imgArray = @[@[@"phone",@"phone1",@"常用电话"],@[@"chengyuan",@"chengyuan1",@"物管人员"],@[@"shoufei",@"shoufei1",@"收费标准"],@[@"jieshao",@"jieshao1",@"物管介绍"],@[@"jieshao",@"jieshao1",@"群发"]];
    [self addChildViewController:firstVC];
}

- (void)segmentSelected:(NSInteger *)sender {
    NSLog(@"点击了第%ld个",(long)self.segment.selectedSegmentIndex);
    [self.view bringSubviewToFront:self.segment];
    switch (self.segment.selectedSegmentIndex) {
        case 0:
        {
            self.contentVC = self.childViewControllers[0];
            break;
        }
        case 1:
        {
            [self.contentVC.view endEditing:YES];
            self.contentVC = self.childViewControllers[1];
            break;
        }
        default:
            break;
    }
    [self.contentVC.view setFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 74)];
    [self.contentView addSubview:self.contentVC.view];
    [self.view bringSubviewToFront:self.contentView];
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
