//
//  WGCustomizedAlert.m
//  imssee
//
//  Created by 鑫易 on 15/1/15.
//  Copyright (c) 2015年 鑫易. All rights reserved.
//

#import "WGCustomizedAlert.h"
static CGFloat kTransitionDuration = 0.24;

@interface WGCustomizedAlert ()

@property(nonatomic, strong) UIView * overLayWindowView;

@end

@implementation WGCustomizedAlert
{
    __block BOOL isPoped;
    __block BOOL banBackClickDismiss;
}

@synthesize view;
@synthesize delegate;
@synthesize overLayWindowView = _overLayWindowView;

- (void)dealloc
{
    if (delegate) {
        delegate = nil;
    }
    
    view = nil;
    _overLayWindowView = nil;
}

- (UIView *)overLayWindowView{
    if (!_overLayWindowView) {
        _overLayWindowView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _overLayWindowView.backgroundColor = [UIColor blackColor];
        _overLayWindowView.alpha = 0.2;
        
        __weak UIView *windowView = _overLayWindowView;
        
        windowView.tapAction = ^(UITapGestureRecognizer *tap){
            if (banBackClickDismiss) {
                return ;
            }
            [self overlayClickAction];
        };
    }
    
    return _overLayWindowView;
}

- (void)overlayClickAction{
    [self dismissAlertAnimation];
}

- (id)initCustomizedAlertWithUIView:(UIView *)superview
{
    if (self = [super init]) {
        if (!view.superview) {
            view = superview;
        }
    }
    return self;
}

//get the transform of view based on the orientation of device
- (CGAffineTransform)transformForOrientation{
    CGAffineTransform transform;
    UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
    
    switch (orientation) {
        case UIInterfaceOrientationLandscapeLeft:
            transform = CGAffineTransformMakeRotation(M_PI*1.5);
            break;
        case UIInterfaceOrientationLandscapeRight:
            transform = CGAffineTransformMakeRotation(M_PI/2);
            break;
        case UIInterfaceOrientationPortrait:
            transform = CGAffineTransformMakeRotation(-M_PI);
            break;
        default:
            transform = CGAffineTransformIdentity;
            break;
    }
    
    return transform;
}

- (void)showAlertWithParentView:(UIView *)parentView
{
    [self showAlertWithParentView:parentView withOffSetTop:0];
}

- (void)showAlertWithParentView:(UIView *)parentView withOffSetTop:(float)offsetY
{
    [self showAlertWithParentView:parentView withOffSetTop:offsetY withBanBackClickDismiss:NO];
}

- (void)canDismiss:(BOOL)dismiss
{
    banBackClickDismiss = dismiss;
}

- (void)showAlertWithParentView:(UIView *)parentView withOffSetTop:(float)offsetY withBanBackClickDismiss:(BOOL)ban
{
    if(!view){
        return;
    }
    banBackClickDismiss=ban;
    
    float w=view.frame.size.width;
    float h=view.frame.size.height;
    float screenW=parentView.bounds.size.width;
    float screenH=parentView.bounds.size.height;
    float left=(screenW-w)/2.;
    float top=(screenH-h)/2.+offsetY;
    view.frame=CGRectMake(left, top, w, h);
    self.overLayWindowView.frame=parentView.bounds;
    //[self.overLayWindowView setFullAdjust];
    [parentView addSubview:self.overLayWindowView];
    [parentView addSubview:view];
    [self showAlertAnimation];
}

// begin the animation
- (void)showAlertAnimation
{
    if(!view){
        return;
    }
    view.transform = CGAffineTransformScale([self transformForOrientation], 0.001, 0.001);
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:kTransitionDuration/1.5];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(firstBouncesDidStop)];
    view.transform = CGAffineTransformScale([self transformForOrientation], 1.04, 1.04);
    if(_overLayWindowView){
        _overLayWindowView.alpha=0.55;
    }
    [UIView commitAnimations];
}

- (void)dismissAlertAnimation
{
    if (!isPoped) {
        return;
    }
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:kTransitionDuration/2];
    [UIView setAnimationDelegate:self];
    view.alpha = 0;
    if (_overLayWindowView) {
        _overLayWindowView.alpha = 0;
    }
    [UIView setAnimationDidStopSelector:@selector(dismissAlertAnimationDidStoped)];
    [UIView commitAnimations];
}

#pragma mark -- UIViewAnimation Delegate
- (void)firstBouncesDidStop{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDuration:kTransitionDuration/2];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(secondBouncesDidStop)];
    view.transform = CGAffineTransformScale([self transformForOrientation], 0.9, 0.9);
    [UIView commitAnimations];
}

- (void)secondBouncesDidStop{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDuration:kTransitionDuration/2];
    view.transform = [self transformForOrientation];
    [UIView commitAnimations];
    //You can do somethings at the end of animation
    [self.delegate showCustomizedAlertIsOverWithUIView:view];
    isPoped = YES;
}

- (void)dismissAlertAnimationDidStoped{
    [self.delegate dismissCustomizedAlertIsOverWithUiView:view];
    if (_overLayWindowView) {
        [view removeFromSuperview];
    }
    if (self.dismissEnd) {
        self.dismissEnd();
    }
}

@end
