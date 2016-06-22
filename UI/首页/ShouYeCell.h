//
//  ShouYeCell.h
//  万表
//
//  Created by mac on 16/3/2.
//  Copyright © 2016年 zm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Goods.h"
@interface ShouYeCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *imageBtn1;
@property (weak, nonatomic) IBOutlet UIButton *imageBtn2;
@property (weak, nonatomic) IBOutlet UILabel *nameLable;

@property (weak, nonatomic) IBOutlet UILabel *priceLable;
@property (weak, nonatomic) IBOutlet UILabel *nameLable1;
@property (weak, nonatomic) IBOutlet UILabel *priceLable1;
- (void)refreshData:(Goods *)goods and:(Goods *)goods2;
@property Goods *goods1;
@property Goods *goods2;
@property UIViewController *vc;
@end
