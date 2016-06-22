//
//  ShopCarCell.h
//  万表
//
//  Created by mac on 16/3/2.
//  Copyright © 2016年 zm. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Goods,ShopCar;
@protocol refersh

- (void)refreshPriceAll;

@end

@interface ShopCarCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *chooseBtn;
@property (weak, nonatomic) IBOutlet UIImageView *myImageView;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *price;
@property (weak, nonatomic) IBOutlet UILabel *number;
@property (weak, nonatomic) IBOutlet UIButton *reduce;
@property (weak, nonatomic) IBOutlet UIButton *add;

@property Goods *goods;
@property int num;

//用来保证和下方结算按钮的数据同步
@property id<refersh> delegate;



- (void)getGoods:(Goods *)goods;

@end
