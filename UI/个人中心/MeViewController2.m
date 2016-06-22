//
//  MeViewController2.m
//  万表
//
//  Created by mac on 16/3/2.
//  Copyright © 2016年 zm. All rights reserved.
//

#import "MeViewController2.h"
#import "loginViewController.h"
#import "SNLocationManager.h"
#import "LocationViewController.h"
@interface MeViewController2 ()

@end

@implementation MeViewController2

- (void)viewDidLoad {
    [super viewDidLoad];
    
   
    
    [self NotFirstConection];
    // Do any additional setup after loading the view.
    self.imageView2.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.5];
    [self.loginBtn addTarget:self action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.loginBtn.tag = 1;
    [self.zhuCiBtn addTarget:self action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.zhuCiBtn.tag = 2;
     self.navigationController.navigationBarHidden = YES;
   
}
- (IBAction)lo:(id)sender {
    LocationViewController *vc = [[LocationViewController alloc]init];
    [self presentViewController:vc animated:YES completion:nil];
}
- (IBAction)Exit:(id)sender {
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    [user removeObjectForKey:@"userName"];
    self.userName.text = @"用户";
}
#pragma mark 给登陆 注册按钮 增加点击事件
- (void)BtnClick:(UIButton *)btn
{
    
    loginViewController *vc = [[loginViewController alloc]init];
    vc.hidesBottomBarWhenPushed=YES;
    
    self.navigationController.navigationBarHidden=YES;
    vc.i = (int)btn.tag;
    vc.delegate = self;
    [self.navigationController pushViewController:vc animated:YES];
    vc.hidesBottomBarWhenPushed=NO;
    vc.navigationController.navigationBarHidden = NO;
    
}
- (void)changeUserName:(NSString *)str
{
    self.userName.text = str;
}
- (void)NotFirstConection
{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *str = [user objectForKey:@"userName"];
    NSLog(@"%@",str);
    if (str !=nil) {
        self.userName.text = str;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
