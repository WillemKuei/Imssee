//
//  WuGuanFirstPageViewController.m
//  imssee
//
//  Created by app001.cn on 15-2-11.
//  Copyright (c) 2015年 鑫易. All rights reserved.
//
#define sectionTbleWidth 80
#define section_CellHeight 60
#define detail_CellHeight 40

#define index_ChargeStanderd 0
#define index_Intrduce 1

#import "WuGuanFirstPageViewController.h"
#import "SectionTableViewCell.h"
#import "PhoneListCell.h"
#import "WuGuanPersonListCell.h"
#import "HttpRequest.h"
#import "PhoneList.h"
#import "WGTabBar.h"
#import "WGUser.h"
#import "WGCharge.h"
#import "WGIntrduce.h"
#import "WGGuide.h"
#import "EditingViewController.h"

@interface WuGuanFirstPageViewController ()<UITableViewDataSource,UITableViewDelegate,UIWebViewDelegate,WGTabBarDelegate>


@end

@implementation WuGuanFirstPageViewController
#pragma mark -Life Cycle
-(void)dealloc{
    Release(self.imgArray);
    Release(self.sectionTable);
    Release(self.lastCell);
    Release(self.rightView);
    Release(self.rightTable);
    Release(self.webView);
    Release(self.phoneListArray);
    Release(self.userListArray);
    Release(self.webDataArray);
    Release(self.charge);
    Release(self.intrduce);
    Release(self.guide);
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.phoneListArray = [NSMutableArray arrayWithCapacity:0];
    self.userListArray = [NSMutableArray arrayWithCapacity:0];
    self.webDataArray = [NSMutableArray arrayWithCapacity:0];
    
    [self creatContentView];
    [self loadWGTabBar];
    
    [self tableView:self.sectionTable didSelectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -InitUI
- (void)loadWGTabBar
{
     WGTabBar *tabBar = [[WGTabBar alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT-74-49, SCREEN_WIDTH, 49) items:@[@"菜单一",@"菜单二",@"菜单三",@"菜单四",@"菜单五"]];
    [tabBar settingTabBarImage:@[@"personal.png",@"personal.png",@"personal.png",@"personal.png",@"personal.png"] selectedImage:@[@"personal_sel.png",@"personal_sel.png",@"personal_sel.png",@"personal_sel.png",@"personal_sel.png"]];
    tabBar.delegate = self;
    [self.view addSubview:tabBar];
}

-(void)creatContentView{
    UIImageView *bgImgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    bgImgView.image = [UIImage imageNamed:@"background.jpg"];
    [self.view addSubview:bgImgView];
    
    _sectionTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 80, 60*self.imgArray.count)];
    _sectionTable.dataSource = self;
    _sectionTable.delegate = self;
    [self.view addSubview:_sectionTable];
    
    _rightView = [[UIView alloc]initWithFrame:CGRectMake(80, 0, SCREEN_WIDTH-80, SCREEN_HEIGHT-74-49)];
    _rightView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_rightView];
}

//创建webView
-(void)creatWebView{
    NSLog(@"%f",_rightView.bounds.size.width);
    self.webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, _rightView.bounds.size.width, _rightView.bounds.size.height)];
    self.webView.backgroundColor = [UIColor clearColor];
    [self.rightView addSubview:self.webView];
    
    NSString * filePath = [[NSBundle mainBundle] bundlePath];
    NSURL * baseURL = [NSURL fileURLWithPath:filePath];
    NSString *path =[[NSBundle mainBundle] pathForResource:@"intrduce"ofType:@"html"inDirectory:@"www"];
    NSString * htmlString = [NSString stringWithContentsOfFile:path encoding:(NSUTF8StringEncoding) error:nil];
    [self.webView loadHTMLString:htmlString baseURL:baseURL];
}

