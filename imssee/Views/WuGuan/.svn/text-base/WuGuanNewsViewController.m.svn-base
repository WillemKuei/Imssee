//
//  WuGuanNewsViewController.m
//  imssee
//
//  Created by app001.cn on 15-2-11.
//  Copyright (c) 2015年 鑫易. All rights reserved.
//

#import "WuGuanNewsViewController.h"
#import "JuWeiListCell.h"

@interface WuGuanNewsViewController ()<UITableViewDataSource,UITableViewDelegate,UITextViewDelegate>
{
    UITextView *_inputTextView;
    UIView *_inputView;
    CGFloat _lastHeight;
    UITableView *_table;
}


@end

@implementation WuGuanNewsViewController

#pragma mark -Life Cycle
- (void)dealloc
{
    Release(_inputTextView);
    Release(_inputView);
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor clearColor];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasShown:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillBeHidden:) name:UIKeyboardWillHideNotification object:nil];
    
    _lastHeight = FootView_Height;
    [self initUI];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -Private Methods
-(void)initUI{
    //背景图
    UIImageView *bgImgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    bgImgView.image = [UIImage imageNamed:@"background.jpg"];
    [self.view addSubview:bgImgView];
    
    _table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-74-44) style:UITableViewStylePlain];
    _table.rowHeight = 80;
    _table.delegate = self;
    _table.dataSource = self;
    _table.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_table];
    //输入view
    _inputView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT-74-44, SCREEN_WIDTH, 44)];
    _inputView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_inputView];
    _inputTextView = [[UITextView alloc] initWithFrame:CGRectMake(5, 7, _inputView.frame.size.width - 95-8, 30)];
    _inputTextView.delegate = self;
    _inputTextView.font = [UIFont systemFontOfSize:14.f];
    _inputTextView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    _inputTextView.layer.masksToBounds = YES;
    [_inputView addSubview:_inputTextView];
    //提交按钮
    UIButton *submitBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    submitBtn.frame = CGRectMake(_inputView.frame.size.width - 50, 8, 40, _inputView.frame.size.height - 16);
    [submitBtn setTitle:@"提交" forState:UIControlStateNormal];
    [submitBtn setTitleColor:WHITE_COLOR forState:UIControlStateNormal];
    submitBtn.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    [submitBtn addTarget:self action:@selector(sendMessage:) forControlEvents:UIControlEventTouchUpInside];
    [submitBtn setBackgroundImage:[UIImage imageNamed:@"bluebtn01"] forState:UIControlStateNormal];
    submitBtn.backgroundColor = PinkColor;
    [_inputView addSubview:submitBtn];
    //表情按钮
    UIButton *faceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    faceBtn.frame = CGRectMake(_inputView.frame.size.width - 95, 8, 30, _inputView.frame.size.height - 16);
    [faceBtn setBackgroundImage:[UIImage imageNamed:@"face"] forState:UIControlStateNormal];
    faceBtn.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    [faceBtn addTarget:self action:@selector(selectedFace:) forControlEvents:UIControlEventTouchUpInside];
    [_inputView addSubview:faceBtn];
    //line
    UIImageView *line = [[UIImageView alloc]initWithFrame:CGRectMake( 5, _inputView.frame.size.height-10, _inputTextView.frame.size.width+30+10, 6)];
    line.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    line.image = [UIImage imageNamed:@"line"];
    [_inputView addSubview:line];
}

//选择表情
-(void)selectedFace:(UIButton *)btn{
    NSLog(@"选择表情");
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

//键盘显示的时候的处理
- (void)keyboardWasShown:(NSNotification*)aNotification
{
    CGRect rect = _inputView.frame;
    //获得键盘的大小
    NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.25];
    [UIView setAnimationCurve:7];
    _table.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-kbSize.height-44);
    _table.contentOffset = CGPointMake(0, _table.contentSize.height-_table.frame.size.height);
    _inputView.frame = CGRectMake(0, self.view.frame.size.height-kbSize.height-rect.size.height, self.view.frame.size.width, rect.size.height);
    [UIView commitAnimations];
}

//键盘消失的时候的处理
- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    CGRect rect = _inputView.frame;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.25];
    [UIView setAnimationCurve:7];
    _table.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-74-44);
    _inputView.frame = CGRectMake(0, self.view.frame.size.height-rect.size.height, self.view.frame.size.width, rect.size.height);
    [UIView commitAnimations];
}

#pragma mark -用户操作
-(void)sendMessage:(UIButton *)btn{
    NSLog(@"提交消息");
    if (_inputTextView.text == nil || [_inputTextView.text isEqualToString:@""])
    {
        UIAlertView *alerView = [[UIAlertView alloc] initWithTitle:@"警告" message:@"消息不能为空" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alerView show];
        return;
    }
    _inputTextView.text = nil;
    if (_inputView.frame.size.height >44) {
        CGRect rect = _inputView.frame;
        _inputView.frame = CGRectMake(0, rect.origin.y+_lastHeight-44, rect.size.width, 44);
    }
    _lastHeight = _inputView.frame.size.height;
}

#pragma mark -UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *indentifer = @"Cell";
    JuWeiListCell *cell = [tableView dequeueReusableCellWithIdentifier:indentifer];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"JuWeiListCell" owner:nil options:nil] lastObject];
    }
    [cell.imgView setImageWithURL:[NSURL URLWithString:@""] placeholderImage:[UIImage imageNamed:@"nav_db"]];
    [GlobalFunction radiusImageView:cell.imgView radius:5];
    cell.titleLable.text = @"物管";
    cell.subTitleLable.text = @"回应是否公审，该怎么判就怎么判";
    cell.timeLable.text = @"2015-02-22";
    return cell;
}

#pragma mark -UITableViewDelegae
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_inputView.frame.origin.y<self.view.bounds.size.height-_inputView.bounds.size.height) {
        [self.view endEditing:YES];
    }else{
        NSLog(@"didSelectRowAtIndexPath");
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 1;
}
#pragma mark -UITextViewDelegate
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }else{
        return YES;
    }
}

- (void)textViewDidChange:(UITextView *)textView
{
    CGSize textSize = [textView.text sizeWithFont:[UIFont systemFontOfSize:14.f]];
    NSUInteger lines = (NSUInteger)(textView.contentSize.height/textSize.height);
    
    CGFloat height = FootView_Height;
    if (lines > 1) {
        height = (lines - 1) * 20 + 44;
    }
    if (height >= 84) {
        height = 84;
    }
    if (_lastHeight <height) {
        CGRect rect = _inputView.frame;
        _inputView.frame = CGRectMake(0, rect.origin.y-20, rect.size.width, height);
    }else if(_lastHeight >height){
        CGRect rect = _inputView.frame;
        _inputView.frame = CGRectMake(0, rect.origin.y+20, rect.size.width, height);
    }
    _lastHeight = height;
    
    [_inputTextView scrollRectToVisible:CGRectMake(0, _inputTextView.contentSize.height-15, _inputTextView.contentSize.width, 15) animated:NO];
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
