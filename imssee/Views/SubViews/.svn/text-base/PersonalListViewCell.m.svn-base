//
//  PersonalTableViewCell.m
//  imssee
//
//  Created by app001.cn on 15-2-6.
//  Copyright (c) 2015年 鑫易. All rights reserved.
//
#define cellWidth [[UIScreen mainScreen] bounds].size.width

#define cellHeight 50
#define rightWidth 40
#define sheQuImgWidth 40
#define sheQuImgHeight 30
#define fenXiangImgWidth 35
#define fenXiangImgHeight 30
#define toolImgWidth 25
#define toolImgHeight 25

#import "PersonalListViewCell.h"
#import "SHBadgeImage.h"


@implementation PersonalListViewCell

- (void)awakeFromNib {
    // Initialization code
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self loadContentVoew];
    }
    return self;
}

#pragma  mark-setter
- (void)setBadgeValue:(NSString *)badgeValue
{
    if (_badgeValue != badgeValue) {
        _badgeValue = badgeValue;
    }
    [_badgeImage setBadgeValue:_badgeValue];
}

-(void)setTitle:(NSString *)title
{
    if (_title != title) {
        _title = title;
    }
   _lableWidth = [GlobalFunction getWidthOfString:_title withSize:CGSizeMake(MAXFLOAT, 30) fontSize:[UIFont systemFontOfSize:18]];
    [self loadBadeImage];
    [self loadTitle];
}

-(void)setSheQuImgArray:(NSArray *)sheQuImgArray{
    if (_sheQuImgArray !=sheQuImgArray) {
        _sheQuImgArray = sheQuImgArray;
    }
    [self loadSheQuView];
}

-(void)setFenXiangImgArray:(NSArray *)fenXiangImgArray{
    if (_fenXiangImgArray !=fenXiangImgArray) {
        _fenXiangImgArray = fenXiangImgArray;
    }
    [self loadFenXiangView];
}

-(void)setTiXingText:(NSString *)tiXingText{
    if (_tiXingText != tiXingText) {
        _tiXingText = tiXingText;
    }
    [self loadTiXingView];
}

-(void)setToolsArray:(NSArray *)toolsArray{
    if (_toolsArray != toolsArray) {
        _toolsArray = toolsArray;
    }
    [self loadToolView];
}

#pragma mark-loadView
//图标
-(void)loadContentVoew{
    _imgView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 30, 30)];
    [self addSubview:_imgView];
}

//title
-(void)loadTitle{
    _titleLable = [[UILabel alloc]init];
    _titleLable.frame =CGRectMake(_imgView.frame.origin.x+_imgView.frame.size.width+10, 10, _lableWidth, 30);
    _titleLable.font = [UIFont systemFontOfSize:18];
    _titleLable.text = _title;
    [self addSubview:_titleLable];
}

//提醒图标
-(void)loadBadeImage{
    _badgeImage = [[SHBadgeImage alloc]initSHBadgeImage:CGRectMake(_titleLable.frame.origin.x+_lableWidth+50, 10, 15, 15)];
    [self addSubview:_badgeImage];
    [self setBadgeValue:@"0"];
}

//社区图标
-(void)loadSheQuView{
    for (int i=0; i<_sheQuImgArray.count; i++) {
        if (i>2) {
            break;
        }
        //社区图片
        UIImageView *sheQuImgView = [[UIImageView alloc]initWithFrame:CGRectMake(cellWidth-rightWidth-sheQuImgWidth-(sheQuImgWidth+10)*i, cellHeight/2-sheQuImgHeight/2, sheQuImgWidth, sheQuImgHeight)];
        sheQuImgView.image = [UIImage imageNamed:_sheQuImgArray[i][0]];
        [self addSubview:sheQuImgView];
        //社区名字
        UILabel *sheQuName = [[UILabel alloc]initWithFrame:CGRectMake(0, 20, sheQuImgWidth, 10)];
        sheQuName.backgroundColor = [UIColor colorWithWhite:0.8 alpha:0.5];
        sheQuName.font = [UIFont systemFontOfSize:10];
        sheQuName.text = _sheQuImgArray[i][1];
        sheQuName.textAlignment = NSTextAlignmentCenter;
        sheQuName.adjustsFontSizeToFitWidth = YES;
        sheQuImgView.tag = i;
        [sheQuImgView addSubview:sheQuName];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(sheQuImgTap:)];
        [sheQuImgView addGestureRecognizer:tap];
        sheQuImgView.userInteractionEnabled = YES;
    }
}

//分享图标
-(void)loadFenXiangView{
    for (int i=0; i<_fenXiangImgArray.count+1; i++) {
        if (i>2) {
            break;
        }
        UIImageView *fenXiangView = [[UIImageView alloc]initWithFrame:CGRectMake(cellWidth-rightWidth-fenXiangImgWidth-(fenXiangImgWidth+10)*i, cellHeight/2-fenXiangImgHeight/2, fenXiangImgWidth, fenXiangImgHeight)];
        if (i==0) {
            fenXiangView.image = [UIImage imageNamed:@"fangkuang"];
        }else{
            fenXiangView.image = [UIImage imageNamed:_fenXiangImgArray[i-1]];
        }
        fenXiangView.tag = i;
        [self addSubview:fenXiangView];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(fenXiangViewTap:)];
        [fenXiangView addGestureRecognizer:tap];
        fenXiangView.userInteractionEnabled = YES;
    }
}

//提醒内容
-(void)loadTiXingView{
    UILabel *rightLable = [[UILabel alloc]initWithFrame:CGRectMake(cellWidth-rightWidth-100, self.bounds.size.height/2-15, 100, 30)];
    rightLable.font = [UIFont systemFontOfSize:14];
    rightLable.textAlignment = NSTextAlignmentRight;
    rightLable.textColor = PinkColor;
    rightLable.text = _tiXingText;
    [self addSubview:rightLable];
}

//常用工具
-(void)loadToolView{
    for (int i=0; i<9; i++) {
        if (i>2) {
            break;
        }
        //常用tool图标
        UIButton *toolButton = [[UIButton alloc]initWithFrame:CGRectMake(cellWidth-rightWidth-toolImgWidth-(toolImgWidth+10)*i, cellHeight/2-toolImgHeight/2, toolImgWidth, toolImgHeight)];
        [toolButton setBackgroundImage:[UIImage imageNamed:_toolsArray[i]] forState:UIControlStateNormal];
        toolButton.tag = i;
        [toolButton addTarget:self action:@selector(toolViewClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:toolButton];
    }
}

#pragma  mark-delegaeMethed
-(void)toolViewClicked:(UIButton *)button{
    if ([_delegae respondsToSelector:@selector(PersonalListViewCell:didSelectToolsWithIndex:)]) {
        [_delegae PersonalListViewCell:self didSelectToolsWithIndex:button.tag];
    }
}

-(void)sheQuImgTap:(UITapGestureRecognizer *)tap{
    if ([_delegae respondsToSelector:@selector(PersonalListViewCell:didSelectSheQuWithIndex:)]) {
        [_delegae PersonalListViewCell:self didSelectSheQuWithIndex:tap.view.tag];
    }
}

-(void)fenXiangViewTap:(UITapGestureRecognizer *)tap{
    if ([_delegae respondsToSelector:@selector(PersonalListViewCell:didSelectFenXiangWithIndex:)]) {
        [_delegae PersonalListViewCell:self didSelectFenXiangWithIndex:tap.view.tag];
    }
}


@end
