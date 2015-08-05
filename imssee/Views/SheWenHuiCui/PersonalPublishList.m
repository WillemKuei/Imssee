//
//  PersonalPublishList.m
//  imssee
//
//  Created by 鑫易 on 15/1/30.
//  Copyright (c) 2015年 鑫易. All rights reserved.
//
#define Unspread @"0"
#define Spread @"1"
#define YiFaBiao 0
#define CaoGao 1
#define CheHui 2
#define cellHeight 80
#define imgWidth 80
#define imgHeight 60
#define rightImgWidth 30
#define rightImgHeight 30
#define between_Width 10
#define between_Height 10
#define img_titleWidth 10
#define titleLableHeight 30
#define subTitleHeight 20
#define timeLableHeight 20


#import "PersonalPublishList.h"
#import "SWTableViewCell.h"
#import "HttpRequest.h"
#import "HSList.h"
#import "EditViewController.h"

@interface PersonalPublishList ()<UITableViewDelegate,UITableViewDataSource,SWTableViewCellDelegate>
{
    NSMutableArray *_testArray;
    SWTableViewCell *_lastCell;
    NSMutableArray *_stateArray;
    int _page;
}
@property (nonatomic,strong) NSMutableArray *receiveDateArray;

@end

@implementation PersonalPublishList

#pragma mark -Life Cycle
- (void)dealloc
{
    Release(_testArray);
    Release(_lastCell);
    Release(_stateArray);
    Release(self.receiveDateArray);
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kRefresh_PersonalPublishList object:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.automaticallyAdjustsScrollViewInsets = NO;

    [self initPersonalPublishView];
    [self setupRefresh];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark-Private Methods
- (void)initPersonalPublishView
{
    self.tableView.rowHeight = 80;
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    
    _stateArray = [NSMutableArray array];
    _receiveDateArray = [[NSMutableArray alloc]initWithCapacity:0];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(headUpdate) name:kRefresh_PersonalPublishList object:nil];
}

- (void)setupRefresh
{
    [self.tableView addHeaderWithTarget:self action:@selector(headUpdate)];
    [self.tableView addFooterWithTarget:self action:@selector(footUpdate)];
    [self.tableView headerBeginRefreshing];
    self.tableView.headerPullToRefreshText = @"下拉查看更多";
    self.tableView.headerReleaseToRefreshText = @"松开马上刷新";
    self.tableView.headerRefreshingText = @"加载中...";
    self.tableView.footerRefreshingText = @"加载中...";
    self.tableView.footerPullToRefreshText = @"上拉加载更多";
}

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
    NSDictionary *params = @{@"authorId": [NSNumber numberWithInteger:1],@"communityId": [NSNumber numberWithInteger:1],@"pageNo":[NSNumber numberWithInt:_page]};
