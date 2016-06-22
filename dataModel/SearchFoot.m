//
//  SearchFoot.m
//  万表
//
//  Created by mac on 16/3/3.
//  Copyright © 2016年 zm. All rights reserved.
//

#import "SearchFoot.h"

@implementation SearchFoot

- (instancetype)init {
    static SearchFoot *tmp;
    if (tmp == nil) {
        tmp = [super init];
        //tmp.array = [NSMutableArray array];
        [tmp footload];
    }
    return tmp;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:_array forKey:@"foot"];
}

- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self) {
        self = [super init];
        _array = [aDecoder decodeObjectForKey:@"foot"];
    }
    return self;
}

- (void)footsave {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docDir = [paths objectAtIndex:0];
    if (!docDir) {
        NSLog(@"Documents 目录未找到");
    }
    NSString *filePath = [docDir stringByAppendingPathComponent:@"foot.txt"];
    NSMutableData *data = [[NSMutableData alloc] init] ;
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    [archiver encodeObject:_array forKey:@"FOOT"];
    [archiver finishEncoding];
    BOOL success = [data writeToFile:filePath atomically:YES];
    NSLog(@"%i",success);
}

- (void)footload{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docDir = [paths objectAtIndex:0];
    NSString *filePath = [docDir stringByAppendingPathComponent:@"foot.txt"];
    NSData *data = [[NSData alloc] initWithContentsOfFile:filePath];
    NSKeyedUnarchiver *unArchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
    _array = [unArchiver decodeObjectForKey:@"FOOT"];
    if (_array == nil || _array.count == 0) {
        _array = [NSMutableArray array];
    }
}

- (void)footadd:(NSString *)str {
    if (_array == nil || _array.count == 0) {
        _array = [NSMutableArray array];
    }else{
        for (NSString *tmp in _array) {
            if ([tmp isEqualToString:str]) {
                return;
            }
        }
    }
    [_array addObject:str];
    [self footsave];
}

@end
