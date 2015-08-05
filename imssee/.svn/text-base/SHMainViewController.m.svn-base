//
//  SHMainViewController.m
//  imssee
//
//  Created by 鑫易 on 14/12/26.
//  Copyright (c) 2014年 鑫易. All rights reserved.
//

#import "SHMainViewController.h"
#import "CDVViewController.h"
#import "WGCustomizedAlert.h"
#import "MessageMainViewController.h"
#import "CommunityMainViewController.h"
#import "PeripheryMainViewController.h"
#import "ServiceMainViewController.h"
#import "PersonalMainViewController.h"
#import "WGTabBar.h"

#define ChangeVC_Duration 0.2

@interface SHMainViewController ()<WGTabBarDelegate>
{
    __weak UIViewController *_currentViewController;
    WGTabBar *_tabBar;
}

@end

static void addChildView(UIView *childView, UIView *superView){
    CGFloat screenWidth = SCREEN_WIDTH;
    CGFloat screenHeight = SCREEN_HEIGHT;
    [childView setFrame:CGRectMake(0, 0, screenWidth, screenHeight - 49)];
    [superView addSubview:childView];
}

@implementation SHMainViewController

#pragma mark -Life Cycle
- (void)dealloc
{
    Release(_currentViewController);
    Release(_tabBar);
}

static dispatch_once_t once;
- (void)setSelectedIndex:(NSInteger)selectedIndex
{
    _selectedIndex = selectedIndex;
    __weak UIViewController *controller = self.childViewControllers[_selectedIndex];
    __weak const SHMainViewController *blockSelf = self;
    dispatch_once(&once, ^{
        _currentViewController = controller;
        addChildView(controller.view, blockSelf.view);
    });
    
    [_tabBar setSelectedIndex:_selectedIndex];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self createChildViewControllers];
    [self loadWGTabBar];
    [self setSelectedIndex:0];
    [self requestUserInfo];
}

#pragma mark -Private Methods
- (void)loadWGTabBar
{
    _tabBar = [[WGTabBar alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 49, self.view.frame.size.width, 49) items:@[@"消息",@"社友",@"周边",@"服务",@"我"]];
    [_tabBar settingTabBarImage:@[@"msg.png",@"sheyou.png",@"zhoubian.png",@"service.png",@"personal.png"] selectedImage:@[@"msg_sel.png",@"sheyou_sel.png",@"zhoubian_sel.png",@"service_sel.png",@"personal_sel.png"]];
    _tabBar.delegate = self;
    if (_tabBar.items.count > 0) {
        for (int i = 0; i < _tabBar.items.count; i++) {
            WGTabBarItem *wgTabBarItem = _tabBar.items[i];
            SHViewController *childVC = (SHViewController *)self.childViewControllers[i];
            childVC.wgTabBarItem = wgTabBarItem;
            if (i == 0) {
                [childVC.wgTabBarItem setBadgeValue:@"99+"];
            } else if (i == 1 || i == 2)  {
                childVC.wgTabBarItem.hint = YES;
            }
        }
    }
    [self.view addSubview:_tabBar];
}

/**
 *  @desc 创建并添加ChildViewControllers
 */
- (void)createChildViewControllers
{
    //消息
    MessageMainViewController *messageMainVC = [[MessageMainViewController alloc] init];
//    messageMainVC.wgTabBarItem = _tabBar.items[0];
    [self addChildViewController:messageMainVC];
    //社区
    CommunityMainViewController *communityMainVC = [[CommunityMainViewController alloc] init];
//    communityMainVC.wgTabBarItem = _tabBar.items[1];
    [self addChildViewController:communityMainVC];
    //周边
    PeripheryMainViewController *peripheryMainVC = [[PeripheryMainViewController alloc] init];
//    peripheryMainVC.wgTabBarItem = _tabBar.items[2];
    [self addChildViewController:peripheryMainVC];
    //服务
    ServiceMainViewController *serviceMainVC = [[ServiceMainViewController alloc] init];
//    serviceMainVC.wgTabBarItem = _tabBar.items[3];
    [self addChildViewController:serviceMainVC];
    //我
    PersonalMainViewController *personalMainVC = [[PersonalMainViewController alloc] init];
//    personalMainVC.wgTabBarItem = _tabBar.items[4];
    [self addChildViewController:personalMainVC];
    
//    //设置默认的ViewController
//    [self.view addSubview:messageMainVC.view];
//    _currentViewController = messageMainVC;
}

- (void)changeChildViewController:(NSInteger)index
{
    __weak UIViewController *selectedVC = self.childViewControllers[index];
    self.selectedIndex = index;
    //重新设置一设置frame
    CGFloat screenWidth = SCREEN_WIDTH;
    CGFloat screenHeight = SCREEN_HEIGHT;
    [selectedVC.view setFrame:CGRectMake(0, 0, screenWidth, screenHeight - 49)];
    //切换ChildViewController
    [self transitionFromViewController:_currentViewController
                      toViewController:selectedVC
                              duration:ChangeVC_Duration
                               options:UIViewAnimationOptionCurveEaseInOut
                            animations:^{
                                //
                            }
                            completion:^(BOOL finished) {
                                _currentViewController = selectedVC;
                            }];
}

/**
 *  @desc 获取用户信息
 */
- (void)requestUserInfo
{
    NSDictionary *params = @{@"memberid":@"1"};  //TODO:测试传1
    [[HttpRequest sharedInstance] userInfoDataWithParams:params completionBlock:^(id result) {
        NSLog(@"result:%@",result);
        if ([result[@"ec"] integerValue] != 0) {
            [WGProgressHUD showErrorWith:self.view status:@"请求错误"];
            return;
        }
        NSDictionary *params = result[@"result"];
        UserInfo *userInfo = [UserInfo shareInstance:params];
        ImsseeInstance *imsseeInstance = [ImsseeInstance shareInstance];
        imsseeInstance.userInfo = userInfo;
    } failureBlock:^(NSError *error, NSString *responseStr) {
        NSLog(@"error:%@",[error localizedDescription]);
    }];
}

//- (IBAction)goPage:(id)sender{
//    CDVViewController *cdVC = [[CDVViewController alloc] init];
//    cdVC.wwwFolderName = @"www";
//    cdVC.startPage = @"index.html";
//    
//    [self.navigationController pushViewController:cdVC animated:YES];
//}

//- (IBAction)alertAction:(id)sender{
//    UIView *optionView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 180)];
//    optionView.backgroundColor = [UIColor orangeColor];
//    
//    WGCustomizedAlert *alert = [[WGCustomizedAlert alloc] initCustomizedAlertWithUIView:optionView];
//    [alert canDismiss:NO];
//    [alert showAlertWithParentView:self.view];
//}

#pragma mark WGTabBarDelegate
- (void)WGTabBar:(WGTabBar *)wgTabBar didSelectedItem:(id)selectedItem
{
    //切换ChildViewController
    [self changeChildViewController:((UIButton *)selectedItem).tag];
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
