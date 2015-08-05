//
//  WuGuanFirstPageViewController.h
//  imssee
//
//  Created by app001.cn on 15-2-11.
//  Copyright (c) 2015年 鑫易. All rights reserved.
//

#import "SectionTableViewCell.h"
@class WGIntrduce;
@class WGCharge;
@class WGGuide;
@class SectionTableViewCell;

typedef NS_ENUM(NSUInteger, WebDataStyle) {
    ChargeStyle = 0,
    IntrduceStyle = 1,
    GuideStyle = 2
};

@interface WuGuanFirstPageViewController : UIViewController

@property (nonatomic,strong) NSArray *imgArray;
@property (nonatomic,strong) UITableView *sectionTable;
@property (nonatomic,strong) SectionTableViewCell *lastCell;
@property (nonatomic,strong) UIView *rightView;
@property (nonatomic,strong) UITableView *rightTable;
@property (nonatomic,assign) int page;
@property (nonatomic,strong) UIWebView *webView;
@property (nonatomic,strong) NSMutableArray *phoneListArray;
@property (nonatomic,strong) NSMutableArray *userListArray;
@property (nonatomic,strong) WGCharge *charge;
@property (nonatomic,strong) WGIntrduce *intrduce;
@property (nonatomic,strong) WGGuide *guide;
@property (nonatomic,assign) NSInteger index;
@property (nonatomic,strong) NSMutableArray *webDataArray;

-(void)creatWebView;
-(void)creatTableViewWithTag:(NSInteger)indexTag;
-(void)tableDataWithArray:(NSArray *)array index:(NSInteger)index blockSelf:(__weak UIViewController*)blockSelf;
-(void)webDataWithArray:(NSArray *)array webDataStyle:(WebDataStyle)webDataStyle blockSelf:(__weak UIViewController*)blockSelf;
-(void)sectionTableChangeColor:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath;

@end
