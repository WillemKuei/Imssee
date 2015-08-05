//
//  SHViewController.m
//  imssee
//
//  Created by 鑫易 on 15/1/29.
//  Copyright (c) 2015年 鑫易. All rights reserved.
//

#import "SHViewController.h"
#import <objc/runtime.h>

static dispatch_once_t once;
const void LoadNavigationBar(SHViewController *SHVC){
    UIImageView *navBarTmp = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)];
    navBarTmp.image = [UIImage imageNamed:@"nav_db"];
    navBarTmp.userInteractionEnabled = YES;
    SHVC.WGNavigationBar = navBarTmp;
    [SHVC.view addSubview:SHVC.WGNavigationBar];
}

@interface SHViewController ()
{
    BOOL _wasKeyboardManagerEnabled;
}

@end

@implementation SHViewController
#pragma mark 复写setter/getter
- (void)setNavTitle:(NSString *)navTitle
{
    if (_navTitle != navTitle) {
        _navTitle = navTitle;
        [self createTitleLab];
    }
}

#pragma mark LifeCycle Method
- (void)dealloc
{
    Release(self.wgTabBarItem);
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if ([self.navigationController.viewControllers count] >= 2) {
        UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
        leftButton.frame = CGRectMake(5, 25, 33, 33);
        [leftButton addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
        [leftButton setBackgroundImage:[UIImage imageNamed:@"back_btn"] forState:UIControlStateNormal];
        self.WGLeftBarButtonItem = leftButton;
        [self.WGNavigationBar addSubview:self.WGLeftBarButtonItem];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background.jpg"]];
//    dispatch_once(&once, ^{
//        LoadNavigationBar(self);
//    });
    
    UIImageView *navBarTmp = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)];
    navBarTmp.image = [UIImage imageNamed:@"nav_db"];
    navBarTmp.userInteractionEnabled = YES;
    self.WGNavigationBar = navBarTmp;
    [self.view addSubview:self.WGNavigationBar];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark Private Methods
- (void)backAction:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)createTitleLab
{
    if (_titleLab == nil) {
        _titleLab = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLab.textAlignment = NSTextAlignmentCenter;
        _titleLab.font = [UIFont systemFontOfSize:20.f];
        _titleLab.textColor = WHITE_COLOR;
        _titleLab.text = @"标题";
        [self settingTitleView:_titleLab];
    }
    
    _titleLab.text = _navTitle;
    CGSize size = [_navTitle sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20.f]}];
    _titleLab.frame = CGRectMake((SCREEN_WIDTH - size.width)/2, 25, size.width, 34);
}

#pragma mark Master Methods
- (void)settingWGLeftBarButtonItem:(UIButton *)WGItem
{
    self.WGLeftBarButtonItem = WGItem;
    [self.WGNavigationBar addSubview:self.WGLeftBarButtonItem];
}

- (void)settingWGRightBarButtonItem:(UIButton *)WGItem
{
    self.WGRightBarButtonItem = WGItem;
    [self.WGNavigationBar addSubview:self.WGRightBarButtonItem];
}

- (void)settingTitleView:(UIView *)titleView
{
    self.WGTitleView = titleView;
    [self.WGNavigationBar addSubview:self.WGTitleView];
}


#pragma mark 重写类别的setter, getter
static void * WGNavigationBarKey = (void *)@"WGNavigationBarKey";
static void * WGLeftBarButtonItemKey = (void *)@"WGLeftBarButtonItem";
static void * WGRightBarButtonItemKey = (void *)@"WGRightBarButtonItem";
static void * WGTitleViewKey = (void *)@"WGTitleViewKey";
- (UIImageView *)WGNavigationBar
{
    return objc_getAssociatedObject(self, WGNavigationBarKey);
}

- (void)setWGNavigationBar:(UIImageView *)WGNavigationBar
{
    objc_setAssociatedObject(self, WGNavigationBarKey, WGNavigationBar, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIButton *)WGLeftBarButtonItem
{
    return objc_getAssociatedObject(self, WGLeftBarButtonItemKey);
}

- (void)setWGLeftBarButtonItem:(UIButton *)WGLeftBarButtonItem
{
    objc_setAssociatedObject(self, WGLeftBarButtonItemKey, WGLeftBarButtonItem, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIButton *)WGRightBarButtonItem
{
    return objc_getAssociatedObject(self, WGRightBarButtonItemKey);
}

- (void)setWGRightBarButtonItem:(UIButton *)WGRightBarButtonItem
{
    objc_setAssociatedObject(self, WGRightBarButtonItemKey, WGRightBarButtonItem, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIView *)WGTitleView
{
    return objc_getAssociatedObject(self, WGTitleViewKey);
}

- (void)setWGTitleView:(UIView *)WGTitleView
{
    objc_setAssociatedObject(self, WGTitleViewKey, WGTitleView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
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