//创建tableView
-(void)creatTableViewWithTag:(NSInteger)indexTag{
    self.rightTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, _rightView.bounds.size.width, _rightView.bounds.size.height) style:UITableViewStylePlain];
    self.rightTable.dataSource = self;
    self.rightTable.delegate = self;
    self.rightTable.tag = indexTag;
    self.rightTable.backgroundColor = [UIColor clearColor];
    [self.rightView addSubview: self.rightTable];
    
    [self.rightTable addHeaderWithTarget:self action:@selector(headUpdate)];
    [self.rightTable addFooterWithTarget:self action:@selector(footUpdate)];
    self.rightTable.headerPullToRefreshText = @"下拉查看更多";
    self.rightTable.headerReleaseToRefreshText = @"松开马上刷新";
    self.rightTable.headerRefreshingText = @"加载中...";
    self.rightTable.footerRefreshingText = @"加载中...";
    self.rightTable.footerPullToRefreshText = @"上拉加载更多";
}

#pragma mark -InitData
-(void)getTableDataWithIndex:(NSInteger)index{
    NSDictionary *params = @{@"pmId":[NSNumber numberWithInt:1],@"pageNo":[NSNumber numberWithInt:self.page]};
    [WGProgressHUD showHUDAddedTo:self.view status:@"请稍后"];
    __weak WuGuanFirstPageViewController *blockSelf = self;
    [[HttpRequest sharedInstance]wuGuanDataWithIndex:index Params:params completionBlock:^(id result) {
        NSArray *array = result[@"result"];
        [self tableDataWithArray:array index:index blockSelf:blockSelf];
    } failureBlock:^(NSError *error, NSString *responseStr) {
        NSLog(@"%@",error);
        [WGProgressHUD showErrorWith:blockSelf.view status:@"请求失败"];
    }];
}

-(void)getWebDataWithIndex:(NSInteger)index{
    NSDictionary *params = @{@"pmId":[NSNumber numberWithInt:1]};
    [WGProgressHUD showHUDAddedTo:self.view status:@"请稍后"];
    __weak WuGuanFirstPageViewController *blockSelf = self;
    [[HttpRequest sharedInstance]wuGuanWebDataWithIndex:index Params:params completionBlock:^(id result) {
        [WGProgressHUD showSuccessWith:blockSelf.view status:@"请求成功"];
        NSArray *array = result[@"result"];
        [self webDataWithArray:array webDataStyle:index blockSelf:blockSelf];
    } failureBlock:^(NSError *error, NSString *responseStr) {
        NSLog(@"%@",error);
        [WGProgressHUD showErrorWith:blockSelf.view status:@"请求失败"];
    }];
}

-(void)tableDataWithArray:(NSArray *)array index:(NSInteger)index blockSelf:(__weak UIViewController*)blockSelf{
    PhoneList *phone = nil;
    PhoneList *resePhone = self.phoneListArray.firstObject;
    WGUser *user = nil;
    WGUser *reseUser = self.userListArray.firstObject;
    for (int i=0; i<array.count; i++) {
        if (index == 0) {
            phone = [[PhoneList alloc]initWithDictionary:array[i]];
            if (resePhone.phoneId == phone.phoneId) {
                [WGProgressHUD showSuccessWith:blockSelf.view status:@"已经是最新数据"];
                [self.rightTable headerEndRefreshing];
                return ;
            }
            [self.phoneListArray addObject:phone];
            phone = nil;
        }else{
            user = [[WGUser alloc]initWithDictionary:array[i]];
            if (reseUser.userId == user.userId) {
                [WGProgressHUD showSuccessWith:blockSelf.view status:@"已经是最新数据"];
                [self.rightTable headerEndRefreshing];
                return ;
            }
            [self.userListArray addObject:user];
            user = nil;
        }
    }
    [self.rightTable headerEndRefreshing];
    [self.rightTable footerEndRefreshing];
    if ([array isEqual:@[]]) {
        [WGProgressHUD showSuccessWith:blockSelf.view status:@"数据加载完毕"];
    }else {
        [WGProgressHUD showSuccessWith:blockSelf.view status:@"请求成功"];
    }
    [self.rightTable reloadData];
}

