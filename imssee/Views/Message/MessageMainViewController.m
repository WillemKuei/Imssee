//
//  MessageMainViewController.m
//  :1
//
//  Created by 鑫易 on 15/1/29.
//  Copyright (c) 2015年 鑫易. All rights reserved.
//

#import "MessageMainViewController.h"
#import "PersonalPublishList.h"
#import "SHPageViewController.h"
#import "MessageListCell.h"
#import "EditViewController.h"

#import "WuGuanViewController.h"
#import "JuWeiViewController.h"
#import "YeZhuViewController.h"

@interface MessageMainViewController ()

@end

@implementation MessageMainViewController

#pragma mark -LifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //自定义nav
//    [self.view addSubview:[UIHelper headerViewWithImage:[UIImage imageNamed:@"nav_db.png"] title:@"社缘" target:self leftItemAction:nil rightItemAction:nil]];
    [self initMessageMainView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark Private Methods
- (void)initMessageMainView
{
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
//    [self setNavTitle:@"社缘APP产品"];
    
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.frame = CGRectMake(5, 25, 33, 33);
    [leftButton addTarget:self action:@selector(settingAction:) forControlEvents:UIControlEventTouchUpInside];
    [leftButton setBackgroundImage:[UIImage imageNamed:@"setting.png"] forState:UIControlStateNormal];
    [self settingWGLeftBarButtonItem:leftButton];
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn setImage:[UIImage imageNamed:@"add.png"] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(addAction:) forControlEvents:UIControlEventTouchUpInside];
    [rightBtn setFrame:CGRectMake(SCREEN_WIDTH - 5 - 33, 25, 33, 33)];
    [self settingWGRightBarButtonItem:rightBtn];
    
    NSArray *segments = @[@"消息",@"首页"];
    UISegmentedControl *seg = [[UISegmentedControl alloc] initWithItems:segments];
    [seg setFrame:CGRectMake((SCREEN_WIDTH - 80)/2, 25, 80, 30)];
    [self settingTitleView:seg];
}

- (void)settingAction:(id)sender
{
    [UIHelper alertWithTitle:@"温馨提示" andMSG:@"你点击了设置!"];
}

- (void)addAction:(id)sender
{
//    EditViewController *editVC = [[EditViewController alloc] init];
//    [self.navigationController pushViewController:editVC animated:YES];
}

#pragma mark UITableViewDataSource
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"identifier";
    MessageListCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"MessageListCell" owner:nil options:nil] lastObject];
    }
    
    NSString *title = @"某某不差钱";
    NSString *content = @"某某不差钱，买了很多部iPhone6 Plus！";
    if (indexPath.row == 0) {
        cell.markImageStyle = HotNews;
        title = @"头条新闻";
        content = @"这是一组头条新闻！";
        cell.badgeValue = @"9";
    } else if (indexPath.row == 1) {
        cell.markImageStyle = Community;
        title = @"社区新闻";
        content = @"这是一组社区新闻！";
        cell.badgeValue = @"99+";
    } else if (indexPath.row == 2) {
        cell.markImageStyle = Notification;
        title = @"通知";
        content = @"这是一条通知！";
    }
    cell.titleLab.text = title;
    cell.contentLab.text = content;
    cell.timeLab.text = @"上午12:00";
    cell.authorLab.text = @"李某某";
    
    return cell;
}

#pragma mark UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SHPageViewController *SHPageVC = [[SHPageViewController alloc] init];
    if (indexPath.row == 0) {
        SHPageVC.currentChapter = HotNewsList;
    } else if (indexPath.row == 1) {
//        PersonalPublishList *personal = [[PersonalPublishList alloc]init];
//        [self.navigationController pushViewController:personal animated:YES];
        SHPageVC.currentChapter = Community;
    }else if (indexPath.row == 2){
        WuGuanViewController *wuGuanVC = [[WuGuanViewController alloc]init];
        [self.navigationController pushViewController:wuGuanVC animated:YES];
        return;
    }else if (indexPath.row == 3){
        JuWeiViewController *juWeiVC = [[JuWeiViewController alloc]init];
        [self.navigationController pushViewController:juWeiVC animated:YES];
        return;
    }else if (indexPath.row == 4){
        YeZhuViewController *yeZhuVC = [[YeZhuViewController alloc]init];
        [self.navigationController pushViewController:yeZhuVC animated:yeZhuVC];
        return;
    }
    [self.navigationController pushViewController:SHPageVC animated:YES];
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
