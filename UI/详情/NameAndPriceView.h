//
//  NameAndPriceView.h
//  万表
//
//  Created by mac on 16/3/4.
//  Copyright © 2016年 zm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Goods.h"
#import "UMSocial.h"

@interface NameAndPriceView : UIView<UMSocialUIDelegate>

- (instancetype)initWithFrame:(CGRect)frame and:(Goods *)goods;
@property  NSString *shareField;
@property UIViewController *vc;
@property UIImage *image;
@property Goods *goods;

@end
