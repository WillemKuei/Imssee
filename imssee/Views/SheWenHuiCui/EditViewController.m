//
//  EditViewController.m
//  imssee
//
//  Created by imsseeios3 on 15/2/12.
//  Copyright (c) 2015年 鑫易. All rights reserved.
//

#import "EditViewController.h"
#import "ELCImagePickerHeader.h"
#import "HSList.h"

#define Margin 10

@interface EditViewController ()<UIActionSheetDelegate,ELCImagePickerControllerDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>
{
    UIView *_displayView;
    TextEditView *_textEditView;
    UIView *_buttomView;
    NSMutableArray *_images;
    UIActionSheet *_actionSheet;
    NSInteger _imageCount;
    NSInteger _uploadCount;
    EditViewController *_blockSelf;
    NSMutableString *_imagePath;
    NSInteger _publishState;
}

@end

@implementation EditViewController

#pragma mark LifeCycle
- (void)dealloc
{
    Release(_contentView);
    Release(_displayView);
    Release(_images);
    Release(_actionSheet);
    Release(_textEditView);
    Release(_buttomView);
    Release(_imagePath);
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [_contentView setContentSize:CGSizeMake(0, 600)];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initEditView];
    if (self.HSListModel) {
        [self complementEditView];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark Private Method
static CGFloat image_width = 60,image_height = 60;
- (void)initEditView
{
    if (iPhone6Plus) {
        image_width = 80;
        image_height = 80;
    }
    //图片展示View
    _displayView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, image_height + 20)];
//    _displayView.backgroundColor = BLUE_COLOR;
    [_contentView addSubview:_displayView];
    //addImage
    PublishImage *addImage = [[PublishImage alloc] initWithFrame:CGRectMake(Margin, Margin, image_width, image_height) image:[UIImage imageNamed:@"add_image.png"]];
    addImage.deleteImage = NO;
    [addImage addTarget:self action:@selector(clickImage:)];
    [_displayView addSubview:addImage];
    
    _images = [[NSMutableArray alloc] initWithCapacity:0];
    [_images addObject:addImage];
    
    //文字编辑View
    _textEditView = [[TextEditView alloc] initTextEditViewWithFrame:CGRectMake(0, _displayView.frame.origin.y + _displayView.frame.size.height + Margin, SCREEN_WIDTH, 500)];
//    _textEditView.backgroundColor = [UIColor orangeColor];
    [_contentView addSubview:_textEditView];
    
    //UIActionSheet
    _actionSheet = [[UIActionSheet alloc] initWithTitle:@"请选择路径" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"相册",@"照相", nil];
    
    [self createButtomButton];
    
    _blockSelf = self;
    __weak TextEditView *blockTextEditView = _textEditView;
    self.navigationController.view.tapAction = ^(UITapGestureRecognizer *tap){
        [blockTextEditView.titleTF resignFirstResponder];
        [blockTextEditView.contentTV resignFirstResponder];
    };
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showKeyboard:) name:UIKeyboardDidShowNotification object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hideKeyboard:) name:UIKeyboardDidHideNotification object:nil];
}

/**
 *  @desc 填补数据
 */
