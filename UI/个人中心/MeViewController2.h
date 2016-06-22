//
//  MeViewController2.h
//  万表
//
//  Created by mac on 16/3/2.
//  Copyright © 2016年 zm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MeViewController2 : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *imageView2;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (weak, nonatomic) IBOutlet UIButton *zhuCiBtn;
@property (weak, nonatomic) IBOutlet UILabel *userName;
- (void)changeUserName:(NSString *)str;

@end
