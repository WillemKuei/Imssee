//
//  CommentViewController.m
//  imssee
//
//  Created by imsseeios3 on 15/3/2.
//  Copyright (c) 2015年 鑫易. All rights reserved.
//

#import "CommentViewController.h"
#import "CommentListCell.h"
#import "CommentModel.h"

@interface CommentViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITextField *_textField;
    __block UITableView *_commentList;
    NSUInteger _pageNo;
    __block NSMutableArray *_dataSource;
    UILabel *_tipsLab;
    __block TitleView *_titleView;
}

@end

@implementation CommentViewController

#pragma mark LifeCycle
- (void)dealloc
{
    Release(_textField);
    Release(self.newsId);
    Release(_commentList);
    Release(_dataSource);
    Release(_tipsLab);
    Release(_titleView);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavTitle:@"社缘"];
    
    [self initCommentView];
    [self setupRefresh];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showKeyboard:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hideKeyboard:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark Private Method
- (void)initCommentView
{
    UIView *buttomView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height - 50, self.view.bounds.size.width, 50)];
    buttomView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:buttomView];
    
    _textField = [[UITextField alloc] initWithFrame:CGRectMake(10, 8, buttomView.frame.size.width - 80, 34)];
    _textField.layer.borderColor = LIGHT_GRAY_COLOR.CGColor;
    _textField.layer.borderWidth = 1.0f;
    _textField.layer.cornerRadius = 3.0f;
    _textField.layer.masksToBounds = YES;
    _textField.placeholder = @"我也说两句";
    [buttomView addSubview:_textField];
    
    UIButton *submitBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [submitBtn setFrame:CGRectMake(buttomView.frame.size.width - 60, 8, 50, 34)];
    [submitBtn setBackgroundColor:PinkColor];
    [submitBtn setTitle:@"发表" forState:UIControlStateNormal];
    [submitBtn setTitleColor:WHITE_COLOR forState:UIControlStateNormal];
    submitBtn.titleLabel.font = [UIFont fontWithName:@"Arial" size:18.f];
    [submitBtn addTarget:self action:@selector(submitComment:) forControlEvents:UIControlEventTouchUpInside];
    submitBtn.layer.cornerRadius = 3.0;
    [buttomView addSubview:submitBtn];
    
    _titleView = [[TitleView alloc] initTitleViewWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 64)];
    _titleView.titleLab.text = self.title;
    
    _commentList = [[UITableView alloc] initWithFrame:CGRectMake(8, 64, self.view.bounds.size.width - 16, self.view.bounds.size.height - 114) style:UITableViewStylePlain];
    _commentList.dataSource = self;
    _commentList.delegate = self;
    _commentList.rowHeight = 96;
    _commentList.tableHeaderView = _titleView;
    _commentList.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_commentList];
    
    _dataSource = [[NSMutableArray alloc] initWithCapacity:0];
    
    __block UITextField *blockTF = _textField;
    self.view.tapAction = ^(UITapGestureRecognizer *tap){
        [blockTF resignFirstResponder];
    };
}

- (void)setupRefresh
{
    [_commentList addHeaderWithTarget:self action:@selector(headerRefreshing)];
#warning 自动刷新一次
    [_commentList headerBeginRefreshing];
    [_commentList addFooterWithTarget:self action:@selector(footerRefreshing)];
    
    _commentList.headerPullToRefreshText = @"下拉即可刷新";
    _commentList.headerReleaseToRefreshText = @"松开马上刷新";
    _commentList.headerRefreshingText = @"正在刷新...";
    
    _commentList.footerPullToRefreshText = @"查看更多评论";
    _commentList.footerReleaseToRefreshText = @"松开加载更多评论";
    _commentList.footerRefreshingText = @"正在刷新...";
}

- (void)headerRefreshing
{
    _pageNo = 0;
    __block CommentViewController *blockSelf = self;
    [self requestCommentListData:^(NSArray *comments){
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [_dataSource removeAllObjects];
            [blockSelf analyzeCommentListData:comments];
            [_commentList headerEndRefreshing];
        });
    }];
}

- (void)footerRefreshing
{
    _pageNo += 5;
    __block CommentViewController *blockSelf = self;
    [self requestCommentListData:^(NSArray *comments){
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [blockSelf analyzeCommentListData:comments];
            [_commentList footerEndRefreshing];
        });
    }];
}

