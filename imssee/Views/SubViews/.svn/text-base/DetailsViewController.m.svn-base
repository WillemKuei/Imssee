//
//  DetailsViewController.m
//  imssee
//
//  Created by app001.cn on 14-12-29.
//  Copyright (c) 2014年 鑫易. All rights reserved.
//

#import "DetailsViewController.h"
#import "HSUser.h"


@interface DetailsViewController ()
{
    UIView *_headerView;
    UILabel *_contextLable;
    UIImageView *_imageView;
    UIScrollView *_scrollView;
    UIView *_zanAndCommentView;
    UIView *_commentBarListView;
    CGFloat _rectY;
    CGFloat _rectH;
}
@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self.view addSubview:[UIHelper headerViewWithImage:[UIImage imageNamed:@"nav_bg.png"] title:@"详情" target:self backAction:@selector(backAction:)]];
    
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64)];
    _scrollView.backgroundColor = [UIColor purpleColor];
    _scrollView.showsVerticalScrollIndicator = YES;
    [self.view addSubview:_scrollView];
    
    [self loadHeaderView];
    [self loadImageView];
    [self loadContext];
    [self zanAndComment];
    [self commentBarWithArray:@[@"",@""]];
    _scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, _headerView.frame.size.height+_imageView.frame.size.height+_contextLable.frame.size.height+_zanAndCommentView.frame.size.height+_commentBarListView.frame.size.height+80);
}

//标题头
-(void)loadHeaderView{
    _headerView = [[UIView alloc]init];
    _headerView.backgroundColor = [UIColor grayColor];
    
    //标题
    UILabel *titleLable = [[UILabel alloc]init];
    titleLable.backgroundColor = [UIColor redColor];
    titleLable.text = self.receiveList.title;
    titleLable.font = [UIFont systemFontOfSize:20];
    titleLable.numberOfLines = 0;
    NSLog(@"%@",self.receiveList.title);
    CGFloat titleHeight = [self getHeightOfString:titleLable.text fontSize:20];
    titleLable.frame = CGRectMake(0, 10, SCREEN_WIDTH-20, titleHeight);
    [_headerView addSubview:titleLable];
    //时间
    UILabel *timeLable = [[UILabel alloc]initWithFrame:CGRectMake(0, titleLable.frame.size.height+20, 130, 30)];
    timeLable.text = [NSString stringWithFormat:@"%@    发布人：",self.receiveList.creatTime];
    timeLable.font = [UIFont systemFontOfSize:12];
    timeLable.backgroundColor = [UIColor orangeColor];
    [_headerView addSubview:timeLable];
    //发布人
    UILabel *userLable = [[UILabel alloc]initWithFrame:CGRectMake(timeLable.frame.size.width+10, titleLable.frame.size.height+20, 50, 30)];
    userLable.text = self.receiveList.user.userName;
    userLable.font = [UIFont systemFontOfSize:12];
    userLable.textColor = [UIColor redColor];
    [_headerView addSubview:userLable];
    //浏览量
    UILabel * browseNumberLable = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-100, titleLable.frame.size.height+20, 80, 30)];
    browseNumberLable.text = [NSString stringWithFormat:@"浏览量：%.0f",self.receiveList.browseNumber];
    browseNumberLable.font = [UIFont systemFontOfSize:12];
    browseNumberLable.backgroundColor = [UIColor orangeColor];
    [_headerView addSubview:browseNumberLable];
    
    UILabel *lableBar = [[UILabel alloc]initWithFrame:CGRectMake(0, browseNumberLable.frame.origin.y+20+19, SCREEN_WIDTH-20, 1)];
    lableBar.backgroundColor = [UIColor lightGrayColor];
    [_headerView addSubview:lableBar];
    
    _headerView.frame = CGRectMake(10, 0, SCREEN_WIDTH-20, titleLable.frame.origin.y+timeLable.frame.origin.y+30);
    [_scrollView addSubview:_headerView];
    
}