-(void)webDataWithArray:(NSArray *)array webDataStyle:(WebDataStyle)webDataStyle  blockSelf:(__weak UIViewController*)blockSelf{
    if (webDataStyle == ChargeStyle) {
//        for (int i=0; i<array.count; i++) {
//            WGCharge *charge = [[WGCharge alloc]initWithDictionary:array[i]];
//            [self.webDataArray addObject:charge];
//        }
        self.charge = [[WGCharge alloc]initWithDictionary:array.firstObject];
        [self creatWebView];
        self.webView.tag = 0;
    }else if(webDataStyle == IntrduceStyle){
//        for (int i=0; i<array.count; i++) {
//            WGIntrduce *intrduce = [[WGIntrduce alloc]initWithDictionary:array[i]];
//            [self.webDataArray addObject:intrduce];
//        }
        self.intrduce = [[WGIntrduce alloc]initWithDictionary:array.firstObject];
        [self creatWebView];
        self.webView.tag = 1;
    }else{
//        for (int i=0; i<array.count; i++) {
//            WGGuide *guide = [[WGGuide alloc]initWithDictionary:array[i]];
//            [self.webDataArray addObject:guide];
//        }
        self.guide = [[WGGuide alloc]initWithDictionary:array.firstObject];
        [self creatWebView];
        self.webView.tag = 2;
    }
    self.webView.delegate = self;
}

#pragma mark -用户操作
-(void)headUpdate{
    self.page =1;
    [self getTableDataWithIndex:self.index];
}

-(void)footUpdate{
    self.page ++;
    [self getTableDataWithIndex:self.index];
}

-(void)phoneBtnClicked:(UIButton *)btn{
    NSLog(@"点击了第%ld个phoneBtn",(long)btn.tag);
    [UIHelper alertWithMsg:@"物管界面点击phone" delegate:self andTag:0];
}

#pragma mark -UIWebViewDelegate
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    NSString *meta = [NSString stringWithFormat:@"document.getElementsByName(\"viewport\")[0].content = \"width=%f, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no\"", webView.frame.size.width];
    [webView stringByEvaluatingJavaScriptFromString:meta];
    NSString *js = nil;
    if (webView.tag == ChargeStyle) {
        js = [NSString stringWithFormat:@"document.write(\"<p style='text-indent: 2em'>%@</p><img id='img' style='left:10px' src='http://ww4.sinaimg.cn/thumbnail/8e88b0c1gw1e9lpr1d0vyj20pf0gytcj.jpg' width='%f'  height='100' />\");",self.charge.pmContext,self.webView.bounds.size.width-16];
        
    }else if(webView.tag == IntrduceStyle){
//        NSString *appendString = @"";
//        for (int i=0; i<self.webDataArray.count; i++) {
//            WGIntrduce *intrduce = self.webDataArray[i];
//            NSLog(@"%@",intrduce.intro);
//            appendString  = [appendString stringByAppendingFormat:@"%@",intrduce.intro];
//            NSLog(@"%@",appendString);
//        }
//        NSLog(@"%@",appendString);
//        js = [NSString stringWithFormat:@"document.write(\"%@\");",appendString];
//        NSLog(@"%@",js);
        self.intrduce.intro = [self.intrduce.intro stringByReplacingOccurrencesOfString:@"\r" withString:@""];
        self.intrduce.intro = [self.intrduce.intro stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        js = [NSString stringWithFormat:@"document.write(\"%@\");",self.intrduce.intro];
    }else{
//        NSString *appendString = @"";
//        for (int i=0; i<self.webDataArray.count; i++) {
//            WGGuide *guide = self.webDataArray[i];
//            guide.guideContext = [guide.guideContext stringByReplacingOccurrencesOfString:@"\r" withString:@""];
//            appendString  = [appendString stringByAppendingFormat:@"%@",guide.guideContext];
//            appendString = [appendString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
//        }
//        js = [NSString stringWithFormat:@"document.write(\"%@\");",appendString];
//        NSLog(@"%@",js);
        js = [NSString stringWithFormat:@"document.write(\"%@\");",self.guide.guideContext];
    }
    [webView stringByEvaluatingJavaScriptFromString:js];
    [self.webDataArray removeAllObjects];
}

#pragma mark -WGTabBarDelegate
- (void)WGTabBar:(WGTabBar *)wgTabBar didSelectedItem:(id)selectedItem{
    NSLog(@"didSelectedItem");
}

#pragma mark -UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",alertView.message]]];
    }
}