- (void)complementEditView
{
    //imagePath
    NSArray *imagePaths = [self.HSListModel.imagePath componentsSeparatedByString:@","];
    for (NSString *imagePath in imagePaths) {
        PublishImage *pubImage = [[PublishImage alloc] initWithFrame:CGRectZero image:nil];
        [pubImage setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",ImagePath_IP,imagePath]] placeholderImage:[UIImage imageNamed:@"icon_text"]];
        pubImage.deleteImage = YES;
        [pubImage addTarget:self action:@selector(clickImage:)];
        [_images insertObject:pubImage atIndex:0];
    }
    
    //title
    _textEditView.titleTF.text = self.HSListModel.title;
    //content
    _textEditView.contentTV.text = self.HSListModel.context;
    //mark
//    _textEditView.checkScro.selectedIndex = [self.HSListModel.type integerValue];
    //seg
    _textEditView.segMent.selectedSegmentIndex = self.HSListModel.isComment;
    
    [self reloadDisplayView];
}

/**
 *  @desc 创建三个按钮,保存，发表，预览
 */
- (void)createButtomButton
{
    float btn_width = (SCREEN_WIDTH - Margin * 2)/3 - Margin;
    float origin_y = _textEditView.frame.size.height + _textEditView.frame.origin.y + Margin * 3;
    float btn_height = 30;
    _buttomView = [[UIView alloc] initWithFrame:CGRectMake(0, origin_y, SCREEN_WIDTH, btn_height)];
    [_contentView addSubview:_buttomView];
    
    CGRect rect = CGRectZero;
    NSArray *titles = @[@"保存",@"发表",@"预览"];
    for (int i = 0; i < 3; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        rect = CGRectMake(Margin + Margin/2 + (btn_width + Margin) * i, 0, btn_width, btn_height);
        [button setFrame:rect];
        [button setTitle:titles[i] forState:UIControlStateNormal];
        button.layer.borderWidth = 1.0f;
        button.layer.cornerRadius = 3.0f;
        button.layer.masksToBounds = YES;
        button.tag = i;
        if (i == 0) {
            button.backgroundColor = PinkColor;
            [button setTitleColor:WHITE_COLOR forState:UIControlStateNormal];
            button.layer.borderColor = PinkColor.CGColor;
        } else {
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            button.layer.borderColor = GrayColor.CGColor;
        }
        [button addTarget:self action:@selector(buttomButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [_buttomView addSubview:button];
    }
}

- (void)reloadDisplayView
{
    for (UIView *subView in _displayView.subviews) {
        [subView removeFromSuperview];
    }
    
    CGRect frame = CGRectZero;
    CGFloat origin_x = Margin, origin_y = Margin;
    CGFloat screen_width = _displayView.frame.size.width;
    
    int rowImgs = screen_width/(image_width+Margin);      //计算一行可以放多少张图片
    int row_y = 0;          //0行开始
    int row_x = 0;    //当前image位置行的哪个位置
    for (int i = 0; i < _images.count; i++)
    {
        //计算当前image是位于第几行--------注：0行开始
        row_y = i/rowImgs;
        //计算当前image位置哪个位置
        row_x = i%rowImgs;
        NSLog(@"row_y:%.d,row_x:%.d",row_y,row_x);
        
        PublishImage *image = _images[i];
        origin_x = Margin + (image_width + Margin) * row_x;
        origin_y = Margin + (image_height + Margin) * row_y;
        frame = CGRectMake(origin_x, origin_y, image_width, image_height);
        image.frame = frame;
        [_displayView addSubview:image];
        
        if (i == _images.count - 1) {
            CGRect disPlayRect = _displayView.frame;
            disPlayRect = CGRectMake(disPlayRect.origin.x, disPlayRect.origin.y, disPlayRect.size.width, image.frame.origin.y + image_height + Margin);
            _displayView.frame = disPlayRect;
        }
    }
    
    [self resetContentViewFrame];
}

/**
 *  @desc 重置fram
 */
- (void)resetContentViewFrame
{
    CGRect editTextRect = _textEditView.frame;
    editTextRect = CGRectMake(editTextRect.origin.x, _displayView.frame.origin.y + _displayView.frame.size.height + Margin, editTextRect.size.width, editTextRect.size.height);
    _textEditView.frame = editTextRect;
    
    CGRect buttomViewRect = _buttomView.frame;
    buttomViewRect = CGRectMake(buttomViewRect.origin.x, editTextRect.origin.y + editTextRect.size.height + Margin * 3, buttomViewRect.size.width, buttomViewRect.size.height);
    _buttomView.frame = buttomViewRect;
}

/**
 *  @desc 打包参数
 *
 *  @return params
 */
- (NSDictionary *)packageRequestParams
{
    //TODO:以下为测试接口数据
    NSString *title = _textEditView.titleTF.text;
    NSString *context = _textEditView.contentTV.text;
    NSString *type = @"0";
    NSString *isComment = @"0";
    NSString *imagePath = _imagePath.length>0?_imagePath:@"";
    NSString *authorId = @"1";
    NSString *columnNo = @"1210";
    NSString *addrss = @"";
    NSString *communityId = @"1";
    NSString *newsId = self.HSListModel?[NSString stringWithFormat:@"%ld",self.HSListModel.newsId]:@"";
    NSDictionary *params = @{@"title":title,@"context":context,@"type":type,@"isComment":isComment,@"publishState":[NSString stringWithFormat:@"%ld",(long)_publishState],@"imagePath":imagePath,@"authorId":authorId,@"columnNo":columnNo,@"addrss":addrss,@"communityId":communityId,@"newsId":newsId};
    return params;
}

/**
 *  @desc 上传图片
 */
- (void)uploadImage
{
    PublishImage *pubImage = _images[_uploadCount];
    [[HttpRequest sharedInstance] uploadImageWithImage:pubImage.image completionBlock:^(id result) {
        NSLog(@"result:%@",result);
        if ([result[@"ec"] doubleValue] == 0) {
            NSString *resultImage = result[@"result"][0][@"image"];
            if (_imagePath == nil) {
                _imagePath = [[NSMutableString alloc] initWithFormat:@"%@%@",resultImage,(_uploadCount == _images.count - 2?@"":@",")];
            }
            [_imagePath appendFormat:@"%@%@",resultImage,(_uploadCount == _images.count - 2?@"":@",")];
        }
        
        _uploadCount++;
        if (_uploadCount < [_images count] - 1) {       //有照片未上传完，注：要减去默认的照片-1
            [_blockSelf uploadImage];
        } else {
            _uploadCount = 0;       //上传完要置0
            NSLog(@"_imagePath:%@",_imagePath);
            [self submitEditText];
        }
    } failureBlock:^(NSError *error, NSString *responseStr) {
        NSLog(@"error:%@",[error localizedDescription]);
    }];
}

/**
 *  @desc 提交文本
 */
- (void)submitEditText
{
    NSDictionary *params = [self packageRequestParams];
    [[HttpRequest sharedInstance] publishNewsWithParams:params
                                        completionBlock:^(id result) {
                                            NSLog(@"TextResult:%@",result);
                                            if ([result[@"ec"] doubleValue] != 0) {
                                                [WGProgressHUD showErrorWith:_blockSelf.navigationController.view status:_publishState==1?@"发表失败":@"保存失败"];
                                                return ;
                                            }
                                            
                                            
                                            [WGProgressHUD showSuccessWith:_blockSelf.navigationController.view status:_publishState==1?@"发表成功":@"保存成功"];
                                            _imagePath = nil;
                                            [[NSNotificationCenter defaultCenter] postNotificationName:kRefresh_PersonalPublishList object:nil];
                                            sleep(1.5);
                                            [_blockSelf.navigationController popViewControllerAnimated:YES];
                                        }
                                           failureBlock:^(NSError *error, NSString *responseStr) {
                                               NSLog(@"Error:%@",[error localizedDescription]);
                                               [WGProgressHUD showErrorWith:_blockSelf.navigationController.view status:_publishState==1?@"发表失败":@"保存失败"];
                                           }];
}

/**
 *  @desc 显示/隐藏keyboard
 */
- (void)showKeyboard:(NSNotification *)notification
{
    if ([_textEditView.titleTF isEditing]) {        //title正在编辑
        return;
    } else {
        float offSet = 0;
        if (iPhone4Retina) {
            offSet = 100;
        }
    }
}

- (void)hideKeyboard:(NSNotification *)notification
{
    
}

#pragma mark User Action
/**
 *  @desc 点击图片
 *
 *  @param imageView
 */
- (void)clickImage:(PublishImage *)imageView
{
    if (!imageView.deleteImage) {
        if (_images.count >= 7) {
            [UIHelper alertWithTitle:@"温馨提示" andMSG:@"亲，照片最多不能超过6张哦！"];
            return;
        }
        [_actionSheet showInView:self.view];
    } else {
        [_images removeObject:imageView];
        [self reloadDisplayView];
    }
}


/**
 *  @desc ButtomButton点击
 *
 *  @param sender
 */
- (void)buttomButtonClick:(UIButton *)sender
{
    if (sender.tag == 2) {      //预览
        [UIHelper alertWithTitle:@"温馨提示" andMSG:@"此功能正在开发中..."];
        return;
    }
    
    _publishState = sender.tag;
    [WGProgressHUD showHUDAddedTo:self.navigationController.view status:_publishState == 0?@"保存中,请稍后":@"发表中,请稍后..."];
    
     if ([_images count] > 1 && _imagePath == nil) {     //有图片未上传，先上传图片
         [self uploadImage];
     } else {            //没有图片上传，或者图片上传完，但发表失败，此时可以直接再次发表
         [self submitEditText];
     }
}

#pragma mark UIActionSheetDelegate Methods
#define MaxImages 6
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 2) {
        return;
    }
    
    if (buttonIndex == 0) {     //相册
        ELCImagePickerController *elcPicker = [[ELCImagePickerController alloc] initImagePicker];
        elcPicker.maximumImagesCount = (MaxImages - _images.count) + 1;
        elcPicker.returnsOriginalImage = YES;
        elcPicker.returnsImage = YES;
        elcPicker.onOrder = YES;
        elcPicker.mediaTypes = @[(NSString *)kUTTypeImage,(NSString *)kUTTypeMovie]; //Supports image and movie types(kUTTypeMovie)
        elcPicker.imagePickerDelegate = self;
        [self presentViewController:elcPicker animated:YES completion:NULL];
    } else if (buttonIndex == 1) {      //照相
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.sourceType = (buttonIndex == 0)?UIImagePickerControllerSourceTypePhotoLibrary:UIImagePickerControllerSourceTypeCamera;
        picker.delegate = self;
        picker.allowsEditing = YES;
        if (picker.sourceType == UIImagePickerControllerSourceTypePhotoLibrary) {
            picker.videoQuality = UIImagePickerControllerQualityTypeLow;
        }
        [self presentViewController:picker animated:YES completion:NULL];
    }
}

#pragma mark UIImagePickerController Delegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:NULL];
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    if ([type isEqualToString:@"public.image"]) {
        UIImage *image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
        //裁剪图片
        CGSize size = CGSizeMake(60, 60);
        if (iPhone6Plus) {
            size = CGSizeMake(80, 80);
        }
        image = [GlobalFunction OriginImage:image scaleToSize:size];
        //压缩图片
        NSData *data;
        if (UIImagePNGRepresentation(image) == nil) {
            data = UIImageJPEGRepresentation(image, 0.5);
        } else {
            data = UIImagePNGRepresentation(image);
        }
        
        PublishImage *pubImage = [[PublishImage alloc] initWithFrame:CGRectZero image:[UIImage imageWithData:data]];
        pubImage.deleteImage = YES;
        pubImage.userInteractionEnabled = YES;
        [pubImage addTarget:self action:@selector(clickImage:)];
        [_images insertObject:pubImage atIndex:0];
        
        [self reloadDisplayView];
    }
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    DLog(@"您取消了选择照片!");
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

#pragma mark ELCImagePickerControllerDelegate Methods
- (void)elcImagePickerController:(ELCImagePickerController *)picker didFinishPickingMediaWithInfo:(NSArray *)info
{
    [self dismissViewControllerAnimated:YES completion:NULL];
    //裁剪图片
    CGSize size = CGSizeMake(60, 60);
    if (iPhone6Plus) {
        size = CGSizeMake(80, 80);
    }
    for (NSDictionary *dict in info) {
        UIImage *image = nil;
        if ([dict objectForKey:UIImagePickerControllerOriginalImage]) {     //选图片
            image = [dict objectForKey:UIImagePickerControllerOriginalImage];
        } else if ([dict objectForKey:UIImagePickerControllerMediaType] == ALAssetTypeVideo) {  //选择视频
            if ([dict objectForKey:UIImagePickerControllerOriginalImage]) {
                image = [dict objectForKey:UIImagePickerControllerOriginalImage];
            }
        }
        
        image = [GlobalFunction OriginImage:image scaleToSize:size];
        //压缩图片
        NSData *data;
        if (UIImagePNGRepresentation(image) == nil) {
            data = UIImageJPEGRepresentation(image, 0.5);
        } else {
            data = UIImagePNGRepresentation(image);
        }
        
        PublishImage *pubImage = [[PublishImage alloc] initWithFrame:CGRectZero image:[UIImage imageWithData:data]];
        pubImage.deleteImage = YES;
        [pubImage addTarget:self action:@selector(clickImage:)];
        [_images insertObject:pubImage atIndex:0];
    }
    
    [self reloadDisplayView];
}

- (void)elcImagePickerControllerDidCancel:(ELCImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
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




@implementation PublishImage

- (instancetype)initWithFrame:(CGRect)frame image:(UIImage *)image
{
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
        self.image = image;
    }
    return self;
}

- (void)addTarget:(id)target action:(SEL)action
{
    __weak EditViewController *blockTarget = (EditViewController *)target;
    __weak PublishImage *blockSelf = self;
    self.tapAction = ^(UITapGestureRecognizer *tap){
        [blockTarget performSelector:action withObject:blockSelf afterDelay:0];
    };
}

@end



@implementation TextEditView

- (instancetype)initTextEditViewWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self didLoadTextEditView];
    }
    return self;
}