- (void)requestCommentListData:(void(^)(NSArray *comments))completion
{
    NSDictionary *params = @{@"newsId":self.newsId};
    __block CommentViewController *blockSelf = self;
    [[HttpRequest sharedInstance] commentListDataWithParams:params
                                            completionBlock:^(id result) {
                                                DLog(@"result:%@",result);
                                                if ([result[@"ec"] integerValue] != 0) {
                                                    [WGProgressHUD showErrorWith:blockSelf.view status:@"请求失败，请重试"];
                                                    return ;
                                                }
                                                [WGProgressHUD dismissHUD];
//                                                [blockSelf analyzeCommentListData:result[@"comment"][@"result"]];
                                                _titleView.timeLab.text = result[@"news"][@"creatTime"];
                                                _titleView.commentNumberLab.text = [NSString stringWithFormat:@"%@评论",result[@"comment"][@"totalCounts"]];
                                                if (completion) {
                                                    completion(result[@"comment"][@"result"]);
                                                }
                                            }
                                               failureBlock:^(NSError *error, NSString *responseStr) {
                                                   DLog(@"Error:%@",[error localizedDescription]);
                                                   if (completion) {
                                                       completion(nil);
                                                   }
                                                   [WGProgressHUD showErrorWith:blockSelf.view status:[error localizedDescription]];
                                               }];
}

- (void)analyzeCommentListData:(NSArray *)comments
{
    if (comments.count <= 0) {
        _commentList.tableHeaderView.hidden = NO;
        return;
    }
    
    for (int i = 0; i < [comments count]; i++) {
        NSDictionary *param = comments[i];
        CommentModel *commentModel = [[CommentModel alloc] initCommentModelWithParams:param];
        [_dataSource addObject:commentModel];
    }
    
    [_commentList reloadData];
}

- (void)showKeyboard:(NSNotification *)notification
{
    [UIView animateWithDuration:0.2 animations:^{
        CGPoint center = self.view.center;
        center = CGPointMake(center.x, center.y - 255);
        self.view.center = center;
    }];
}

- (void)hideKeyboard:(NSNotification *)notification
{
    [UIView animateWithDuration:0.2 animations:^{
        CGPoint center = self.view.center;
        center = CGPointMake(center.x, center.y + 255);
        self.view.center = center;
    }];
}

#pragma mark User Action
- (void)submitComment:(id)sender
{
    if (_textField.text.length <= 0) {
        [UIHelper alertWithTitle:@"温馨提示" andMSG:@"评论内容不能为空"];
        return;
    }
    [_textField resignFirstResponder];
    ImsseeInstance *imsseeInstance = [ImsseeInstance shareInstance];
    NSString *memberId = [NSString stringWithFormat:@"%ld",imsseeInstance.userInfo.memberId];
    NSString *newsId = self.newsId;
    NSString *context = _textField.text;
    NSDictionary *params = @{@"memberId":memberId,@"newsId":newsId,@"context":context};
    __block CommentViewController *blockSelf = self;
    [WGProgressHUD showHUDAddedTo:self.view status:@""];
    [[HttpRequest sharedInstance] submitCommentWithParams:params
                                          completionBlock:^(id result) {
                                              if ([result[@"ec"] integerValue] != 0) {
                                                  [WGProgressHUD showErrorWith:blockSelf.view status:@"请求失败，请重试"];
                                                  return ;
                                              }
                                              
                                              [WGProgressHUD showSuccessWith:blockSelf.view status:@"评论成功"];
                                              [_commentList headerBeginRefreshing];
                                          }
                                             failureBlock:^(NSError *error, NSString *responseStr) {
                                                 [WGProgressHUD showErrorWith:blockSelf.view status:@"请求失败，请重试"];
                                             }];
    
    _textField.text = @"";
}

#pragma mark UITableViewDataSource And UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 96;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_dataSource count] != 0?[_dataSource count]:0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"";
    CommentListCell *cell = (CommentListCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = (CommentListCell *)[[[NSBundle mainBundle] loadNibNamed:@"CommentListCell" owner:nil options:nil] lastObject];
    }
    
    CommentModel *commentModel = (CommentModel *)_dataSource[indexPath.row];
    [cell configureCellWithCommentModel:commentModel];
    return cell;
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


@implementation TitleView

- (instancetype)initTitleViewWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self loadTitleView];
    }
    return self;
}

- (void)loadTitleView
{
    CGRect frame = self.frame;
    UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(8, 0, frame.size.width - 16, 30)];
    titleLab.font = [UIFont systemFontOfSize:20.f];
    self.titleLab = titleLab;
    [self addSubview:self.titleLab];
    
    UILabel *timeLab = [[UILabel alloc] initWithFrame:CGRectMake(8, 30, 100, 20)];
    timeLab.font = [UIFont systemFontOfSize:14.f];
    timeLab.textColor = LIGHT_GRAY_COLOR;
    timeLab.text = @"yyyy-MM-dd";
    self.timeLab = timeLab;
    [self addSubview:self.timeLab];
    
    UILabel *commentNumberLab = [[UILabel alloc] initWithFrame:CGRectMake(116, 30, 60, 20)];
    commentNumberLab.font = [UIFont systemFontOfSize:14.f];
    commentNumberLab.textColor = LIGHT_GRAY_COLOR;
    commentNumberLab.text = @"0评论";
    self.commentNumberLab = commentNumberLab;
    [self addSubview:self.commentNumberLab];
}

@end