//    [WGProgressHUD showHUDAddedTo:self.view status:@"请稍后"];
    __weak PersonalPublishList *blockSelf = self;
    [[HttpRequest sharedInstance] personalPublishNewsListWithParams:params completionBlock:^(id result) {
        NSArray *array = result[@"result"];
        HSList *new = nil;
        HSList *reseNew = _receiveDateArray.firstObject;
        for (int i=0; i<array.count; i++) {
            new = [[HSList alloc]initWithDictionary:array[i]];
            if (reseNew.newsId == new.newsId) {
                break;
            }
            [self.receiveDateArray addObject:new];
            [_stateArray addObject:Unspread];
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
    return _receiveDateArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *indentifer = @"Cell";
    SWTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:indentifer];
    for (UIView *subView in cell.contentView.subviews)
    {
        [subView removeFromSuperview];
    }
    [cell.cellScrollView setContentOffset:CGPointMake(0, 0)];

    HSList *new = self.receiveDateArray[indexPath.row];
    if (cell == nil) {
        cell = [[SWTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:indentifer];
        NSMutableArray *rightUtilityButtons = [NSMutableArray array];
        [rightUtilityButtons addUtilityButtonWithColor:
         [UIColor colorWithRed:1.0f green:0.231f blue:0.188 alpha:1.0f]
                                                 title:@"删除"];
        [rightUtilityButtons addUtilityButtonWithColor:
         [UIColor colorWithRed:0.78f green:0.78f blue:0.8f alpha:1.0]
                                                 title:@"撤回"];
        [rightUtilityButtons addUtilityButtonWithColor:
         [UIColor colorWithRed:0.78f green:0.78f blue:0.8f alpha:1.0]
                                                 title:@"编辑"];
        cell = [[SWTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:indentifer containingTableView:tableView rightUtilityButtons:rightUtilityButtons];
        cell.delegate = self;
        
        cell.HSListModel = new;
        
    }
    if ([_stateArray[indexPath.row] isEqual:Spread] ) {
        [cell.cellScrollView setContentOffset:CGPointMake(240, 0)];
    }
    //图片
    UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(between_Width, between_Height, imgWidth, imgHeight)];
    NSString *imgPath = [new.imagePath componentsSeparatedByString:@","].firstObject;
    imgPath = [NSString stringWithFormat:@"%@%@",ImagePath_IP,imgPath];
    [imgView setImageWithURL:[NSURL URLWithString:imgPath] placeholderImage:[UIImage imageNamed:@"nav_db"]];
    [cell.contentView addSubview:imgView];
    //标题
    UILabel *titleLable = [[UILabel alloc]initWithFrame:CGRectMake(imgView.frame.size.width+between_Width+img_titleWidth, (cellHeight-titleLableHeight-subTitleHeight-timeLableHeight)/2, self.view.bounds.size.width-imgView.bounds.size.width-rightImgWidth-between_Width*4-10, titleLableHeight)];
    titleLable.font = [UIFont systemFontOfSize:17];
    titleLable.text = new.title;
    [cell.contentView addSubview:titleLable];
    //右边图标
    UIImageView * markImgView = [[UIImageView alloc]initWithFrame:CGRectMake(self.view.frame.size.width-rightImgWidth-between_Width, between_Height, rightImgWidth, rightImgHeight)];
    markImgView.tag =1000;
    if (new.publishState==0) {     //已发表
        markImgView.image = [UIImage imageNamed:@"yifabiao1"];
    }else if(new.publishState==1){ //草稿
        markImgView.image = [UIImage imageNamed:@"caogao1"];
    }else{                  //撤回
        markImgView.image = [UIImage imageNamed:@"fanhui1"];
    }
    [cell.contentView addSubview:markImgView];
    //子标题
    UILabel *subTitleLable = [[UILabel alloc]initWithFrame:CGRectMake(imgView.frame.size.width+between_Width+img_titleWidth, titleLable.frame.size.height+2, self.view.frame.size.width-imgView.frame.size.width-markImgView.bounds.size.width-between_Width*2-img_titleWidth*2, subTitleHeight)];
    subTitleLable.font = [UIFont systemFontOfSize:15];
    subTitleLable.textColor = [UIColor lightGrayColor];
    subTitleLable.text = new.titleContext;
    [cell.contentView addSubview:subTitleLable];
    //时间
    CGFloat rectY = subTitleLable.frame.origin.y+subTitleLable.frame.size.height+2;
    UILabel *timeLable = [[UILabel alloc]initWithFrame:CGRectMake(imgWidth+between_Width+img_titleWidth, rectY, 80, timeLableHeight)];
    timeLable.font = [UIFont systemFontOfSize:13];
    timeLable.textColor = [UIColor lightGrayColor];
    timeLable.text = new.creatTime;
    [cell.contentView addSubview:timeLable];
    //浏览数
    UILabel *browseLable = [[UILabel alloc]init];
    browseLable.font = [UIFont systemFontOfSize:13];
    browseLable.text = [NSString stringWithFormat:@"看 %.0f",new.browseNumber];
    browseLable.attributedText = [GlobalFunction editAttributedString:browseLable.text range:NSMakeRange(0, 2) textColor:[UIColor lightGrayColor]];
    CGFloat browseWidth = [GlobalFunction getWidthOfString:browseLable.text withSize:CGSizeMake(MAXFLOAT, 20) fontSize:browseLable.font];
    browseLable.frame =CGRectMake(imgWidth+between_Width+timeLable.bounds.size.width+img_titleWidth+20, rectY, MAX(30, browseWidth), 20);
    [cell.contentView addSubview:browseLable];
    //评论数
    UILabel *commentLable = [[UILabel alloc]init];
    commentLable.font = [UIFont systemFontOfSize:13];
    commentLable.text = [NSString stringWithFormat:@"评论 %.0f",new.commentNumber];
    commentLable.attributedText = [GlobalFunction editAttributedString:commentLable.text range:NSMakeRange(0, 2) textColor:[UIColor lightGrayColor]];
    CGFloat commentWidth = [GlobalFunction getWidthOfString:commentLable.text withSize:CGSizeMake(MAXFLOAT, 20) fontSize:commentLable.font];
    commentLable.frame = CGRectMake(browseLable.frame.origin.x+browseLable.frame.size.width+20,rectY, MAX(30, commentWidth), 20);
    [cell.contentView addSubview:commentLable];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return cellHeight;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"didSelectRowAtIndexPath %ld区%ld行",(long)indexPath.section,(long)indexPath.row);
    HSList *new = _receiveDateArray[indexPath.row];
    //eidt by WillemKuei 2015-02-28
    [self.delegate tableView:tableView didSelectedRowAtIndexPath:indexPath viewController:self dataSource:_receiveDateArray];
    
    if (new.publishState ==YiFaBiao) {
        NSLog(@"");//已发表
    }else if(new.publishState ==CaoGao){
        NSLog(@"");//草稿
    }else{
        NSLog(@"");//撤回
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1;
}

#pragma mark -SWTableViewCellDelegate
- (void)swippableTableViewCell:(SWTableViewCell *)cell didTriggerRightUtilityButtonWithIndex:(NSInteger)index {
    NSIndexPath *cellIndexPath = [self.tableView indexPathForCell:cell];
    HSList *new = _receiveDateArray[cellIndexPath.row];
    switch (index) {
        case 0:
        {
            //后台删除
            NSDictionary *params = @{@"newsId":[NSNumber numberWithDouble:new.newsId] ,@"userId": [NSNumber numberWithInt:1]};
            [[HttpRequest sharedInstance]deletePersonalPublishNewsWithParams:params completionBlock:^(id result) {
                NSLog(@"%@",result);
            } failureBlock:^(NSError *error, NSString *responseStr) {
                NSLog(@"%@",error);
            }];
            [_receiveDateArray removeObjectAtIndex:cellIndexPath.row];
            [self.tableView deleteRowsAtIndexPaths:@[cellIndexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            break;
        }
        case 1:
        {   //改变状态
            if (new.publishState==YiFaBiao) {
                NSDictionary *params = @{@"newsId":[NSNumber numberWithDouble:new.newsId] ,@"publishState":[NSNumber numberWithInt:2]};
                [[HttpRequest sharedInstance]reCallPersonalPublishNewsWithParams:params completionBlock:^(id result) {
                    [[UIHelper class]alertWithTitle:@"已撤回"];
                    new.publishState = 2;
                    [_receiveDateArray replaceObjectAtIndex:cellIndexPath.row withObject:new];
                    UIView *view = [cell.contentView.subviews.firstObject viewWithTag:1000];
                    UIImageView *markImgView = (UIImageView *)view;
                    markImgView.image = [UIImage imageNamed:@"fanhui1"];
                    [UIView beginAnimations:nil context:nil];
                    [UIView setAnimationDuration:0.5];
                    cell.cellScrollView.contentOffset = CGPointMake(0, 0);
                    [UIView commitAnimations];
                } failureBlock:^(NSError *error, NSString *responseStr) {
                    NSLog(@"%@",error);
                }];
            }else if(new.publishState==CaoGao){
                [[UIHelper class]alertWithTitle:@"草稿状态下无法撤回"];
            }else{
                [[UIHelper class]alertWithTitle:@"已撤回"];
            }
             break;
        }
        case 2:
        {   //跳转到编辑页面
            if (new.publishState==YiFaBiao) {
                NSLog(@"已发表跳转到编辑页面");
            }else if(new.publishState==CaoGao) {
                NSLog(@"草稿跳转到编辑页面");
            }else{
                NSLog(@"撤回跳转到编辑页面");
            }
            
            [self.delegate tableView:self.tableView extendBtnClickAtIndexPath:cellIndexPath viewController:self];
            
            
            break;
        }
        default:
            break;
    }
}

- (void)swippableTableViewCell:(SWTableViewCell *)cell scrollingToState:(SWCellState)state{
    if (_lastCell && _lastCell.cellScrollView.contentOffset.x>0) {
        [_lastCell.cellScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
        NSIndexPath *lastCellIndexPath = [self.tableView indexPathForCell:_lastCell];
        _stateArray[lastCellIndexPath.row]=Unspread;
    }
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    if (state == kCellStateLeft) {
        _stateArray[indexPath.row]=Spread;
    }else if(state == kCellStateRight){
        _stateArray[indexPath.row]=Unspread;
    }
    _lastCell = cell;
}

-(void)swippableTableViewCellDidPressed:(SWTableViewCell *)cell{
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    _stateArray[indexPath.row]=Unspread;
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
