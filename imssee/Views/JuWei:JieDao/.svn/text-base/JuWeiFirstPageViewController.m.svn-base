//
//  JuWeiFirstPageViewController.m
//  imssee
//
//  Created by app001.cn on 15-2-14.
//  Copyright (c) 2015年 鑫易. All rights reserved.
//

#define index_CommonUsePhone 0
#define index_ChengYuan 1

#import "JuWeiFirstPageViewController.h"

#import "PhoneListCell.h"
#import "SectionTableViewCell.h"
#import "WGTabBar.h"
#import "PhoneList.h"
#import "WGTabBar.h"
#import "WGUser.h"
#import "WGCharge.h"
#import "WGIntrduce.h"
#import "WGCharge.h"
#import "WGIntrduce.h"
#import "EditingViewController.h"

@interface JuWeiFirstPageViewController ()<UIWebViewDelegate,WGTabBarDelegate>


@end

@implementation JuWeiFirstPageViewController

#pragma mark -Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor clearColor];
    
    self.phoneListArray = [NSMutableArray arrayWithCapacity:0];
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
    __weak JuWeiFirstPageViewController *blockSelf = self;
    [[HttpRequest sharedInstance]juWeiPhoneDataWithIndex:index Params:params completionBlock:^(id result) {
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
    __weak JuWeiFirstPageViewController *blockSelf = self;
    __block NSInteger blockIndex = index;
    [[HttpRequest sharedInstance]juWeiIntrduceDataWithIndex:index Params:params completionBlock:^(id result) {
        [WGProgressHUD showSuccessWith:blockSelf.view status:@"请求成功"];
        NSArray *array = result[@"result"];
        if (blockIndex ==0) {
            blockIndex = IntrduceStyle;
        }else{
            blockIndex = GuideStyle;
        }
        [self webDataWithArray:array webDataStyle:blockIndex blockSelf:blockSelf];
    } failureBlock:^(NSError *error, NSString *responseStr) {
        NSLog(@"%@",error);
        [WGProgressHUD showErrorWith:blockSelf.view status:@"请求失败"];
    }];
}

-(void)phoneBtnClicked:(UIButton *)btn{
    NSLog(@"点击了第%ld个phoneBtn",(long)btn.tag);
    [UIHelper alertWithMsg:@"居委界面点击phone" delegate:self andTag:0];
}

#pragma mark -UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView.tag == 0) {
        return self.imgArray.count;
    }else{
        return self.phoneListArray.count;
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
    }else{
        PhoneListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PhoneCell"];
        if (cell == nil) {
            cell = [[NSBundle mainBundle] loadNibNamed:@"PhoneListCell" owner:nil options:nil].lastObject;
        }
        PhoneList *phone = self.phoneListArray[indexPath.row];
        cell.sectionLable.text = phone.deptName;
        cell.nameLable.text = @"张三";
        cell.phoneNumberLable.text = phone.phoneNumber;
        cell.phoneBtn.tag = indexPath.row;
        [cell.phoneBtn setBackgroundImage:[UIImage imageNamed:@"phone2"] forState:UIControlStateNormal];
        [cell.phoneBtn addTarget:self action:@selector(phoneBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }
}

#pragma mark -UITableViewDelegae
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"点击了table %ld",(long)tableView.tag);
    if (tableView.tag==0) {
        [self sectionTableChangeColor:tableView indexPath:indexPath];
        for (UIView *view in self.rightView.subviews) {
            [view removeFromSuperview];
        }
        if (indexPath.row == 0) {
            [self getWebDataWithIndex:0];
        }else if(indexPath.row == 1){
            [self.phoneListArray removeAllObjects];
            [self creatTableViewWithTag:indexPath.row+10];
            [self getTableDataWithIndex:index_CommonUsePhone];
            self.index = index_CommonUsePhone;
        }else if(indexPath.row == 2){
            [self getWebDataWithIndex:1];
        }else{
            NSLog(@"跳转到群发界面");
            EditingViewController *editingVC = [[EditingViewController alloc]init];
            editingVC.title = @"居委／街道";
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
