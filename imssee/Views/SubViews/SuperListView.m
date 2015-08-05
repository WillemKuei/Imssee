//
//  SuperListView.m
//  imssee
//
//  Created by app001.cn on 14-12-26.
//  Copyright (c) 2014年 鑫易. All rights reserved.
//

#import "SuperListView.h"

@implementation SuperListView

- (id)initListViewWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self loadADImageView];
        [self loadTableView];
    }
    return self;
}

- (void)loadADImageView
{
    UIImageView *ADImageTemp = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 44)];
    [ADImageTemp setImage:[UIImage imageNamed:@""]];
    ADImageTemp.backgroundColor = [UIColor purpleColor];
    self.ADImage = ADImageTemp;
    [self addSubview:ADImageTemp];
}

- (void)loadTableView
{
    UITableView *table = [[UITableView alloc]initWithFrame:CGRectMake(0, 44, self.bounds.size.width, self.bounds.size.height - 44) style:UITableViewStyleGrouped];
    table.dataSource = self;
    table.delegate = self;
    self.tableView = table;
    [self addSubview:self.tableView];
}

- (void)refreshListViewWithsections:(sectionBlock)sections rows:(rowsBlock)rows tableBlock:(tableViewBlock)tableBlock isSuiSheQu:(BOOL)isSuiSheQu
{
    self.isSuiSheQu = isSuiSheQu;
    self.sectionBlock = sections;
    self.rowsBlock = rows;
    self.tableBlock = tableBlock;
    NSLog(@"sections:%ld",(long)self.sections);
}

- (void)refreshListViewWithHeaderBlock:(headerBlock)headerBlock isSuiSheQu:(BOOL)isSuiSheQu
{
    self.headerBlock = headerBlock;
    self.isSuiSheQu = isSuiSheQu;
}

#pragma UITableViewDataSource and UITableviewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (self.sectionBlock) {
        self.sections = self.sectionBlock(tableView);
        return self.sections;
    }
    else
        return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.rowsBlock) {
        self.rows = self.rowsBlock(tableView,section);
        return self.rows;
    }
    else
        return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = self.tableBlock(tableView,indexPath);
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headView = self.headerBlock(tableView,section);
    return headView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([_delegate respondsToSelector:@selector(SuperListView:didSelectRowAtIndexPath:)]) {
        [_delegate SuperListView:tableView didSelectRowAtIndexPath:indexPath];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
