//
//  NameAndPriceView.m
//  万表
//
//  Created by mac on 16/3/4.
//  Copyright © 2016年 zm. All rights reserved.
//

#import "NameAndPriceView.h"
#import "Goods.h"
#import "UIImageView+WebCache.h"

#define SCREENW ([[UIScreen mainScreen] bounds].size.width)
@implementation NameAndPriceView
@synthesize shareField,image;

- (instancetype)initWithFrame:(CGRect)frame and:(Goods *)goods
{
    if (self) {
        self = [super initWithFrame:frame];
        [self addView:goods];
    }
    return self;
}
- (void)addView:(Goods *)goods
{
    _goods = goods;
    int x = (int)goods.imageArray.count;
    UIScrollView *scrollView=[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREENW, 350)];
    
    [self addSubview:scrollView];
    
    for (int i=1; i<x; i++) {
        UIImageView *imageView=[[UIImageView alloc] init];
        imageView.frame=CGRectMake(SCREENW*(i-1), 0, SCREENW, 350);
        [imageView sd_setImageWithURL:goods.imageArray[i]];
        [scrollView addSubview:imageView];
        if (i == 0) {
            image = imageView.image;
        }
    }
    scrollView.contentSize=CGSizeMake((x-1)*SCREENW, 0);
    scrollView.showsHorizontalScrollIndicator=NO;
    scrollView.pagingEnabled=YES;
    UILabel *tmp = [[UILabel alloc]initWithFrame:CGRectMake(0, 350, SCREENW, 1)];
    tmp.backgroundColor = [UIColor blackColor];
    [self addSubview:tmp];
    UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(10, 362, 75, 20)];
    lable.text = @"商品名称:";
    [lable setTextColor:[UIColor redColor]];
    [self addSubview:lable];
    
    
   
    UILabel *namelable = [[UILabel alloc]initWithFrame:CGRectMake(95, 352, SCREENW-90, 40)];
    namelable.font = [UIFont systemFontOfSize:14];
    namelable.textColor = [UIColor blackColor];
    namelable.numberOfLines = 0;
    namelable.text = goods.name;
    [self addSubview:namelable];
    shareField = goods.name;
    
    UILabel *priceLable = [[UILabel alloc]initWithFrame:CGRectMake(10, 405, 75, 20)];
    priceLable.text = @"价格:";
    [priceLable setTextColor:[UIColor redColor]];
    [self addSubview:priceLable];
    
    UILabel *priceNumlable = [[UILabel alloc]initWithFrame:CGRectMake(95, 380, 300, 70)];
    priceNumlable.font = [UIFont systemFontOfSize:26];
    priceNumlable.textColor = [UIColor redColor];
    priceNumlable.text = [goods getNumByPrice:goods.price];
    [self addSubview:priceNumlable];
    
    UILabel *pinpaiLable = [[UILabel alloc]initWithFrame:CGRectMake(10, 450, 150, 10)];
    NSString *str = [NSString stringWithFormat:@"品牌:%@",goods.pinpai];
    pinpaiLable.text = str;
    pinpaiLable.font = [UIFont systemFontOfSize:14];
    [pinpaiLable setTextColor:[UIColor grayColor]];
    [self addSubview:pinpaiLable];
    

    UILabel *lable2 = [[UILabel alloc]initWithFrame:CGRectMake(10, 480, 150, 10)];
    NSString *str1 = [NSString stringWithFormat:@"编号:%@",goods.bianhao];
    lable2.text = str1;
    lable2.textColor = [UIColor grayColor];
    lable2.font= [UIFont systemFontOfSize:14];
    [self addSubview:lable2];
    
    UILabel *lable3 = [[UILabel alloc]initWithFrame:CGRectMake(10, 510, 150, 10)];
    NSString *str3 = [NSString stringWithFormat:@"产地:%@",goods.chandi];
    lable3.text = str3;
    lable3.textColor = [UIColor grayColor];
    lable3.font= [UIFont systemFontOfSize:14];
    [self addSubview:lable3];
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(260, 485, 150, 60)];
    [btn setTitle:@"分享" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    
    btn.titleLabel.font = [UIFont systemFontOfSize:14];
    
    [self addSubview:btn];
    [btn addTarget:self action:@selector(shareAction:) forControlEvents:UIControlEventTouchUpInside];
    
   
}

- (void)shareAction:(id)sender
{
    /**
     字符变量名为UMShareToSina、UMShareToTencent、UMShareToWechatSession、UMShareToWechatTimeline、UMShareToQzone、UMShareToQQ、UMShareToRenren、UMShareToDouban、UMShareToEmail、UMShareToSms、UMShareToFacebook、UMShareToTwitter，分别代表新浪微博、腾讯微博、微信好友、微信朋友圈、QQ空间、手机QQ、人人网、豆瓣、电子邮箱、短信、Facebook、Twitter
     */
    

    NSString *appKey = @"56789aff67e58e05e9003de9";
    [UMSocialSnsService presentSnsIconSheetView:self.vc
                                         appKey:appKey
                                      shareText:shareField
                                     shareImage:image
                                shareToSnsNames:[NSArray arrayWithObjects:
                                                 UMShareToSina,
                                                 UMShareToTencent,
                                                 UMShareToWechatSession,
                                                 UMShareToWechatTimeline,
                                                 UMShareToQzone,
                                                 UMShareToQQ,
                                                 UMShareToRenren,
                                                 UMShareToDouban,
                                                 UMShareToEmail,
                                                 UMShareToSms,
                                                 UMShareToFacebook,
                                                 UMShareToTwitter,
                                                 UMShareToWechatSession,
                                                 UMShareToQQ,nil]
                                       delegate:self];
}


@end
