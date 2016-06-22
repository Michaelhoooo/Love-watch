//
//  Goods.m
//  万表
//
//  Created by mac on 16/3/1.
//  Copyright © 2016年 zm. All rights reserved.
//

#import "Goods.h"

@implementation Goods

- (instancetype)initWithDic:(NSDictionary *)dic {
    if (self) {
        self = [super init];
        self.name = [dic objectForKey:@"name"];
        self.price = [dic objectForKey:@"price"];
        self.pinpai = [dic objectForKey:@"pinpai"];
        self.miaoshu = [dic objectForKey:@"miaoshu"];
        self.bianhao = [dic objectForKey:@"bianhao"];
        self.chandi = [dic objectForKey:@"chandi"];
        self.xinghao = [dic objectForKey:@"xinghao"];
        self.kuanshi = [dic objectForKey:@"kuanshi"];
        self.images = [dic objectForKey:@"images"];
        self.isChoosed = NO;
        self.num = [NSNumber numberWithInt:1];
    }
    return self;
}

- (NSString *)getNumByPrice:(NSString *)price {
    NSNumber *number = (NSNumber *)price;
    int num = [number intValue];
    int a = num%1000;
    int b = num/1000%1000;
    int c = num/1000000;
    NSString *str;
    if (c != 0) {
        str = [NSString stringWithFormat:@"￥%d,%03d,%03d",c,b,a];
    }else if (b != 0){
        str = [NSString stringWithFormat:@"￥%d,%03d",b,a];
    }else{
        str = [NSString stringWithFormat:@"￥%d",a];
    }
    return str;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:_name forKey:@"name"];
    [aCoder encodeObject:_pinpai forKey:@"pinpai"];
    [aCoder encodeObject:_price forKey:@"price"];
    [aCoder encodeObject:_chandi forKey:@"chandi"];
    [aCoder encodeObject:_bianhao forKey:@"bianhao"];
    [aCoder encodeObject:_xinghao forKey:@"xinghao"];
    [aCoder encodeObject:_miaoshu forKey:@"miaoshu"];
    [aCoder encodeObject:_num forKey:@"num"];
    [aCoder encodeObject:_images forKey:@"images"];
    [aCoder encodeObject:_imageArray forKey:@"imagearray"];
    [aCoder encodeObject:_kuanshi forKey:@"kuanshi"];
}

- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self) {
        self = [super init];
        _name = [aDecoder decodePropertyListForKey:@"name"];
        _price = [aDecoder decodePropertyListForKey:@"price"];
        _bianhao = [aDecoder decodePropertyListForKey:@"bianhao"];
        _xinghao = [aDecoder decodePropertyListForKey:@"xinghao"];
        _chandi = [aDecoder decodePropertyListForKey:@"chandi"];
        _num = [aDecoder decodePropertyListForKey:@"num"];
        _miaoshu = [aDecoder decodePropertyListForKey:@"miaoshu"];
        _pinpai = [aDecoder decodePropertyListForKey:@"pinpai"];
        _kuanshi = [aDecoder decodePropertyListForKey:@"kuanshi"];
        _images = [aDecoder decodePropertyListForKey:@"images"];
        _imageArray = [aDecoder decodePropertyListForKey:@"imagearray"];
    }
    return self;
}

@end
