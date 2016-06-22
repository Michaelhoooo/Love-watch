//
//  SearchDic.m
//  万表
//
//  Created by mac on 16/3/3.
//  Copyright © 2016年 zm. All rights reserved.
//

#import "SearchDic.h"

@implementation SearchDic

- (instancetype)init{
    static SearchDic *tmp;
    if (tmp == nil) {
        tmp = [super init];
        [tmp loaddata];
    }
    return tmp;
}

- (void)loaddata {
    NSArray *pinpai = @[@"品牌",@"CK",@"劳力士",@"江诗丹顿",@"百达翡丽",@"欧米茄",@"卡西欧"];
    NSArray *kuanshi = @[@"款式",@"男表",@"女表"];
    NSArray *chandi = @[@"产地",@"瑞士",@"美国",];
    NSArray *price = @[@"价格",@"1k以下",@"1k-3k",@"3k-1w",@"1w-3w",@"3w-5w",@"5w-10w",@"10w-100w",@"100w以上"];
    _array = @[pinpai,kuanshi,chandi,price];
}

@end