#define Simple_Margin 5
#define Lab_Height 20
- (void)didLoadTextEditView
{
    CGRect frame = CGRectZero;
    //标题
    UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(Margin, 0, 80, Lab_Height)];
    titleLab.font = [UIFont systemFontOfSize:20.f];
    titleLab.textColor = [UIColor blackColor];
    titleLab.text = @"标题";
    [self addSubview:titleLab];
    frame = titleLab.frame;
    
    UITextField *titleTextField = [[UITextField alloc] initWithFrame:CGRectMake(frame.origin.x, frame.origin.y + frame.size.height + Simple_Margin, self.frame.size.width - Margin * 2, 30)];
    titleTextField.font = [UIFont systemFontOfSize:16.f];
    titleTextField.placeholder = @"请输入标题";
    titleTextField.borderStyle = UITextBorderStyleRoundedRect;
    self.titleTF = titleTextField;
    [self addSubview:self.titleTF];
    frame = titleTextField.frame;
    
    //内容
    UILabel *contentLab = [[UILabel alloc] initWithFrame:CGRectMake(frame.origin.x, frame.origin.y + frame.size.height + Margin * 2, 80, Lab_Height)];
    contentLab.font = [UIFont systemFontOfSize:20.f];
    contentLab.textColor = [UIColor blackColor];
    contentLab.text = @"内容";
    [self addSubview:contentLab];
    frame = contentLab.frame;
    
    UITextView *contentTextView = [[UITextView alloc] initWithFrame:CGRectMake(frame.origin.x, frame.origin.y + frame.size.height + Simple_Margin, titleTextField.frame.size.width, 100)];
    contentTextView.font = titleTextField.font;
    contentTextView.layer.masksToBounds = YES;
    contentTextView.layer.borderWidth = 1.0f;
    contentTextView.layer.borderColor = GrayColor.CGColor;
    contentTextView.layer.cornerRadius = 3.0f;
    self.contentTV = contentTextView;
    [self addSubview:self.contentTV];
    frame = contentTextView.frame;
    
    //标签
    UILabel *markLab = [[UILabel alloc] initWithFrame:CGRectMake(frame.origin.x, frame.origin.y + frame.size.height + Margin * 2, 40, Lab_Height)];
    markLab.font = [UIFont systemFontOfSize:20.f];
    markLab.textColor = [UIColor blackColor];
    markLab.text = @"标签";
    [self addSubview:markLab];
    frame = markLab.frame;
    
    MarkCheckScrollView *checkScro = [[MarkCheckScrollView alloc] initWithFrame:CGRectMake(frame.origin.x + frame.size.width + Margin, frame.origin.y, contentTextView.frame.size.width - 40 - Margin, 20) dataSource:@[@"段子",@"笑话",@"乐事",@"八卦",@"其它"]];
    [checkScro addTarget:self actionBlock:^(id selectedItem) {
        UIButton *button = (UIButton *)selectedItem;
        self.mark = button.tag - 4000;
        NSLog(@"选择了:%@,Mark:%ld",button.titleLabel.text,(long)self.mark);
    }];
    self.checkScro = checkScro;
    [self addSubview:checkScro];
    
    //是否允许评论
    UILabel *segLab = [[UILabel alloc] initWithFrame:CGRectMake(frame.origin.x, frame.origin.y + frame.size.height + Margin * 2, 80, Lab_Height)];
    segLab.font = [UIFont systemFontOfSize:20.f];
    segLab.textColor = [UIColor blackColor];
    segLab.text = @"允许评论";
    [self addSubview:segLab];
    frame = segLab.frame;
    
    NSArray *segments = @[@"消息",@"首页"];
    UISegmentedControl *seg = [[UISegmentedControl alloc] initWithItems:segments];
    seg.backgroundColor = GrayColor;
    seg.selectedSegmentIndex = 0;
    seg.tintColor = [UIColor colorWithRed:236.f/255.f green:233.f/255.f blue:234.f/255.f alpha:1.0];
    [seg setFrame:CGRectMake(frame.origin.x + frame.size.width + Margin, frame.origin.y, 80, Lab_Height)];
    seg.layer.cornerRadius = 5.f;
    seg.layer.masksToBounds = YES;
    self.segMent = seg;
    [self addSubview:self.segMent];
    
    CGRect editViewRect = self.frame;
    editViewRect = CGRectMake(editViewRect.origin.x, editViewRect.origin.y, editViewRect.size.width, frame.origin.y + frame.size.height + Margin * 2);
    self.frame = editViewRect;
    
    titleLab = nil;
    contentLab = nil;
    segLab = nil;
    markLab = nil;
}

