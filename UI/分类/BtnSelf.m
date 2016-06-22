//
//  BtnSelf.m
//  万表
//
//  Created by mac on 16/3/1.
//  Copyright © 2016年 zm. All rights reserved.
//

#import "BtnSelf.h"
#import "UIImageView+WebCache.h"
#import "DetailViewController.h"
#define WIDTH self.frame.size.width
#define HEIGHT self.frame.size.height

@implementation BtnSelf

- (instancetype)initWithGoods:(Goods *)goods andNav:(UINavigationController *)nav andFrame:(CGRect)frame{
    if (self) {
        //self = [super init];
        self = [super initWithFrame:frame];
        self.goods = goods;
        self.nav = nav;
        
        NSURL *url = [_goods.imageArray objectAtIndex:0];
        _myImageView = [[UIImageView alloc]init];
        [_myImageView sd_setImageWithURL:url];
        _myImageView.frame = CGRectMake(10, 10, WIDTH/3, HEIGHT-20);
        [self addSubview:_myImageView];
        
        _name = [[UILabel alloc]initWithFrame:CGRectMake(20+WIDTH/3, 20, WIDTH/3*2-30, HEIGHT/3)];
        _name.text = goods.name;
        _name.textAlignment = NSTextAlignmentCenter;
        _name.font = [_name.font fontWithSize:11];
        _name.numberOfLines = 0;
        [self addSubview:_name];
        
        _price = [[UILabel alloc]initWithFrame:CGRectMake(20+WIDTH/3, HEIGHT/2, WIDTH/3*2-30, HEIGHT/3)];
        _price.textAlignment = NSTextAlignmentCenter;
        _price.font = [_price.font fontWithSize:15];
        _price.textColor = [UIColor redColor];
        _price.text = [_goods getNumByPrice:_goods.price];
        [self addSubview:_price];
        
        [self addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}


- (void)btnClick:(UIButton *)btn {
    NSLog(@"跳转到详情界面");
    DetailViewController *vc = [[DetailViewController alloc]init];
    vc.goods= self.goods;
    vc.flag = 2;
    vc.flag = _flag;
    self.nav.navigationBarHidden = YES;
    vc.hidesBottomBarWhenPushed=YES;
    [self.nav pushViewController:vc animated:YES];
    vc.hidesBottomBarWhenPushed=NO;
}

@end
