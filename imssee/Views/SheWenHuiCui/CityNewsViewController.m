//
//  CityNewsViewController.m
//  imssee
//
//  Created by 鑫易 on 15/2/2.
//  Copyright (c) 2015年 鑫易. All rights reserved.
//
#define liuYan_width 20
#define liuYan_height 20
#define sheQuLable_height 20
#define cell_height 80
#define imgWidth 80
#define imgHeight 60
#define titleLableHeight 30
#define subTitleHeight 20
#define xiaoQuHeight 20

#import "CityNewsViewController.h"
#import "HSList.h"

@interface CityNewsViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    int _page;
}
@property (strong, nonatomic)UITableView *tableView;
@property (nonatomic,strong)NSMutableArray *receiveDateArray;

@end

@implementation CityNewsViewController
@synthesize tableView=_tableView;

#pragma mark -Life Cycle
-(void)dealloc{
    Release(self.tableView);
    Release(self.receiveDateArray);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.automaticallyAdjustsScrollViewInsets = NO;
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height-64-44)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    _receiveDateArray = [[NSMutableArray alloc]initWithCapacity:0];

    [self.tableView addHeaderWithTarget:self action:@selector(headUpdate)];
    [self.tableView addFooterWithTarget:self action:@selector(footUpdate)];
    self.tableView.headerPullToRefreshText = @"下拉查看更多";
    self.tableView.headerReleaseToRefreshText = @"松开马上刷新";
    self.tableView.headerRefreshingText = @"加载中...";
    self.tableView.footerRefreshingText = @"加载中...";
    self.tableView.footerPullToRefreshText = @"上拉加载更多";
   // [self.tableView headerBeginRefreshing];
    [self headUpdate];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark-Private Methods
-(void)headUpdate{
    _page =1;
    [self getNewsListData];
}

-(void)footUpdate{
    _page ++;
    [self getNewsListData];
}

-(void)getNewsListData
{
    NSDictionary *params = @{@"cityId": [NSNumber numberWithInteger:1],@"pageNo":[NSNumber numberWithInt:_page]};
    [WGProgressHUD showHUDAddedTo:self.view status:@"请稍后"];
    __weak CityNewsViewController *blockSelf = self;
    [[HttpRequest sharedInstance] cityNewsListWithParams:params completionBlock:^(id result) {
        NSArray *array = result[@"result"];
        HSList *new = nil;
        HSList *reseNew = _receiveDateArray.firstObject;
        for (int i=0; i<array.count; i++) {
            new = [[HSList alloc]initWithDictionary:array[i]];
            if (reseNew.newsId == new.newsId) {
                break;
            }
            [self.receiveDateArray addObject:new];
        }
        [self.tableView headerEndRefreshing];
        [self.tableView footerEndRefreshing];
        if ([result[@"result"] isEqual:@[]]) {
            [WGProgressHUD showSuccessWith:blockSelf.view status:@"数据加载完毕"];
        }else if (reseNew.newsId == new.newsId){
            [WGProgressHUD showSuccessWith:blockSelf.view status:@"已经是最新数据"];
        }else{
            [WGProgressHUD showSuccessWith:blockSelf.view status:@"请求成功"];
        }
        [self.tableView reloadData];
    } failureBlock:^(NSError *error, NSString *responseStr) {
        NSLog(@"%@",error);
        [WGProgressHUD showErrorWith:blockSelf.view status:@"请求失败"];
    }];
}

#pragma mark -UITableViewDelegate,DataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.receiveDateArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *indentifer = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:indentifer];
    for (UIView *view in cell.contentView.subviews) {
        [view removeFromSuperview];
    }
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indentifer];
    }
    HSList *new = _receiveDateArray[indexPath.row];
    NSString *imgPath = [new.imagePath componentsSeparatedByString:@","].firstObject;
    imgPath = [NSString stringWithFormat:@"%@%@",ImagePath_IP,imgPath];
    //图片
    UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, imgWidth, imgHeight)];
    [imgView setImageWithURL:[NSURL URLWithString:imgPath] placeholderImage:[UIImage imageNamed:@"nav_db"]];
    [cell.contentView addSubview:imgView];
    //time
    UILabel *timeLable = [[UILabel alloc]init];
    timeLable.font = [UIFont systemFontOfSize:12];
    timeLable.textAlignment = NSTextAlignmentRight;
    timeLable.textColor = [UIColor lightGrayColor];
    timeLable.text = new.creatTime;
    CGFloat timeLableWidth = [GlobalFunction getWidthOfString:timeLable.text withSize:CGSizeMake(MAXFLOAT, 20) fontSize:timeLable.font];
    timeLable.frame = CGRectMake(self.view.bounds.size.width-timeLableWidth-10, 10, timeLableWidth, 20);
    [cell.contentView addSubview:timeLable];
    //评论
    CGFloat betweenTop =(cell_height-titleLableHeight-subTitleHeight-xiaoQuHeight)/2;
    UILabel *commentLable = [[UILabel alloc]init];
    commentLable.font = [UIFont systemFontOfSize:12];
    commentLable.textAlignment = NSTextAlignmentRight;
    commentLable.textColor = [UIColor lightGrayColor];
    commentLable.text = [NSString stringWithFormat:@"评论 %.0f",new.commentNumber];
    CGFloat commentLableWidth = [GlobalFunction getWidthOfString:commentLable.text withSize:CGSizeMake(MAXFLOAT, 20) fontSize:commentLable.font];
    commentLable.frame = CGRectMake(self.view.bounds.size.width-commentLableWidth-10, cell_height-betweenTop-20, commentLableWidth, 20);
    [cell.contentView addSubview:commentLable];
    //标题
    UILabel *titleLable = [[UILabel alloc]initWithFrame:CGRectMake(imgView.frame.size.width+20, betweenTop, self.view.frame.size.width-imgView.frame.size.width-timeLable.bounds.size.width-30, titleLableHeight)];
    titleLable.font = [UIFont systemFontOfSize:16];
    titleLable.numberOfLines = 0;
    titleLable.text = new.title;
    [cell.contentView addSubview:titleLable];
    //子标题
    UILabel *subTitleLable = [[UILabel alloc]initWithFrame:CGRectMake(imgView.frame.size.width+20, titleLable.frame.size.height+betweenTop, self.view.frame.size.width-imgView.frame.size.width-commentLable.bounds.size.width-30, subTitleHeight)];
    subTitleLable.font = [UIFont systemFontOfSize:13];
    subTitleLable.textColor = [UIColor lightGrayColor];
    subTitleLable.text = new.titleContext;
    [cell.contentView addSubview:subTitleLable];
    //小区
    UILabel *sheQuLable = [[UILabel alloc]initWithFrame:CGRectMake(imgView.frame.size.width+20, titleLableHeight+subTitleHeight+betweenTop, 150, 20)];
    sheQuLable.text = [NSString stringWithFormat:@"小区: %@",new.communityName];
    sheQuLable.textColor = [UIColor lightGrayColor];
    sheQuLable.font = [UIFont systemFontOfSize:13];
    [cell.contentView addSubview:sheQuLable];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return cell_height;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.delegate tableView:tableView didSelectedRowAtIndexPath:indexPath viewController:self dataSource:self.receiveDateArray];
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
