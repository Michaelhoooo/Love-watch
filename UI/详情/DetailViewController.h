//
//  DetailViewController.h
//  万表
//
//  Created by mac on 16/3/3.
//  Copyright © 2016年 zm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Goods.h"
@interface DetailViewController : UIViewController
@property Goods *goods;
@property NSTimer *timer;
@property int flag;
@end
