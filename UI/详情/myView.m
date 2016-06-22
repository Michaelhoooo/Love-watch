//
//  myView.m
//  万表
//
//  Created by mac on 16/3/1.
//  Copyright © 2016年 zm. All rights reserved.
//

#import "myView.h"
#import "AppDelegate.h"
#define SPACING (SCREEN_WIDTH-200)/5
#define BTNW 50
#define BTNH 50
#define SCREEN_WIDTH    ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT   ([[UIScreen mainScreen] bounds].size.height)
#define SPACING (SCREEN_WIDTH-200)/5
@implementation myView



- (instancetype)init
{
    if (self) {
        self = [super init];
        [self addView];
    }
    return self;
}
- (void)addView{
    
    
   
    NSArray *imageNames =  @[@"735_480_201602291456710174309.jpg",@"735_480_201602291456714717646.jpg",@"735_480_201602291456715165441.jpg",@"735_480_201603011456796957806.jpg",@"735_480_201603011456819156152.jpg",@"735_480_201603021456888376655.jpg",@"735_480_201603021456888378560.jpg"
                             ];
    NSArray *titles = @[@"宝齐莱柏拉维系列",@"贵金属的优雅",@"传奇设计",@"祖尔斯自动系列",@"劳力士",@"欧米茄蝶飞8500",@"真力时腕表"];
    
    _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 250) shouldInfiniteLoop:YES imageNamesGroup:imageNames];
    
    _cycleScrollView.pageControlStyle = SDCycleScrollViewPageContolStyleAnimated;
    _cycleScrollView.titlesGroup =titles;
    _cycleScrollView.placeholderImage
    [self addSubview:_cycleScrollView];
    
    for (int i=0; i<8; i++) {
        if (i<4) {
            UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(i*(SPACING+BTNW)+SPACING, 200+70, BTNW, BTNH)];
            
            NSString *str = [NSString stringWithFormat:@"0%d.png",i+1];
            UIImage *image = [UIImage imageNamed:str];
            [btn setImage:image forState:UIControlStateNormal];
            [self addSubview:btn];
            if (i == 0) {
                [btn addTarget:self action:@selector(goToClass) forControlEvents:UIControlEventTouchUpInside];
            }
        }
        else {
        
            UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake((i-4)*(SPACING+BTNW)+SPACING, 200+BTNW+20+70, BTNH, BTNW)];
            
            NSString *str = [NSString stringWithFormat:@"0%d.png",i+1];
            UIImage *image = [UIImage imageNamed:str];
            [btn setImage:image forState:UIControlStateNormal];
            [self addSubview:btn];
        }
        
    }
    
}

- (void)goToClass {
    AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    UITabBarController *tbc = (UITabBarController *)app.window.rootViewController;
    [tbc setSelectedIndex:1];
}
@end
