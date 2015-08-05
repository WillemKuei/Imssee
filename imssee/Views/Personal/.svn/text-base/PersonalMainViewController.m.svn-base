//
//  PersonalMainViewController.m
//  imssee
//
//  Created by 鑫易 on 15/1/29.
//  Copyright (c) 2015年 鑫易. All rights reserved.
//
#define topCellHeight 80
#define cellHeight 50
#define rightWidth 40
#define sheQuImgWidth 40
#define sheQuImgHeight 30
#define fenXiangImgWidth 35
#define fenXiangImgHeight 30
#define toolImgWidth 25
#define toolImgHeight 25

#import "PersonalMainViewController.h"
#import "PersonalPublishList.h"
#import "SHBadgeImage.h"
#import "PersonalTopCell.h"
#import "PersonalListViewCell.h"

@interface PersonalMainViewController ()<PersonalListViewCellDelegate>
{
    NSArray *_titleArray;
    NSArray *_toolsImgArray;
}
@end

@implementation PersonalMainViewController

#pragma mark -Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:[UIHelper headerViewWithImage:[UIImage imageNamed:@"nav_db.png"] title:@"社缘" target:self leftItemAction:nil rightItemAction:nil]];
    
    _titleArray = @[@[@"我的社区",@"wodeshequ"],@[@"我的分享",@"fenxiang"],@[@"我的提醒",@"tixing"],@[@"常用",@"changyong"],@[@"钱库",@"qianku"],@[@"设置",@"shezhi"]];
    _toolsImgArray = @[@"jishiben@2x",@"dianhua@2x",@"rili@2x",];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        return 1;
    }else{
        return 6;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *indentifer = @"Cell";
    PersonalListViewCell *cell = [tableView dequeueReusableCellWithIdentifier:indentifer];
    if (indexPath.section==0) {
        PersonalTopCell * cell = [[[NSBundle mainBundle] loadNibNamed:@"PersonalTopCell" owner:nil options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.imgView.image = [UIImage imageNamed:@"nav_db"];
        cell.sheYuanHaoLable.textColor = PinkColor;
        cell.nameLable.text = @"静无言2015";
        cell.sheYuanHaoLable.text = @"sheshe";
        [GlobalFunction radiusImageView:cell.imgView radius:5];
        return cell;
    }
    if (cell == nil) {
        cell = [[PersonalListViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indentifer];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.delegae = self;
    }
    cell.imgView.image = [UIImage imageNamed:_titleArray[indexPath.row][1]];
    cell.title = _titleArray[indexPath.row][0];
    cell.badgeValue = @"0";

    if (indexPath.row==0) {
        cell.sheQuImgArray = @[@[@"nav_db",@"聚宝苑"],@[@"nav_db",@"某某小区"]];
        }
    if (indexPath.row==1) {
        cell.fenXiangImgArray = @[@"nav_db",@"nav_db"];
    }
    if (indexPath.row==2) {
        cell.badgeValue = @"1";
        cell.tiXingText = @"生日快乐";
    }
    if (indexPath.row==3) {
        cell.toolsArray = _toolsImgArray;
    }
    return cell;
}

#pragma mark -UITableViewDataSource
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section ==0) {
        return topCellHeight;
    }else{
        return cellHeight;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%ld区%ld行点击了界面",(long)indexPath.section,(long)indexPath.row);
}

#pragma mark -PersonalListViewCellDelegate
-(void)PersonalListViewCell:(PersonalListViewCell *)cell didSelectSheQuWithIndex:(NSInteger)index{
    NSLog(@"点击了第%ld个社区图标",(long)index);
}

-(void)PersonalListViewCell:(PersonalListViewCell *)cell didSelectFenXiangWithIndex:(NSInteger)index{
    NSLog(@"点击了第%ld个分享图标",(long)index);
}

-(void)PersonalListViewCell:(PersonalListViewCell *)cell didSelectToolsWithIndex:(NSInteger)index{
    NSLog(@"点击了第%ld个常用工具图标",(long)index);
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

