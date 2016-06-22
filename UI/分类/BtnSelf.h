//
//  BtnSelf.h
//  万表
//
//  Created by mac on 16/3/1.
//  Copyright © 2016年 zm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Goods.h"

@interface BtnSelf : UIButton

@property UINavigationController *nav;
@property UIImageView *myImageView;
@property UILabel *name;
@property UILabel *price;
@property Goods *goods;
@property int flag;

- (instancetype)initWithGoods:(Goods *)goods andNav:(UINavigationController *)nav andFrame:(CGRect)frame;

@end
