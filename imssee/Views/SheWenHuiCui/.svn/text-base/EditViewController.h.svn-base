//
//  EditViewController.h
//  imssee
//
//  Created by imsseeios3 on 15/2/12.
//  Copyright (c) 2015年 鑫易. All rights reserved.
//

#import "SHViewController.h"

@class HSList;
@interface EditViewController : SHViewController
{
    __weak IBOutlet UIScrollView *_contentView;
    
}

@property (nonatomic, strong) HSList *HSListModel;

@end



@interface PublishImage : UIImageView

@property (nonatomic, getter=isDeleteImage) BOOL deleteImage;

- (instancetype)initWithFrame:(CGRect)frame image:(UIImage *)image;

- (void)addTarget:(id)target action:(SEL)action;

@end


@class MarkCheckScrollView;
@interface TextEditView : UIView

@property (nonatomic, strong) UITextField *titleTF;

@property (nonatomic, strong) UITextView *contentTV;

@property (nonatomic, strong) UISegmentedControl *segMent;

@property (nonatomic, assign) NSInteger mark;

@property (nonatomic, strong) MarkCheckScrollView *checkScro;

- (instancetype)initTextEditViewWithFrame:(CGRect)frame;

@end



typedef void(^CheckActionBlock)(id selectedItem);
@interface MarkCheckScrollView : UIScrollView

@property (nonatomic, strong) NSArray *dataSource;

@property (nonatomic, assign) NSUInteger selectedIndex;

@property (nonatomic, copy) CheckActionBlock checkActionBlock;

- (instancetype)initWithFrame:(CGRect)frame dataSource:(NSArray *)dataSource;

- (void)addTarget:(id)target actionBlock:(CheckActionBlock)actionBlock;

@end
