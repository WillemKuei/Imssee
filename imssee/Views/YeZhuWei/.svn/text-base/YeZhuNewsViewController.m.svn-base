//
//  YeZhuNewsViewController.m
//  imssee
//
//  Created by app001.cn on 15-2-12.
//  Copyright (c) 2015年 鑫易. All rights reserved.
//

#import "YeZhuNewsViewController.h"
#import "JuWeiListCell.h"

@interface YeZhuNewsViewController ()

@end

@implementation YeZhuNewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *indentifer = @"Cell";
    JuWeiListCell *cell = [tableView dequeueReusableCellWithIdentifier:indentifer];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"JuWeiListCell" owner:nil options:nil] lastObject];
    }
    [cell.imgView setImageWithURL:[NSURL URLWithString:@""] placeholderImage:[UIImage imageNamed:@"nav_db"]];
    [GlobalFunction radiusImageView:cell.imgView radius:5];
    cell.titleLable.text = @"业主委员会";
    cell.subTitleLable.text = @"回应是否公审，该怎么判就怎么判";
    cell.timeLable.text = @"2015-02-22";
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
