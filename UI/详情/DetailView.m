//
//  DetailView.m
//  万表
//
//  Created by mac on 16/3/4.
//  Copyright © 2016年 zm. All rights reserved.
//

#import "DetailView.h"
#define SCREENW ([[UIScreen mainScreen] bounds].size.width)

@implementation DetailView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self) {
        self = [super initWithFrame:frame];
        [self addView];
        
    }
    return self;
}
- (void)addView
{
    _i=20;
    _x=SCREENW-100;
    UIView *view1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, 64)];
    
    _GundongLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCREENW-100, 20, self.frame.size.width-200, 40)];
    
    _GundongLabel.text = @"周年庆活动，购买商品有优惠，可以参加抽奖活动";
    _GundongLabel.textColor = [UIColor blackColor];

    
    _timer = [NSTimer timerWithTimeInterval:0.2 target:self selector:@selector(timeChange) userInfo:nil repeats:YES];
    NSRunLoop *run = [NSRunLoop currentRunLoop];
    [run addTimer:_timer forMode:NSRunLoopCommonModes];
   
    
    UIView *shardView1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 100, 64)];
    shardView1.backgroundColor = [UIColor whiteColor];
    
    UIView *shardView2 = [[UIView alloc]initWithFrame:CGRectMake(SCREENW-100, 0, 100, 64)];
     shardView2.backgroundColor = [UIColor whiteColor];
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(20, 20, 40, 40)];
    [btn setTitle:@"返回" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [shardView1 addSubview:btn];
    [view1 addSubview:_GundongLabel];

    [view1 addSubview:shardView2];
    [view1 addSubview:shardView1];
   
    
    UILabel *tmp = [[UILabel alloc]initWithFrame:CGRectMake(0, 64, SCREENW, 1)];
    tmp.backgroundColor = [UIColor blackColor];
    [view1 addSubview:tmp];
    [self addSubview:view1];
}
- (void)btnClick
{
    if (_flag == 1) {
        self.vc.navigationController.navigationBarHidden=YES;
    }else{
        self.vc.navigationController.navigationBarHidden=NO;
    }
    [self.vc.navigationController popToRootViewControllerAnimated:YES];
}

- (void)timeChange{
    _x = _x-_i;
    [_GundongLabel setFrame:CGRectMake(_x, 20, self.frame.size.width-200, 40)];
    if (_x<=-(self.frame.size.width-300)) {
        [_GundongLabel setFrame:CGRectMake(SCREENW-100, 20, self.frame.size.width-200, 40)];
        _x=SCREENW-100;
    }
}
@end
