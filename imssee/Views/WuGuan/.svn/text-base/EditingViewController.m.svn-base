//
//  EditingViewController.m
//  imssee
//
//  Created by app001.cn on 15-2-13.
//  Copyright (c) 2015年 鑫易. All rights reserved.
//
#define Margin 10

#import "EditingViewController.h"

@interface EditingViewController ()
{
    UIButton *_lastSelectBtn;
    NSInteger _publishState;

}
@end

@implementation EditingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
  
    [self initTabBar];
    [self setRoundBorder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -Private Methods
-(void)initTabBar{
    [self setNavTitle:self.title];
    
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.frame = CGRectMake(5, 25, 33, 33);
    [leftButton addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    [leftButton setBackgroundImage:[UIImage imageNamed:@"back_btn"] forState:UIControlStateNormal];
    [self settingWGLeftBarButtonItem:leftButton];
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn setImage:[UIImage imageNamed:@"setting.png"] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(sttingAction:) forControlEvents:UIControlEventTouchUpInside];
    [rightBtn setFrame:CGRectMake(SCREEN_WIDTH - 5 - 33, 25, 33, 33)];
    [self settingWGRightBarButtonItem:rightBtn];
    
}

-(void)setRoundBorder{
    self.titleTF.layer.cornerRadius = 5;
    self.titleTF.layer.borderWidth = 1;
    self.titleTF.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    self.textView.layer.cornerRadius = 5;
    self.textView.layer.borderWidth = 1;
    self.textView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    self.selectBtnL.layer.borderWidth = 1;
    self.selectBtnL.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.selectBtnR.layer.borderWidth = 1;
    self.selectBtnR.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    self.sendBtn.layer.cornerRadius = 5;
    self.sendBtn.layer.borderWidth = 1;
    self.sendBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    self.saveBtn.layer.cornerRadius = 5;
    self.saveBtn.layer.borderWidth = 1;
    self.saveBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    self.previewBtn.layer.cornerRadius = 5;
    self.previewBtn.layer.borderWidth = 1;
    self.previewBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;

}

-(void)back:(UIButton *)btn{
    [self dismissViewControllerAnimated:NO completion:nil];
}

-(void)sttingAction:(UIButton *)btn{
    NSLog(@"sttingAction");
}

- (IBAction)selectBtnClicked:(id)sender {
    _lastSelectBtn.backgroundColor = [UIColor whiteColor];
    UIButton *button = (UIButton *)sender;
    button.backgroundColor = [UIColor greenColor];
    _lastSelectBtn = button;
    if (button.tag ==0) {
        NSLog(@"全部业主");
    }else{
        NSLog(@"挑选");
    }
}

- (IBAction)sendBtnClicked:(id)sender {
    UIButton *btn = (UIButton *)sender;
    _publishState = btn.tag;
    [WGProgressHUD showHUDAddedTo:self.navigationController.view status:@"发表中,请稍后..."];
//    [self submitEditText];
    [UIHelper alertWithTitle:@"点击了发送按钮"];
}

- (IBAction)saveBtnClicked:(id)sender {
    if ([self.titleTF.text  isEqual: @""]) {
        [UIHelper alertWithTitle:@"标题不能为空"];
        return;
    }
    UIButton *btn = (UIButton *)sender;
    _publishState = btn.tag;
    [WGProgressHUD showHUDAddedTo:self.view status:@"保存中,请稍后"];
    [self submitEditText];
}

- (IBAction)previewBtnClicked:(id)sender {
    [UIHelper alertWithTitle:@"点击了预览按钮"];
}

// 打包参数
- (NSDictionary *)packageRequestParams
{
    //TODO:以下为测试接口数据
    NSString *title = self.titleTF.text;
    NSString *context = self.textView.text;
    NSString *msType = @"0";
    NSString *to = @"12121";
    long authorId = 1;
       
    NSDictionary *params = @{@"title":title,@"context":context,@"msType":msType,@"to":to,@"publishState":[NSNumber numberWithLong:_publishState],@"authorId":[NSNumber numberWithLong:authorId],};
    return params;
}

//提交文本
- (void)submitEditText
{
    __weak EditingViewController *blockSelf = self;
    NSDictionary *params = [self packageRequestParams];
    [[HttpRequest sharedInstance] wuGuanMessageSaveWithParams:params
                                        completionBlock:^(id result) {
                                            NSLog(@"TextResult:%@",result[@"result"]);
                                            if ([result[@"ec"] doubleValue] != 0) {
                                                [WGProgressHUD showErrorWith:blockSelf.view status:_publishState==1?@"发表失败":@"保存失败"];
                                                return ;
                                            }

                                            
                                            [WGProgressHUD showSuccessWith:blockSelf.view status:_publishState==1?@"发表成功":@"保存成功"];
                                          //  [[NSNotificationCenter defaultCenter] postNotificationName:kRefresh_PersonalPublishList object:nil];
                                            [self performSelector:@selector(dismissViewController) withObject:self afterDelay:1.0];
                                        }
                                           failureBlock:^(NSError *error, NSString *responseStr) {
                                               NSLog(@"Error:%@",[error localizedDescription]);
                                               [WGProgressHUD showErrorWith:blockSelf.view status:_publishState==1?@"发表失败":@"保存失败"];
                                           }];
}

-(void)dismissViewController{
    [self dismissViewControllerAnimated:NO completion:nil];
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