#pragma mark -UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView.tag == 0) {
        return self.imgArray.count;
    }else if(tableView.tag == 0+10){
        return self.phoneListArray.count;
    }else{
        return self.userListArray.count;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView.tag == 0) {
        static NSString *indentifer = @"SectionTableCell";
        SectionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:indentifer];
        if (cell == nil) {
            cell =[[[NSBundle mainBundle] loadNibNamed:@"SectionTableViewCell" owner:nil options:nil] lastObject];
        }
        cell.imgView.image = [UIImage imageNamed:self.imgArray[indexPath.row][0]];
        if (indexPath.row == 0) {
            self.lastCell = cell;
            cell.imgView.image = [UIImage imageNamed:self.imgArray[indexPath.row][1]];
            cell.lable.textColor = PinkColor;
        }
        cell.lable.text = self.imgArray[indexPath.row][2];
        return cell;
    }else if (tableView.tag == 0+10) {
        static NSString *indentifer = @"PhoneCell";
        PhoneListCell *cell = [tableView dequeueReusableCellWithIdentifier:indentifer];
        if (cell == nil) {
            cell = [[NSBundle mainBundle] loadNibNamed:@"PhoneListCell" owner:nil options:nil].lastObject;
        }
        PhoneList *phone = self.phoneListArray[indexPath.row];
        cell.sectionLable.text = phone.deptName;
        cell.phoneNumberLable.text = phone.phoneNumber;
        cell.phoneBtn.tag = indexPath.row;
        [cell.phoneBtn setBackgroundImage:[UIImage imageNamed:@"phone2"] forState:UIControlStateNormal];
        [cell.phoneBtn addTarget:self action:@selector(phoneBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }else{
        WuGuanPersonListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PersonCell"];
        if (cell == nil) {
            cell = [[NSBundle mainBundle] loadNibNamed:@"WuGuanPersonListCell" owner:nil options:nil].lastObject;
        }
        WGUser *user = self.userListArray[indexPath.row];
        [cell.headerImgView setImageWithURL:[NSURL URLWithString:user.photo] placeholderImage:[UIImage imageNamed:@"nav_db"]];
        cell.nameLable.text = user.userName;
        cell.positionLable.text = user.position;
        return cell;
    }
    return 0;
}

#pragma mark -UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"点击了table %ld",(long)tableView.tag);
    if (tableView.tag==0) {
        [self sectionTableChangeColor:tableView indexPath:indexPath];
        for (UIView *view in self.rightView.subviews) {
            [view removeFromSuperview];
        }
        if (indexPath.row == 0) {
            [self.phoneListArray removeAllObjects];
            [self creatTableViewWithTag:indexPath.row+10];
            [self getTableDataWithIndex:0];
            self.index = 0;
        }else if (indexPath.row == 1){
            [self.userListArray removeAllObjects];
            [self creatTableViewWithTag:indexPath.row+10];
            [self getTableDataWithIndex:1];
            self.index = 1;
        }else if(indexPath.row == 2){
            [self getWebDataWithIndex:index_ChargeStanderd];
        }else if(indexPath.row == 3){
            [self getWebDataWithIndex:index_Intrduce];
        }else{
            NSLog(@"跳转到群发界面");
            EditingViewController *editingVC = [[EditingViewController alloc]init];
            editingVC.title = @"物管";
            [self presentViewController:editingVC animated:NO completion:nil];
        }
    }else{
        NSLog(@"电话详情");
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView.tag == 0) {
        return section_CellHeight;
    }else{
        return detail_CellHeight;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0;
}

#pragma mark -Private Methods
-(void)sectionTableChangeColor:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath{
    SectionTableViewCell *cell = (SectionTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    if (self.lastCell != cell) {
        NSIndexPath *lastIndexpath = [tableView indexPathForCell:self.lastCell];
        self.lastCell.imgView.image = [UIImage imageNamed:self.imgArray[lastIndexpath.row][0]];
        self.lastCell.lable.textColor = [UIColor blackColor];
    }
    self.lastCell = cell;
    cell.imgView.image = [UIImage imageNamed:self.imgArray[indexPath.row][1]];
    cell.lable.textColor =PinkColor;
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
