//
//  ShopCarCell.m
//  万表
//
//  Created by mac on 16/3/2.
//  Copyright © 2016年 zm. All rights reserved.
//

#import "ShopCarCell.h"
#import "ShopCar.h"
#import "BtnSelf.h"
#import "DataGet.h"
#import "Goods.h"
#import "UIImageView+WebCache.h"
#define SCREEN_WIDTH    ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT   ([[UIScreen mainScreen] bounds].size.height)

@implementation ShopCarCell

- (void)getGoods:(Goods *)goods {
    _goods = goods;
    _name.text = goods.name;
    _price.text = [_goods getNumByPrice:_goods.price];
    _num = [_goods.num intValue];
    if (_num <= 0) {
        _num = 1;
    }
    _number.text = [NSString stringWithFormat:@"%i",_num];
    [_myImageView sd_setImageWithURL:_goods.imageArray[0]];
    if (_goods.isChoosed == NO) {
        [_chooseBtn setImage:[UIImage imageNamed:@"unchoose.jpg"] forState:UIControlStateNormal];
    }else{
        [_chooseBtn setImage:[UIImage imageNamed:@"choose.png"] forState:UIControlStateNormal];
    }
    
}

//判断是否选中，更新图片
- (IBAction)choose:(id)sender {
    if (_goods.isChoosed == NO) {
        _goods.isChoosed = YES;
        [_chooseBtn setImage:[UIImage imageNamed:@"choose.png"] forState:UIControlStateNormal];
        NSLog(@"choose");
    }else{
        _goods.isChoosed = NO;
        [_chooseBtn setImage:[UIImage imageNamed:@"unchoose.jpg"] forState:UIControlStateNormal];
        NSLog(@"unchoose");
    }
    [self.delegate refreshPriceAll];
}

//减号
- (IBAction)reduce:(id)sender {
    _num--;
    if (_num <= 0) {
        _num = 1;
    }
    _number.text = [NSString stringWithFormat:@"%i",_num];
    _goods.num = (NSNumber *)_number.text;
    [self.delegate refreshPriceAll];
}

//加号
- (IBAction)add:(id)sender {
    _num++;
    if (_num <= 0) {
        _num = 1;
    }
    _number.text = [NSString stringWithFormat:@"%i",_num];
    _goods.num = (NSNumber *)_number.text;
    [self.delegate refreshPriceAll];
    
}



- (void)awakeFromNib {
    // Initialization code
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
