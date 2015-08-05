//
//  YeZhuFirstPageViewController.m
//  imssee
//
//  Created by app001.cn on 15-2-12.
//  Copyright (c) 2015年 鑫易. All rights reserved.
//

#import "YeZhuFirstPageViewController.h"
#import "SectionTableViewCell.h"
#import "PhoneListCell.h"
#import "PhoneList.h"
#import "WGTabBar.h"
#import "PhoneList.h"
#import "WGTabBar.h"
#import "WGUser.h"
#import "WGCharge.h"
#import "WGIntrduce.h"
#import "EditingViewController.h"
#import "WuGuanPersonListCell.h"


@interface YeZhuFirstPageViewController ()<UIWebViewDelegate>

@property (nonatomic,strong) NSMutableArray *phoneListArray;

@end

@implementation YeZhuFirstPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.userListArray = [NSMutableArray arrayWithCapacity:0];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -Private Methods
-(void)getTableDataWithIndex:(NSInteger)index{
    NSDictionary *params = @{@"pageNo":[NSNumber numberWithInt:self.page]};
    [WGProgressHUD showHUDAddedTo:self.view status:@"请稍后"];
    __weak YeZhuFirstPageViewController *blockSelf = self;
    [[HttpRequest sharedInstance]yeZhuWeiPersonalDataWithIndex:index Params:params completionBlock:^(id result) {
        NSArray *array = result[@"result"];
       [self tableDataWithArray:array index:index blockSelf:blockSelf];
    } failureBlock:^(NSError *error, NSString *responseStr) {
        NSLog(@"%@",error);
        [WGProgressHUD showErrorWith:blockSelf.view status:@"请求失败"];
    }];
}

-(void)getWebDataWithIndex:(NSInteger)index{
    NSDictionary *params = @{@"pageNo":[NSNumber numberWithInt:1]};
    [WGProgressHUD showHUDAddedTo:self.view status:@"请稍后"];
    __weak YeZhuFirstPageViewController *blockSelf = self;
    [[HttpRequest sharedInstance]yeZhuWeiIntrduceDataWithIndex:index Params:params completionBlock:^(id result) {
        [WGProgressHUD showSuccessWith:blockSelf.view status:@"请求成功"];
        NSArray *array = result[@"result"];
        [self webDataWithArray:array webDataStyle:IntrduceStyle blockSelf:blockSelf];
    } failureBlock:^(NSError *error, NSString *responseStr) {
        NSLog(@"%@",error);
        [WGProgressHUD showErrorWith:blockSelf.view status:@"请求失败"];
    }];
}

-(void)phoneBtnClicked:(UIButton *)btn{
    NSLog(@"点击了第%ld个phoneBtn",(long)btn.tag);
    [UIHelper alertWithMsg:@"00000" delegate:self andTag:0];
}

#pragma mark -WGTabBarDelegate
- (void)WGTabBar:(WGTabBar *)wgTabBar didSelectedItem:(id)selectedItem{
    NSLog(@"didSelectedItem");
}

#pragma mark -UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView.tag == 0) {
        return self.imgArray.count;
    }else {
        return self.userListArray.count;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *indentifer = @"Cell";
    if (tableView.tag == 0) {
        SectionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:indentifer];
        for (UIView *subView in cell.contentView.subviews)
        {
            [subView removeFromSuperview];
        }
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
    }else {
        WuGuanPersonListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PhoneCell"];
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
            [self.userListArray removeAllObjects];
            [self creatTableViewWithTag:indexPath.row+10];
            [self getTableDataWithIndex:1];
        }else if(indexPath.row == 1){
            [self getWebDataWithIndex:0];
        }else {
            EditingViewController *editingVC = [[EditingViewController alloc]init];
            editingVC.title = @"业主委员会";
            [self presentViewController:editingVC animated:NO completion:nil];
        }
    }else{
        NSLog(@"电话详情");
    }
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
