//
//  DataGet.m
//  万表
//
//  Created by mac on 16/3/1.
//  Copyright © 2016年 zm. All rights reserved.
//

#import "DataGet.h"
#define SERVER_URL @"http://115.28.55.133:8000/getall"

//NSArray *getAll;

@implementation DataGet

- (instancetype)init {
    static DataGet *tmp;
    if (tmp == nil) {
        tmp = [super init];
    }
    return tmp;
}

- (void)didArray:(DataGet *)tmp {
    NSArray *array1 = [tmp getModelByPlist:[tmp getUrlByName:@"laolishi.plist"]];
    NSArray *array2 = [tmp getModelByPlist:[tmp getUrlByName:@"JiangShiDanDun.plist"]];
    NSArray *array3 = [tmp getModelByPlist:[tmp getUrlByName:@"CK.plist"]];
    NSArray *array4 = [tmp getModelByPlist:[tmp getUrlByName:@"kaxiou.plist"]];
    NSArray *array5 = [tmp getModelByPlist:[tmp getUrlByName:@"BaiDaFeiLi.plist"]];
    NSArray *array6 = [tmp getModelByPlist:[tmp getUrlByName:@"oumige.plist"]];
    
    tmp.laolishi = [tmp freshArray:array1];
    tmp.jiangshidandun = [tmp freshArray:array2];
    tmp.baidafeili = [tmp freshArray:array5];
    
    tmp.ck = [tmp freshArray:array3];
    tmp.kaxiou = [tmp freshArray:array4];
    tmp.oumiga = [tmp freshArray:array6];
    NSLog(@"%lu,%lu,%lu,%lu,%lu,%lu",(unsigned long)tmp.laolishi.count,(unsigned long)tmp.
          jiangshidandun.count,(unsigned long)tmp.ck.count,(unsigned long)tmp.kaxiou.count,(unsigned long)tmp.baidafeili.count,(unsigned long)tmp.oumiga.count);
}

- (NSArray *)freshArray:(NSArray *)array {
    NSMutableArray *array1 = [[NSMutableArray alloc]init];
    
    for (NSDictionary *dic in array) {
        NSMutableArray *images = [NSMutableArray array];
        Goods *tmp = [[Goods alloc]initWithDic:dic];
        [array1 addObject:tmp];
        int i = 0;
        //NSURL *url0;
        for (NSString *str in tmp.images) {
             NSURL *url = [self getUrlByName:str];
            [images insertObject:url atIndex:i];
//            if (i == 0) {
//                url0 = url;
//            }
//            if (i == tmp.images.count) {
//                [images insertObject:url0 atIndex:0];
//            }
            i++;
        }
        tmp.imageArray = [NSArray arrayWithArray:images];
    }
    NSArray *tmp = [NSArray arrayWithArray:array1];
    return tmp;
}

/**连接服务器*/
- (void)connectToServer:(DataGet*)tmp{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *dic = [NSDictionary dictionaryWithObject:@"kk" forKey:@"username"];
    
    [manager POST:SERVER_URL parameters:dic success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSLog(@"连接成功");
        
        //保存数据到内存
        tmp.getAll = [responseObject objectForKey:@"result"];
        NSLog(@"getall:%lu",(unsigned long)self.getAll.count);
        [tmp didArray:tmp];
        
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        NSLog(@"连接失败");
    }];
}

//根据名称获取url（plist和图片都是用此方法）
- (NSURL *)getUrlByName:(NSString *)name{
    NSURL *reUrl;
    for (NSDictionary *tmp in self.getAll) {
        NSString *str = [tmp objectForKey:@"name"];
        if ([str isEqualToString:name]) {
            NSString *url = [tmp objectForKey:@"url"];
            reUrl = [NSURL URLWithString:url];
            break;
        }
    }
    return reUrl;
}

//根据url获取plist（数组）
- (NSArray *)getModelByPlist:(NSURL *)url {
    NSArray *array = [NSArray arrayWithContentsOfURL:url];
    return array;
}

//根据图片名字获取图片
- (UIImage *)getImageByImageName:(NSString *)name {
    NSURL *url = [self getUrlByName:name];
    NSData *data = [NSData dataWithContentsOfURL:url];
    UIImage *image = [UIImage imageWithData:data];
    return image;
}
@end
