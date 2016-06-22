//
//  ShopCar.m
//  万表
//
//  Created by mac on 16/3/1.
//  Copyright © 2016年 zm. All rights reserved.
//

#import "ShopCar.h"
#import "AppDelegate.h"


@implementation ShopCar

- (instancetype)init {
    static ShopCar *tmp;
    if (tmp == nil) {
        tmp = [super init];
        [tmp loadCar];
    }
    return tmp;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:_array forKey:@"array"];
}

- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self) {
        self = [super init];
        _array = [[NSMutableArray alloc]initWithArray:[aDecoder decodePropertyListForKey:@"array"]];
    }
    return self;
}

- (void)loadCar {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docDir = [paths objectAtIndex:0];
    NSString *filePath = [docDir stringByAppendingPathComponent:@"testFile.txt"];
    NSData *data = [[NSData alloc] initWithContentsOfFile:filePath];
    NSKeyedUnarchiver *unArchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
    NSArray *ary = [unArchiver decodeObjectForKey:@"KEY"];
    _array = [NSMutableArray arrayWithArray:ary];
    if (_array == nil || _array.count == 0) {
        _array = [NSMutableArray array];
    }
}

- (void)saveCar {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docDir = [paths objectAtIndex:0];
    if (!docDir) {
        NSLog(@"Documents 目录未找到");
    }
    NSString *filePath = [docDir stringByAppendingPathComponent:@"testFile.txt"];
    NSMutableData *data = [[NSMutableData alloc] init] ;
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    [archiver encodeObject:_array forKey:@"KEY"];
    [archiver finishEncoding];
    BOOL success = [data writeToFile:filePath atomically:YES];
    NSLog(@"%i",success);
}

- (void)addGoodsToCar:(Goods *)goods {
    AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    UITabBarController *tbc = (UITabBarController *)app.window.rootViewController;
    NSString *str =[tbc.viewControllers objectAtIndex:2].tabBarItem.badgeValue;
    if (_array == nil || _array.count == 0) {
        _array = [NSMutableArray array];
        [_array addObject:goods];
        [tbc.viewControllers objectAtIndex:2].tabBarItem.badgeValue = [NSString stringWithFormat:@"%d",[(NSNumber *)str intValue]+1];
        [self saveCar];
    }else{
        for (Goods *tmp in _array) {
            if ([tmp.bianhao isEqualToString:goods.bianhao]) {
                tmp.num = [NSNumber numberWithInt:[tmp.num intValue]+1];
                NSLog(@"%@",tmp.num);
                [self saveCar];
                return;
            }
        }
        [_array addObject:goods];
        [self saveCar];
        [tbc.viewControllers objectAtIndex:2].tabBarItem.badgeValue = [NSString stringWithFormat:@"%d",[(NSNumber *)str intValue]+1];
    }
    
}

@end
