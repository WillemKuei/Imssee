//
//  PeripheryMainViewController.m
//  imssee
//
//  Created by 鑫易 on 15/1/29.
//  Copyright (c) 2015年 鑫易. All rights reserved.
//

#import "PeripheryMainViewController.h"
#import "UIImage+Utility.h"
#import "UITableView+Wave.h"
#import "SubMenuListCell.h"
#import "JiaZongParentViewController.h"

@interface PeripheryMainViewController ()
{
    NSDictionary *_arrays;
    __weak IBOutlet NSLayoutConstraint *_topConstraint_content;
    NSInteger _index;
}

@end

@implementation PeripheryMainViewController

#pragma mark LifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavTitle:@"社缘"];
    
    [self initPeripheryMainView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark Private Method
#define ListView_Width 64
- (void)initPeripheryMainView
{
    _arrays = @{@"leida":@"雷达",@"search":@"找",@"thru":@"穿越",@"fenlei":@"分类"};
    CGFloat width = SCREEN_WIDTH;
    _listView = [[SubMenuListView alloc] initSubMenuListViewWithFrame:CGRectMake(0, 64, ListView_Width, width) style:UITableViewStylePlain];
    _listView.backgroundColor = CLEAR_COLOR;
    _listView.menuDataSource = self;
    _listView.hidden = YES;
    _listView.menuDelegate = self;
    _listView.rowHeight = MAX(width/_arrays.count, 90);
    [self.view insertSubview:_listView atIndex:0];
    _listView.transform = CGAffineTransformMakeRotation(-M_PI/2);
    _listView.center = CGPointMake(width/2, ListView_Width/2+64);
    
    //RightButton
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn setImage:[UIImage imageNamed:@"expand.png"] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(rightBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [rightBtn setFrame:CGRectMake(SCREEN_WIDTH - 5 - 33, 25, 33, 33)];
    [self settingWGRightBarButtonItem:rightBtn];
    
    [_listView reloadMenuData];
    [self whetherHiddenMenuListView:YES];
    
    [self loadPluginItem];
}

- (void)loadPluginItem
{
    NSArray *plugins = @[@{@"title":@"家综"},@{@"title":@"商家"},@{@"title":@"居委"},@{@"title":@"个人提供"},@{@"title":@"社区"}];
    float width = (SCREEN_WIDTH - 8 * 5)/4;
    float height = width + 20;
    float margin = 8.0;
    float origin_x = margin;
    float origin_y = margin;
    __block PeripheryMainViewController *blockSelf = self;
    for (int i = 0; i < plugins.count; i++) {
        if (i%4 == 0) {
            origin_x = margin;
            origin_y = (height + margin) * i/4 + margin;
        } else {
            origin_x = margin + (width + margin) * (i%4);
            origin_y = (height + margin) * (int)(i/4) + margin;
        }
        CGRect frame = CGRectMake(origin_x, origin_y, width, height);
        PluginItem *pluginItem = [[PluginItem alloc] initPluginItemWithframe:frame params:plugins[i]];
        [_contentView addSubview:pluginItem];
        
        pluginItem.tapAction = ^(UITapGestureRecognizer *tap)
        {
            [blockSelf pluginItemClick:tap];
        };
    }
}

- (void)whetherHiddenMenuListView:(BOOL)hidden
{
    CGPoint listViewCenter = _listView.center;
//    [UIView animateWithDuration:0.2
//                     animations:^{
//                         if (hidden) {
//                             _listView.hidden = hidden;
//                         }
//                         _listView.center = CGPointMake(listViewCenter.x, hidden?(listViewCenter.y - 64):(listViewCenter.y + 64));
//                     }
//                     completion:^(BOOL finished){
//                         _listView.hidden = hidden;
//                         if (!hidden) {
//                             [_listView reloadMenuData];
//                         }
//                     }];
    
    [UIView animateWithDuration:0.2
                          delay:0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         if (!hidden) {
                             _listView.hidden = hidden;
                         }
                         _topConstraint_content.constant = hidden?64:128;
                         _listView.center = CGPointMake(listViewCenter.x, hidden?(listViewCenter.y - 64):(listViewCenter.y + 64));
                     }
                     completion:^(BOOL finished) {
                         _listView.hidden = hidden;
                         if (!hidden) {
                             [_listView reloadMenuData];
                         }
                     }];
}

- (void)updateSelectedIcon:(NSInteger)index
{
    if (index != _index) {
        NSIndexPath *indexPath_cur = [NSIndexPath indexPathForRow:_index inSection:0];
        SubMenuListCell *cell_cur = (SubMenuListCell *)[_listView cellForRowAtIndexPath:indexPath_cur];
        cell_cur.iconImage.highlighted = NO;
        cell_cur.titleLab.textColor = [UIColor blackColor];
        NSIndexPath *indexPath_next = [NSIndexPath indexPathForRow:index inSection:0];
        SubMenuListCell *cell_next = (SubMenuListCell *)[_listView cellForRowAtIndexPath:indexPath_next];
        cell_next.iconImage.highlighted = YES;
        cell_next.titleLab.textColor = PinkColor;
        
        _index = index;
        
        indexPath_cur = nil;
        indexPath_next = nil;
    }
}

#pragma mark User Action
- (void)rightBtnAction:(UIButton *)sender
{
    UIButton *btn = sender;
    btn.selected = !btn.selected;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.4];
    btn.transform = btn.selected?CGAffineTransformMakeRotation(M_PI):CGAffineTransformIdentity;
    [UIView commitAnimations];
    [self whetherHiddenMenuListView:!btn.selected];
//    [UIView animateWithDuration:0.5
//                     animations:^{
//                         btn.transform = CGAffineTransformMakeRotation(btn.selected?M_PI:-M_PI*2);
//                     }
//                     completion:^(BOOL finished) {
//                         //
//                     }];
}

