//
//  ShopCar.h
//  万表
//
//  Created by mac on 16/3/1.
//  Copyright © 2016年 zm. All rights reserved.
//

//购物车，存在本地沙盒
#import <Foundation/Foundation.h>
#import "Goods.h"
@protocol reload

- (void)reload;
- (void)setItemBadgeValue;

@end

@interface ShopCar : NSObject <NSCoding>

@property NSMutableArray *array;
@property id<reload>delegate;


- (void)loadCar;
- (void)saveCar;       
- (void)addGoodsToCar:(Goods *)goods;
@end
