//
//  SHPageViewController.m
//  imssee
//
//  Created by 鑫易 on 15/1/30.
//  Copyright (c) 2015年 鑫易. All rights reserved.
//

#import "SHPageViewController.h"
#import "HotNewsViewController.h"           //头条
#import "InternationalViewController.h"     //国际-中国
#import "CommunityNewsViewController.h"     //社区
#import "CityNewsViewController.h"          //城市
#import "PersonalPublishList.h"             //个人发表
#import "EditViewController.h"

#import "NewsMenuListView.h"
#import "NewsDetailViewController.h"
#import "SWTableViewCell.h"
#import "CDVViewController.h"
#import "HSList.h"

#define PageView_Tag 3000

@interface SHPageViewController ()<UIScrollViewDelegate,NewsMenuDelegate,CommonSelectedRowDelegate>
{
    NewsMenuListView *_menuView;
    UIScrollView *_contentView;
    NSArray *_pageViews;
    NSMutableDictionary *_pageViewDic;
    UIButton *_rightBtn;
}

@end

@implementation SHPageViewController

#pragma mark LifeCycle
- (void)dealloc
{
    Release(_menuView);
    Release(_contentView);
    Release(_pageViewDic);
    Release(_pageViews);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //自定义nav
//    [self.view addSubview:[UIHelper headerViewWithImage:[UIImage imageNamed:@"nav_db.png"] title:@"社缘" target:self backAction:@selector(backAction:)]];
    self.navTitle = @"社缘";
    _rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_rightBtn setImage:[UIImage imageNamed:@"add.png"] forState:UIControlStateNormal];
    [_rightBtn addTarget:self action:@selector(addAction:) forControlEvents:UIControlEventTouchUpInside];
    [_rightBtn setFrame:CGRectMake(SCREEN_WIDTH - 5 - 33, 25, 33, 33)];
    _rightBtn.hidden = YES;
    [self settingWGRightBarButtonItem:_rightBtn];
    
    [self initPageViewControllers];
    //[self loadPageViewController];
}

- (void)backAction:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark Private Method
- (void)addAction:(id)sender
{
    EditViewController *editVC = [[EditViewController alloc] init];
    [self.navigationController pushViewController:editVC animated:YES];
}

- (void)initPageViewControllers
{
    _menuView = [[NewsMenuListView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, 50.0) menus:@[@"头条",@"中国",@"广州",@"我的社区",@"个人发表"] delegate:self];
    [_menuView setSelectedIndex:0];
    [self.view addSubview:_menuView];
    _contentView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 108.0, SCREEN_WIDTH, self.view.bounds.size.height - 108.0)];
    _contentView.delegate = self;
    _contentView.pagingEnabled = YES;
    [_contentView setContentSize:CGSizeMake(_contentView.bounds.size.width * _menuView.menus.count, 0)];
//    _contentView.showsHorizontalScrollIndicator = NO;
    _contentView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_contentView];
    
    _pageViews = @[@"HotNewsViewController",@"InternationalViewController",@"CityNewsViewController",@"CommunityNewsViewController",@"PersonalPublishList"];
    _pageViewDic = [[NSMutableDictionary alloc] initWithCapacity:0];
    NSUInteger index = self.currentChapter == CommunityNewsList?3:0;
    [self changeMenuItem:_menuView didSelectedIndex:index];
    [self showPageView:index];
}

- (SHViewController *)willLoadNextPageViewController:(NSUInteger)index
{
    NSString *pageName = _pageViews[index];
    SHViewController *nextPageVC = (SHViewController *)_pageViewDic[pageName];
    if (nextPageVC == nil) {
        nextPageVC = (SHViewController *)[[NSClassFromString(pageName) alloc] init];
        nextPageVC.delegate = self;
        nextPageVC.view.tag = index + PageView_Tag;
        [nextPageVC.view setFrame:CGRectMake(index * _contentView.bounds.size.width, 0, _contentView.bounds.size.width, _contentView.bounds.size.height)];
        [_pageViewDic setObject:nextPageVC forKey:pageName];
    }
    return nextPageVC;
}

/**
 *  @desc 加载当前页
 *
 *  @param index
 */
