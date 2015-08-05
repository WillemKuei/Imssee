//
//  ServiceMainViewController.m
//  imssee
//
//  Created by 鑫易 on 15/1/29.
//  Copyright (c) 2015年 鑫易. All rights reserved.
//
#define sectionTbleWidth 80
#define section_CellHeight 60
#define detail_CellHeight 80
#define imgWidth 60
#define imgHeight 60
#define titleLableHeight 44
#define subTitleHeight 20

#import "ServiceMainViewController.h"
#import "SHAppDelegate.h"
#import "SectionTableViewCell.h"
#import "ServiceCell.h"


@interface ServiceMainViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_sectionTable;
    __weak IBOutlet UIView *coverView;
    NSArray *_imgArray;
    UIButton *_rightBtn;
    SectionTableViewCell *lastCell;
}
@end

@implementation ServiceMainViewController

#pragma mark -Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavTitle:@"社缘"];
    
    [self initRightBarItem];
    [self initSectionTable];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showSectionTable)];
    [coverView addGestureRecognizer:tap];
}

-(void)initRightBarItem{
    _rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_rightBtn setImage:[UIImage imageNamed:@"expand"] forState:UIControlStateNormal];
    [_rightBtn addTarget:self action:@selector(showSectionTable) forControlEvents:UIControlEventTouchUpInside];
    [_rightBtn setFrame:CGRectMake(SCREEN_WIDTH - 5 - 33, 25, 33, 33)];
    [self settingWGRightBarButtonItem:_rightBtn];

}

-(void)initSectionTable{
    coverView.hidden = YES;
    _imgArray = @[@[@"shequjinrong",@"shequjinrong1",@"社区金融"],@[@"wai",@"waibi1.png",@"外币"],@[@"baoxian",@"baoxian1",@"保险"],@[@"jiazhen",@"jiazhen1",@"家政"],@[@"jiaofeiyi",@"jiaofeiyi1",@"缴费易"],@[@"piaowu",@"piaowu1",@"票务通"]];
    _sectionTable = [[UITableView alloc]init];
    _sectionTable.frame = CGRectMake( SCREEN_WIDTH, 74, sectionTbleWidth, section_CellHeight*6);
    _sectionTable.delegate = self;
    _sectionTable.dataSource = self;
    _sectionTable.rowHeight = section_CellHeight;
    _sectionTable.tag = 0;
    [self.view addSubview:_sectionTable];
}

-(void)showSectionTable
{
    if (_sectionTable.frame.origin.x == SCREEN_WIDTH) {
        _rightBtn.transform = CGAffineTransformMakeRotation(M_PI);
        [UIView animateWithDuration:0.3 animations:^{
            coverView.hidden = NO;
            _sectionTable.frame =CGRectMake( SCREEN_WIDTH-sectionTbleWidth, 74, sectionTbleWidth, section_CellHeight*6);
        } completion:^(BOOL finished) {
        }];
    }else{
        _rightBtn.transform = CGAffineTransformIdentity;
        [UIView animateWithDuration:0.3 animations:^{
            _sectionTable.frame = CGRectMake( SCREEN_WIDTH, 74, sectionTbleWidth, section_CellHeight*6);
        } completion:^(BOOL finished) {
            coverView.hidden = YES;
        }];
    }
    [self.view bringSubviewToFront:_sectionTable];
}

-(void)loadSectionTable{
    [UIView animateWithDuration:0.5 animations:^{
        _sectionTable.frame =CGRectMake( 0, 74, sectionTbleWidth, section_CellHeight*6);
    } completion:^(BOOL finished) {
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 6;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView.tag==0) {
        SectionTableViewCell * cell = [[[NSBundle mainBundle] loadNibNamed:@"SectionTableViewCell" owner:nil options:nil] lastObject];
        cell.imgView.image = [UIImage imageNamed:_imgArray[indexPath.row][0]];
        cell.lable.text = _imgArray[indexPath.row][2];
        if (indexPath.row == 0) {
            lastCell = cell;
            cell.imgView.image = [UIImage imageNamed:_imgArray[indexPath.row][1]];
            cell.lable.textColor = PinkColor;
        }
        return cell;
    }else{
        static NSString *indentifer = @"Cell";
        ServiceCell *cell = [tableView dequeueReusableCellWithIdentifier:indentifer];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"ServiceCell" owner:nil options:nil] lastObject];
        }
        [cell.imgView setImageWithURL:[NSURL URLWithString:@""] placeholderImage:[UIImage imageNamed:@"nav_db"]];
        [GlobalFunction radiusImageView:cell.imgView radius:5];
        cell.titleLable.text =  @"广州鑫易软件有限公司";
        cell.subTitleLable.text =  @"小额贷款";
        return cell;
    }
}

#pragma mark -UITableViewDelegae
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"点击了table %ld",(long)tableView.tag);
    if (tableView.tag==0) {
        SectionTableViewCell *cell = (SectionTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
        if (lastCell != cell) {
            NSIndexPath *lastIndexpath = [tableView indexPathForCell:lastCell];
            lastCell.imgView.image = [UIImage imageNamed:_imgArray[lastIndexpath.row][0]];
            lastCell.lable.textColor = [UIColor blackColor];
        }
        lastCell = cell;
        cell.imgView.image = [UIImage imageNamed:_imgArray[indexPath.row][1]];
        cell.lable.textColor =PinkColor;
        [self showSectionTable];
        [self.detailTable reloadData];
    }else{
        NSLog(@"跳转详情页面");
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


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
