//
//  ShopCarViewController.h
//  万表
//
//  Created by mac on 16/3/1.
//  Copyright © 2016年 zm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShopCarCell.h"
#import "ShopCar.h"

@interface ShopCarViewController : UIViewController <UITableViewDataSource,UITableViewDelegate,refersh,reload>

- (void)setItemBadgeValue;
- (void)reload;

@end