- (void)showPageView:(NSUInteger)index
{
    _rightBtn.hidden = (index==_pageViews.count -1)?NO:YES;
    [self goPageView:index];
    SHViewController *curVC = [self willLoadNextPageViewController:index];
    if ([_contentView viewWithTag:curVC.view.tag]) {
        return;
    }
    [_contentView addSubview:curVC.view];
}

/**
 *  @desc 直接翻开到指定页
 *
 *  @param index
 */
- (void)goPageView:(NSUInteger)index
{
    CGPoint contentOffset = CGPointMake(index * _contentView.bounds.size.width, 0);
    [_contentView setContentOffset:contentOffset animated:YES];
    
    CGFloat contentWidth = _menuView.menuScro.contentSize.width;
    CGFloat offSet = contentWidth - SCREEN_WIDTH;
    if (offSet > 0 && index >= _menuView.menus.count - 2) {
        [_menuView.menuScro setContentOffset:CGPointMake(offSet, 0) animated:YES];
    } else if (index <= 1) {
        [_menuView.menuScro setContentOffset:CGPointMake(0, 0) animated:YES];
    }
}

/**
 *  @desc 修改Item
 *
 *  @param index
 */
- (void)changeMenuItem:(NewsMenuListView *)itemSuperView didSelectedIndex:(NSUInteger)selectedIndex
{
    if (itemSuperView.selectedIndex != selectedIndex) {
        UIButton *curItem = (UIButton *)[itemSuperView.menuScro viewWithTag:itemSuperView.selectedIndex];
        curItem.selected = NO;
        itemSuperView.selectedIndex = selectedIndex;
        UIButton *selItem = (UIButton *)[itemSuperView.menuScro viewWithTag:itemSuperView.selectedIndex];
        selItem.selected = YES;
    } else {
        return;
    }
}

#pragma mark CommonSelectedRowDelegate
- (void)tableView:(UITableView *)tableView didSelectedRowAtIndexPath:(NSIndexPath *)indexPath viewController:(UIViewController *)superviewController dataSource:(NSArray *)dataSource
{
//    if ([superviewController isKindOfClass:[CommunityNewsViewController class]]) {
//        
//    } else if ([superviewController isKindOfClass:[PersonalPublishList class]]){
//        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
//        if ([cell isKindOfClass:[SWTableViewCell class]]) {
//            HSListModel = ((SWTableViewCell *)cell).HSListModel;
//        }
//    } else {
//        HSListModel = (HSList *)dataSource[indexPath.row];
//    }
    HSList *HSListModel = (HSList *)dataSource[indexPath.row];
    ImsseeInstance *imsseeInstance = [ImsseeInstance shareInstance];
    imsseeInstance.HSList = HSListModel;
    
    CDVViewController *newsDetailVC = [[CDVViewController alloc] init];
    newsDetailVC.wwwFolderName = @"www/imssee/news";
    newsDetailVC.startPage = @"newsDetail.html";
    [self.navigationController pushViewController:newsDetailVC animated:YES];
    newsDetailVC = nil;
}

- (void)tableView:(UITableView *)tableView extendBtnClickAtIndexPath:(NSIndexPath *)indexPath viewController:(UIViewController *)superviewController
{
    if ([superviewController isKindOfClass:[PersonalPublishList class]]) {
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        HSList *HSListModel = nil;
        if ([cell isKindOfClass:[SWTableViewCell class]]) {
            HSListModel = ((SWTableViewCell *)cell).HSListModel;
        }
        EditViewController *editVC = [[EditViewController alloc] init];
        editVC.HSListModel = HSListModel;
        [self.navigationController pushViewController:editVC animated:YES];
    }
}

#pragma mark NewsMenuDelegate
- (void)menuItemClick:(NewsMenuListView *)itemSuperView didSelectedIndex:(NSUInteger)selectedIndex
{
    [self changeMenuItem:itemSuperView didSelectedIndex:selectedIndex];
    [self showPageView:selectedIndex];
}

#pragma mark UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat screenWidh = SCREEN_WIDTH;
    CGPoint contentPoint = scrollView.contentOffset;
    NSUInteger index = contentPoint.x/screenWidh;
    [self changeMenuItem:_menuView didSelectedIndex:index];
    [self showPageView:index];
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