@end



@implementation MarkCheckScrollView

#define CHECK_TAG 4000
- (instancetype)initWithFrame:(CGRect)frame dataSource:(NSArray *)dataSource
{
    self = [super initWithFrame:frame];
    if (self) {
        self.dataSource = dataSource;
        self.selectedIndex = 0;
        self.showsHorizontalScrollIndicator = NO;
        [self didLoadCheckButton];
    }
    return self;
}

- (void)setSelectedIndex:(NSUInteger)selectedIndex
{
    if (_selectedIndex != selectedIndex) {
        UIButton *curBtn = (UIButton *)[self viewWithTag:_selectedIndex + CHECK_TAG];
        curBtn.selected = NO;
        curBtn.layer.borderColor = GrayColor.CGColor;
        
        _selectedIndex = selectedIndex;
    }
}

static float check_margin = 10;
static float btn_height = 20;
- (void)didLoadCheckButton
{
    NSInteger count = self.dataSource.count;
    float btn_width = (self.frame.size.width - check_margin * (count - 1)) / count;
    for (int i = 0; i < count - 1; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setFrame:CGRectMake(check_margin + (check_margin + btn_width) * i, 0, btn_width, btn_height)];
        btn.titleLabel.font = [UIFont systemFontOfSize:16.f];
        btn.titleLabel.textAlignment = NSTextAlignmentCenter;
        btn.layer.borderColor = (i==0?PinkColor:GrayColor).CGColor;
        btn.layer.borderWidth = 1.0f;
        btn.layer.masksToBounds = YES;
        btn.layer.cornerRadius = 2.0f;
        btn.selected = (i == 0)?YES:NO;
        btn.tag = CHECK_TAG + i;
        [btn setTitle:self.dataSource[i] forState:UIControlStateNormal];
        [btn setTitleColor:GrayColor forState:UIControlStateNormal];
        [btn setTitleColor:PinkColor forState:UIControlStateSelected];
        [btn addTarget:self action:@selector(checkButtonSelected:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
    }
    
    [self setContentSize:CGSizeMake((btn_width + check_margin) * count, 0)];
}

- (void)checkButtonSelected:(UIButton *)button
{
    if (self.selectedIndex != button.tag - CHECK_TAG) {
//        UIButton *curBtn = (UIButton *)[self viewWithTag:self.selectedIndex + CHECK_TAG];
//        curBtn.selected = NO;
//        curBtn.layer.borderColor = GrayColor.CGColor;
        
        button.selected = YES;
        button.layer.borderColor = PinkColor.CGColor;
        
        self.selectedIndex = button.tag - CHECK_TAG;
    }
    if (self.checkActionBlock) {
        self.checkActionBlock(button);
    }
}

- (void)addTarget:(id)target actionBlock:(CheckActionBlock)actionBlock
{
    self.checkActionBlock = actionBlock;
}

@end
