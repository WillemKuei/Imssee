//
//  JiaZongParentViewController.m
//  imssee
//
//  Created by imsseeios3 on 15/2/27.
//  Copyright (c) 2015年 鑫易. All rights reserved.
//

#import "JiaZongParentViewController.h"
#import "DXPopover.h"

#define RowHeight 30.f
#define MenuItem_TAG 500

@interface JiaZongParentViewController ()<ButtomMenuDelegate,UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_menuTableView;
    ButtomMenuItem *_selectedItem;
    DXPopover *_popover;
}

@end

@implementation JiaZongParentViewController

#pragma mark LifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavTitle:@"社缘"];
    
    [self initParentView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark PrivateMethods
- (void)initParentView
{
    NSArray *items = @[@{@"家综动态":@[@"宣传推广",@"工作会议",@"领导关怀",@"家综新闻"]},
                       @{@"服务内容":@[@"志愿服务",@"家庭服务",@"长者服务",@"残障服务",@"青少年服务"]},
                       @{@"服务案例":@[]},
                       @{@"活动召集":@[@"活动通告",@"往期活动"]},
                       @{@"社工服务":@[@"我的关注",@"辖区社工",@"穗社工"]}];
    ButtomMenuView *buttomMenuView = [[ButtomMenuView alloc] initWithItems:items delegate:self];
    [self.view addSubview:buttomMenuView];
    
    _menuTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 100, 120) style:UITableViewStylePlain];
    _menuTableView.dataSource = self;
    _menuTableView.delegate = self;
    _menuTableView.rowHeight = RowHeight;
    _menuTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

#pragma mark ButtomMenuDelegate Method
- (void)buttomMenuClick:(UIButton *)menuItem
{
//    UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 150, 100)];
//    textLabel.text = @"jkjljdalkjdkljalfjklajdlkfjla;jfl;jadkl;fjlka;djdfl;ajk";
//    textLabel.backgroundColor = [UIColor whiteColor];
//    
//    CGPoint startPoint = CGPointMake(menuItem.frame.origin.x + menuItem.frame.size.width/2, SCREEN_HEIGHT - menuItem.frame.size.height);
//    
//    DXPopover *popover = [DXPopover popover];
//    [popover showAtPoint:startPoint
//          popoverPostion:DXPopoverPositionUp
//         withContentView:textLabel
//                  inView:self.navigationController.view];
}

- (void)longPressButtomMenu:(UIButton *)menuItem
{
    _selectedItem = (ButtomMenuItem *)menuItem;
    [_menuTableView reloadData];
    
    CGPoint startPoint = CGPointMake(menuItem.frame.origin.x + menuItem.frame.size.width/2, SCREEN_HEIGHT - menuItem.frame.size.height);
    if (_popover == nil) {
        _popover = [DXPopover popover];
    }
    [_popover showAtPoint:startPoint
          popoverPostion:DXPopoverPositionUp
         withContentView:_menuTableView
                  inView:self.navigationController.view];
}

#pragma mark UITableViewDataSource UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger rows = _selectedItem.subItems.count;
    CGRect rect = tableView.frame;
    rect = CGRectMake(rect.origin.x, rect.origin.y, rect.size.width, RowHeight * rows);
    tableView.frame = rect;
    return rows!=0?rows:0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cell";
    MenuListCell *cell = (MenuListCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[MenuListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        cell.textLabel.font = [UIFont systemFontOfSize:14.f];
    }
    cell.textLabel.text = _selectedItem.subItems[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [_popover dismiss];
    MenuListCell *selectedCell = (MenuListCell *)[tableView cellForRowAtIndexPath:indexPath];
    NSLog(@"您选择了:%@",selectedCell.textLabel.text);
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

/**
 *  @desc 底部菜单
 */
@implementation ButtomMenuView

- (instancetype)initWithItems:(NSArray *)items delegate:(id<ButtomMenuDelegate>)delegate
{
    self = [super initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 44, SCREEN_WIDTH, 44)];
    if (self) {
        self.items = items;
        self.delegate = delegate;
        self.backgroundColor = WHITE_COLOR;
        [self drawItems:items];
    }
    return self;
}

- (void)drawItems:(NSArray *)items
{
    NSInteger count = [items count];
    CGFloat width = self.bounds.size.width/count;
    CGFloat height = self.bounds.size.height;
    CGRect frame = CGRectZero;
    for (int i = 0; i < count; i++) {
        ButtomMenuItem *itemBtn = (ButtomMenuItem *)[ButtomMenuItem buttonWithType:UIButtonTypeSystem];
        frame = CGRectMake(width * i, 0, width, height);
        itemBtn.tag = MenuItem_TAG + i;
        [itemBtn setFrame:frame];
        
        NSDictionary *subMenuDic = items[i];
        NSString *title = subMenuDic.allKeys[0];
        itemBtn.subItems = subMenuDic[title];
        itemBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        itemBtn.titleLabel.font = [UIFont systemFontOfSize:14.f];
        [itemBtn setTitle:title forState:UIControlStateNormal];
        [itemBtn setTitleColor:GrayColor forState:UIControlStateNormal];
        [itemBtn setTitleColor:PinkColor forState:UIControlStateSelected];
        [itemBtn addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:itemBtn];
        
        //加长按手势
        UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressAction:)];
        longPress.minimumPressDuration = 0.8;
        [itemBtn addGestureRecognizer:longPress];
    }
}

- (void)clickAction:(UIButton *)button
{
    [self.delegate buttomMenuClick:button];
}

- (void)longPressAction:(UILongPressGestureRecognizer *)longPress
{
    ButtomMenuItem *item = (ButtomMenuItem *)longPress.view;
    if (longPress.state == UIGestureRecognizerStateEnded || [item.subItems count] <= 0) {
        return;
    } else if (longPress.state == UIGestureRecognizerStateBegan){
       [self.delegate longPressButtomMenu:item];
    }
    
    return;
}

@end



/**
 *  @desc ButtomMenuItem
 */
@implementation ButtomMenuItem

//

@end


/**
 *  @desc MenuListCell
 */
@implementation MenuListCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (void)drawRect:(CGRect)rect
{
    //获得处理的上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    //指定直线的样式
    CGContextSetLineCap(context, kCGLineCapSquare);
    //直线宽度
    CGContextSetLineWidth(context, 0.5);
    //设置颜色
    CGContextSetRGBStrokeColor(context, 130.f/255.f, 130.f/255.f, 130.f/255.f, 1.0);
    //开始绘制
    CGContextBeginPath(context);
    //画笔移动到的点
    CGContextMoveToPoint(context, 0, 29.5);
    //下一点
    CGContextAddLineToPoint(context, self.frame.size.width, 29.5);
    //绘制完成
    CGContextStrokePath(context);
}

@end