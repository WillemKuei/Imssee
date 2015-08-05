//
//  CommunityNewsViewController.m
//  imssee
//
//  Created by 鑫易 on 15/2/2.
//  Copyright (c) 2015年 鑫易. All rights reserved.
//

#import "CommunityNewsViewController.h"
#import "CommunityNewsCell.h"
#import "HSList.h"

@interface CommunityNewsViewController ()<CommunityNewsListDataSource,CommunityNewsListDelegate>
{
    NSMutableArray *_dataSource;
    __block CommunityNewsListView *_listView;
    NSInteger _pageNo;
}

@end

@implementation CommunityNewsViewController

#pragma mark LifeCycle
- (void)dealloc
{
    Release(_dataSource);
    Release(_listView);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    SettingPageViewFrame
    self.view.backgroundColor = [UIColor orangeColor];
    [self initCommunityNewsView];
    [self setupRefresh];
//    [WGProgressHUD showTipsWith:self.view status:@"亲,没有最新数据了！"];
//    [self requestCommunityData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark Private Method
- (void)initCommunityNewsView
{
    _dataSource = [[NSMutableArray alloc] initWithCapacity:0];
    _listView = [[CommunityNewsListView alloc] initWithFrame:self.view.bounds dataSourceOrDelegate:self];
    [self.view addSubview:_listView];
}

- (void)setupRefresh
{
    [_listView.listView addHeaderWithTarget:self action:@selector(headerRefreshing)];
#warning 自动刷新一次
    [_listView.listView headerBeginRefreshing];
    
    [_listView.listView addFooterWithTarget:self action:@selector(footerRefreshing)];
    
    _listView.listView.headerPullToRefreshText = @"下拉即可刷新";
    _listView.listView.headerReleaseToRefreshText = @"松开马上刷新";
    _listView.listView.headerRefreshingText = @"正在刷新...";
    
    _listView.listView.footerPullToRefreshText = @"下拉加载更多";
    _listView.listView.footerReleaseToRefreshText = @"松开加载更多数据";
    _listView.listView.footerRefreshingText = @"正在刷新...";
}

- (void)headerRefreshing
{
    _pageNo = 0;
    [self requestCommunityData:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [_listView.listView headerEndRefreshing];
            [_listView reloadListData];
        });
    }];
}

- (void)footerRefreshing
{
    _pageNo += 5;
    [self requestCommunityData:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [_listView.listView footerEndRefreshing];
            [_listView reloadListData];
        });
    }];
}

- (void)requestCommunityData:(void(^)(void))completion
{
    NSDictionary *params = @{@"communityId":@"1",@"authorId":[NSString stringWithFormat:@"%ld",_pageNo],@"pageNo":[NSString stringWithFormat:@"%ld",_pageNo]}; //TODO:测试数据传1
//    [WGProgressHUD showHUDAddedTo:self.view status:@"请稍后"];
    __weak CommunityNewsViewController *blockSelf = self;
    [[HttpRequest sharedInstance] communityNewsListWithParams:params
                                              completionBlock:^(id result) {
                                                  DLog(@"Result:%@",result);
                                                  if ([result[@"ec"] doubleValue] != 0) {
                                                      if (completion) {
                                                          completion();
                                                      }
                                                      [WGProgressHUD showErrorWith:self.view status:@"请求失败"];
                                                      return;
                                                  }
                                                  NSArray *datas = (NSArray *)result[@"result"];
                                                  [blockSelf analyzeDataSource:datas];
                                                  if (completion) {
                                                      completion();
                                                  }
//                                                  [WGProgressHUD showSuccessWith:blockSelf.view status:@"请求成功"];
    }
                                                 failureBlock:^(NSError *error, NSString *responseStr) {
                                                     if (completion) {
                                                         completion();
                                                     }
                                                     [WGProgressHUD showErrorWith:self.view status:@"请求失败"];
                                                 }];
}

- (void)analyzeDataSource:(NSArray *)data
{
    if (data.count <= 0) {
        [WGProgressHUD showTipsWith:self.view status:@"亲,没有最新数据了！"];
        return;
    }
    
    for (NSDictionary *dic in data) {
        HSList *listModel = [[HSList alloc] initWithDictionary:dic];
        [_dataSource addObject:listModel];
    }
    [_listView reloadListData];
}

#pragma mark CommunityNewsListDataSource Method
- (CGFloat)comTableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

- (NSInteger)comTableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_dataSource count];
}

- (UITableViewCell *)comTableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"identifier";
    CommunityNewsCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = (CommunityNewsCell *)[[[NSBundle mainBundle] loadNibNamed:@"CommunityNewsCell" owner:nil options:nil] lastObject];
    }
    
    HSList *listModel = (HSList *)_dataSource[indexPath.row];
    [cell reloadCmmunityData:listModel];
    
    return cell;
}

#pragma mark CommunityNewsListDelegate Method
- (void)comTableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    [UIHelper alertWithTitle:@"点击提示" andMSG:[NSString stringWithFormat:@"点击了row:%ld",(long)indexPath.row]];
    [self.delegate tableView:tableView didSelectedRowAtIndexPath:indexPath viewController:self dataSource:_dataSource];
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




@implementation CommunityNewsListView
- (instancetype)initWithFrame:(CGRect)frame dataSourceOrDelegate:(id)sender
{
    self = [super initWithFrame:frame];
    if (self) {
        self.dataSource = sender;
        self.delegate = sender;
        [self loadListView];
    }
    return self;
}

- (void)loadListView
{
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    self.listView = tableView;
    [self addSubview:self.listView];
}

- (void)reloadListData
{
    [self.listView reloadData];
}

#pragma mark UITableViewDataSource
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.dataSource comTableView:tableView heightForRowAtIndexPath:indexPath];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataSource comTableView:tableView numberOfRowsInSection:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.dataSource comTableView:tableView cellForRowAtIndexPath:indexPath];
}

#pragma mark UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.delegate comTableView:tableView didSelectRowAtIndexPath:indexPath];
}

@end
