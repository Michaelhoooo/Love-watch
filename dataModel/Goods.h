//
//  Goods.h
//  万表
//
//  Created by mac on 16/3/1.
//  Copyright © 2016年 zm. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Goods : NSObject<NSCoding>

@property (nonatomic, copy) NSString *name;

@property (nonatomic, strong) NSArray *images;

@property (nonatomic, copy) NSString *price;

@property (nonatomic, copy) NSString *xinghao;

@property (nonatomic, copy) NSString *bianhao;

@property (nonatomic, copy) NSString *pinpai;

@property (nonatomic, copy) NSString *kuanshi;

@property (nonatomic, copy) NSString *chandi;

@property (nonatomic, copy) NSString *miaoshu;

@property NSArray *imageArray;

@property BOOL isChoosed;

@property NSNumber *num;

- (instancetype)initWithDic:(NSDictionary *)dic;
- (NSString *)getNumByPrice:(NSString *)price;

@end