- (void)pluginItemClick:(UITapGestureRecognizer *)tap
{
    PluginItem *clickView = (PluginItem *)tap.view;
    JiaZongParentViewController *jiazongParentVC = [[JiaZongParentViewController alloc] init];
    [self.navigationController pushViewController:jiazongParentVC animated:YES];
    jiazongParentVC = nil;
}

#pragma mark SubMenuListViewDataSource And SubMenuListViewDelegate
- (NSInteger)subMenuListView:(SubMenuListView *)listView numberOfRowsInSection:(NSInteger)section
{
    return _arrays.count;
}

- (UITableViewCell *)subMenuListView:(SubMenuListView *)listView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cell";
    SubMenuListCell *cell = (SubMenuListCell *)[listView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"SubMenuListCell" owner:nil options:nil] lastObject];
    }
    if (indexPath.row == 0) {
        CGRect frame = cell.contentView.frame;
        frame = CGRectMake(frame.origin.x + 100, frame.origin.y, frame.size.width, frame.size.height);
        cell.contentView.frame = frame;
    }
    cell.contentView.transform = CGAffineTransformMakeRotation(M_PI/2);
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    NSString *highImageName = [_arrays.allKeys[indexPath.row] stringByAppendingString:@"_sel"];
    cell.iconImage.image = [UIImage imageNamed:_arrays.allKeys[indexPath.row]];
    cell.iconImage.highlightedImage = [UIImage imageNamed:highImageName];
    cell.titleLab.text = _arrays.allValues[indexPath.row];
    highImageName = nil;
    
    if (_index == indexPath.row) {
        cell.iconImage.highlighted = YES;
        cell.titleLab.textColor = PinkColor;
    }
    
    return cell;
}

- (void)subMenuListView:(SubMenuListView *)listView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self updateSelectedIcon:indexPath.row];
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


@implementation PluginItem

- (instancetype)initPluginItemWithframe:(CGRect)frame params:(NSDictionary *)params
{
    self = [super initWithFrame:frame];
    if (self) {
        [self drawContentView:params];
    }
    return self;
}

- (void)drawContentView:(NSDictionary *)params
{
    UIImageView *iconImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.width)];
    iconImage.image = [UIImage imageNamed:@"icon_text.png"];
    self.iconImage = iconImage;
    [self addSubview:self.iconImage];
    
    UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(0, iconImage.bounds.size.height, iconImage.bounds.size.width, 20)];
    titleLab.textAlignment = NSTextAlignmentCenter;
    titleLab.text = params[@"title"];
    self.titleLab = titleLab;
    [self addSubview:self.titleLab];
}

@end
