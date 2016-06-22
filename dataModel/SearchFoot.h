//
//  SearchFoot.h
//  万表
//
//  Created by mac on 16/3/3.
//  Copyright © 2016年 zm. All rights reserved.
//

//搜索记录，存在本地沙盒
#import <Foundation/Foundation.h>

@interface SearchFoot : NSObject<NSCoding>

@property NSMutableArray *array;

- (void)footsave;
- (void)footload;
- (void)footadd:(NSString *)str;

@end
