//
//  ShouYeCell.m
//  万表
//
//  Created by mac on 16/3/2.
//  Copyright © 2016年 zm. All rights reserved.
//

#import "ShouYeCell.h"
#import "Goods.h"
#import "UIButton+WebCache.h"
#import "DetailViewController.h"
#define SCREEN_WIDTH    ([[UIScreen mainScreen] bounds].size.width)
//#define SCREEN_WIDTH self.contentView.frame.size.width
#define SCREEN_HEIGHT   ([[UIScreen mainScreen] bounds].size.height)
@implementation ShouYeCell


#pragma mark 更新数据的操作
- (void)refreshData:(Goods *)goods and:(Goods *)goods2
{
    
    self.nameLable.text = goods.name;
    self.priceLable.text = [goods getNumByPrice:goods.price];
    self.nameLable1.text = goods2.name;
    self.priceLable1.text = [goods2 getNumByPrice:goods.price];
    self.goods1 = goods;
    self.goods2 = goods2;
   
    NSURL *url = [goods.imageArray objectAtIndex:0];
   [self.imageBtn1 sd_setBackgroundImageWithURL:url forState:UIControlStateNormal];
    [self.imageBtn1 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.imageBtn1.tag = 1;
    
    
    NSURL *url1 = [goods2.imageArray objectAtIndex:0];
    [self.imageBtn2 sd_setBackgroundImageWithURL:url1 forState:UIControlStateNormal];
    [self.imageBtn2 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.imageBtn2.tag = 2;
}
- (void)btnClick:(UIButton *)btn
{
    
    DetailViewController *vc1 = [[DetailViewController alloc]init];
    vc1.hidesBottomBarWhenPushed=YES;
    if (btn.tag==1) {
        vc1.goods = self.goods1;
    }else if (btn.tag==2)
    {
        vc1.goods = self.goods2;
    }
    vc1.flag = 1;
    [self.vc.navigationController pushViewController:vc1 animated:YES];
    vc1.hidesBottomBarWhenPushed=NO;
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