-(CGFloat)getHeightOfString:(NSString *)string fontSize:(CGFloat)fontSize{
    UIFont *font = [UIFont systemFontOfSize:fontSize];
    NSDictionary *attribute = @{NSFontAttributeName:font};
    CGSize size = [string boundingRectWithSize:CGSizeMake(280, MAXFLOAT) options: NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
    return size.height;
}

//图片
-(void)loadImageView{
    if (![self.receiveList.imagePath isEqualToString:@""]) {
        _imageView = [[UIImageView alloc]init];
        _imageView.frame = CGRectMake(10, _headerView.frame.size.height+30, SCREEN_WIDTH-20, 100);
        _imageView.backgroundColor = [UIColor redColor];
        [_scrollView addSubview:_imageView];
    }
}

//正文
-(void)loadContext{
    _contextLable = [[UILabel alloc]init];
    _contextLable.backgroundColor = [UIColor greenColor];
    _contextLable.text = self.receiveList.context;
    _contextLable.numberOfLines = 0;
    CGFloat textLableHeight = [self getHeightOfString:_contextLable.text fontSize:15];
    _contextLable.backgroundColor = [UIColor purpleColor];
    if ([self.receiveList.imagePath isEqualToString:@""]) {
        _contextLable.frame = CGRectMake(10, _headerView.frame.size.height+15, SCREEN_WIDTH-20, textLableHeight+10);
    }else{
        _contextLable.frame = CGRectMake(10, _headerView.frame.size.height+_imageView.frame.size.height+30+15, SCREEN_WIDTH-20, textLableHeight+10);
    }
    [_scrollView addSubview:_contextLable];
}

//点赞和评论按钮
- (void)zanAndComment{
    _zanAndCommentView = [[UIView alloc]init];
    _zanAndCommentView.backgroundColor = [UIColor lightGrayColor];
    _zanAndCommentView.frame = CGRectMake(10, _contextLable.frame.origin.y+_contextLable.frame.size.height, SCREEN_WIDTH-20, 100);
    
    UILabel *lableBar = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH-20, 1)];
    lableBar.backgroundColor = [UIColor lightGrayColor];
    [_zanAndCommentView addSubview:lableBar];
    
    UILabel *adLable = [[UILabel alloc]initWithFrame:CGRectMake(0, 15, 190, 20)];
    adLable.text = @"更多精彩内容，敬请关注社缘公众号：";
    adLable.font = [UIFont systemFontOfSize:12];
    adLable.backgroundColor = [UIColor orangeColor];
    [_zanAndCommentView addSubview:adLable];
    
    UIImageView *sheYuanImageView = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-120, 5, 100, 30)];
    sheYuanImageView.backgroundColor = [UIColor redColor];
    [_zanAndCommentView addSubview:sheYuanImageView];
    
    UIView *zanButtonView = [self buttonWithImage:nil title:@"点赞" number:0];
    zanButtonView.frame = CGRectMake(SCREEN_WIDTH-40-80*2-5, 60, 80, 20);
    zanButtonView.tag = 1000;
    [_zanAndCommentView addSubview:zanButtonView];
    UITapGestureRecognizer *zanTapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(zanTapGesture:)];
    [zanButtonView addGestureRecognizer:zanTapGesture];
    
    UIView *commentButtonView = [self buttonWithImage:nil title:@"评论" number:0];
    commentButtonView.frame = CGRectMake(SCREEN_WIDTH-40-80, 60, 80, 20);
    [_zanAndCommentView addSubview:commentButtonView];
    UITapGestureRecognizer *commentTapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(commentTapGesture:)];
    [commentButtonView addGestureRecognizer:commentTapGesture];
    
    [_scrollView addSubview:_zanAndCommentView];
}

