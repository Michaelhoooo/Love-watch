//
//  DataGet.h
//  万表
//
//  Created by mac on 16/3/1.
//  Copyright © 2016年 zm. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"
#import "AFHTTPRequestOperationManager.h"
#import "MJExtension.h"
#import "Goods.h"

@interface DataGet : NSObject


@property NSArray *getAll;
@property NSArray *laolishi;
@property NSArray *jiangshidandun;
@property NSArray *ck;
@property NSArray *kaxiou;
@property NSArray *baidafeili;
@property NSArray *oumiga;


- (UIImage *)getImageByImageName:(NSString *)name;
- (instancetype)init;
- (void)connectToServer:(DataGet*)tmp;
- (void)didArray:(DataGet *)tmp;

@end