- (void)zanTapGesture:(UITapGestureRecognizer *)tap{
    NSLog(@"zanTapGesture");
    static int number = 0;
     UIView *view  = [self.view viewWithTag:1000];
    if (number%2==1) {
        UILabel *titleLable = view.subviews[1];
        titleLable.textColor = [UIColor redColor];
        UILabel *numLable = view.subviews[2];
        numLable.textColor = [UIColor redColor];
        numLable.text =[NSString stringWithFormat:@"(%d)",number%2];
    }else{
        UILabel *titleLable = view.subviews[1];
        titleLable.textColor = [UIColor blackColor];
        UILabel *numLable = view.subviews[2];
        numLable.textColor = [UIColor blackColor];
        numLable.text =[NSString stringWithFormat:@"(%d)",number%2];
    }
    number ++;
}

- (void)commentTapGesture:(UITapGestureRecognizer *)tap{
    NSLog(@"commentTapGesture");
}

- (UIView *)buttonWithImage:(UIImage *)image title:(NSString *)title number:(int)number{
    UIView *bgView = [[UIView alloc]init];
    bgView.backgroundColor = [UIColor whiteColor];
    
    UIImageView *zanImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
    zanImageView.image = image;
    zanImageView.backgroundColor = [UIColor orangeColor];
    [bgView addSubview:zanImageView];
    
    UILabel *zanLable = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, 20, 20)];
    zanLable.text = title;
    zanLable.font = [UIFont systemFontOfSize:10];
    zanLable.backgroundColor = [UIColor redColor];
    [bgView addSubview:zanLable];
    
    UILabel *zanNumLable = [[UILabel alloc]initWithFrame:CGRectMake(40, 0, 40, 20)];
    zanNumLable.text = [NSString stringWithFormat:@"(%d)",number];
    zanNumLable.font = [UIFont systemFontOfSize:10];
    [bgView addSubview:zanNumLable];
    
    return bgView;
}

//评论条
- (void)commentBarWithArray:(NSArray *)array{
    _commentBarListView = [[UIView alloc]init];
    _commentBarListView.backgroundColor = [UIColor lightGrayColor];
    for (int i=0; i<array.count; i++) {
        UIView *commentBar = [[UIView alloc]init];
        commentBar.backgroundColor = [UIColor orangeColor];
        //头像
        UIImageView *headImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 0, 40, 40)];
        headImageView.layer.cornerRadius = 20;
        headImageView.backgroundColor = [UIColor redColor];
        [commentBar addSubview:headImageView];
        //名字
        UIButton *nameBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        nameBtn.frame = CGRectMake(60, 0, 80, 20);
        [nameBtn setTitle:@"123" forState:UIControlStateNormal];
        [nameBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        nameBtn.backgroundColor = [UIColor whiteColor];
        [nameBtn addTarget:self action:@selector(nameBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [commentBar addSubview:nameBtn];
        //评论
        UILabel *commentLable = [[UILabel alloc]init];
        commentLable.backgroundColor = [UIColor grayColor];
        commentLable.text = @"只是评论只是评论只是评论";
        commentLable.numberOfLines = 0;
        CGFloat commentLableHeight = [self getHeightOfString:commentLable.text fontSize:14];
        commentLable.frame = CGRectMake(60, nameBtn.frame.origin.y+nameBtn.frame.size.height+20, SCREEN_WIDTH-80, commentLableHeight);
        [commentBar addSubview:commentLable];
        //灰条
        UIImageView *barView = [[UIImageView alloc]initWithFrame:CGRectMake(0, commentLable.frame.origin.y+commentLable.frame.size.height+10-1, SCREEN_WIDTH-20, 1)];
        barView.backgroundColor = [UIColor lightGrayColor];
        [commentBar addSubview:barView];
        
        commentBar.frame = CGRectMake(0, self.rectY, SCREEN_WIDTH-20, nameBtn.frame.size.height+commentLableHeight+30);
        self.rectY = self.rectY + commentBar.frame.size.height;
        [_commentBarListView addSubview:commentBar];
    }
    _commentBarListView.frame = CGRectMake(10, _zanAndCommentView.frame.origin.y+_zanAndCommentView.frame.size.height+20, SCREEN_WIDTH-20, self.rectY);
    [_scrollView addSubview:_commentBarListView];
}

-(void)nameBtnClicked:(UIButton *)btn{
    NSLog(@"nameBtnClicked");
}

- (void)backAction:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
