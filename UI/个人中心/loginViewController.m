//
//  loginViewController.m
//  万表
//
//  Created by mac on 16/3/2.
//  Copyright © 2016年 zm. All rights reserved.
//

#import "loginViewController.h"
#import "CateAnimationLogin.h"
#import "AFHTTPRequestOperationManager.h"
#import "MeViewController2.h"
#define ZHIMENG_URL @"http://115.28.55.133:8000/jsonregister"
#define ZHIMENGLOAD_URL @"http://115.28.55.133:8000/jsonlogin"

@interface loginViewController ()
@property CateAnimationLogin *login;
@end

@implementation loginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    ;
    // Do any additional setup after loading the view.
    _login=[[CateAnimationLogin alloc]initWithFrame:CGRectMake(0, -30,self.view.bounds.size.width, 400)];
    _login.userNameTextField.clearButtonMode = UITextFieldViewModeAlways;
    _login.PassWordTextField.clearButtonMode = UITextFieldViewModeAlways;
    _login.userNameTextField.placeholder = @"请输入用户名";
    _login.PassWordTextField.placeholder = @"请输入密码";
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_login];
    //[self addView];
    [self addbtn];
     self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"个人中心" style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    
   
    
}
- (void)back
{
        [self.navigationController popToRootViewControllerAnimated:YES];
    self.navigationController.navigationBarHidden=YES;

}
#pragma mark 收回键盘
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
#pragma mark 增加确定按钮
- (void)addbtn
{
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(375/2-25, 350, 50, 50)];
    [btn setTitle:@"确定" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnClick1) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}
#pragma mark 增加点击时间 判断标志位 1进行登录操作 2进行注册操作
- (void)btnClick1
{
    if (self.i==1) {
        [self FirstGetData:ZHIMENGLOAD_URL andIndex:1];
    }
    else if (self.i==2)
    {
        [self FirstGetData:ZHIMENG_URL andIndex:2];

    }
}
#pragma mark 增加返回按钮
- (void)addView{

    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 375, 64)];
    view.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.5];
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(10, 20, 40, 40)];
    [btn setTitle:@"返回" forState:UIControlStateNormal];
    
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:btn];
    [self.view addSubview:view];
    
}
#pragma mark 返回上一界面
- (void)btnClick
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}
#pragma mark 连接服务器
-(void)FirstGetData:(NSString *)str andIndex:(int)i
{
    AFHTTPRequestOperationManager *manage = [AFHTTPRequestOperationManager manager];
//    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
//    NSString *accesstoken = [userDefault objectForKey:@"access_token"];
//    NSNumber *pageNum = [NSNumber numberWithInt:4];
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:_login.userNameTextField.text,@"username",_login.PassWordTextField.text,@"password",nil];
    [manage POST:str parameters:dic success:^(AFHTTPRequestOperation *operation, id response)
     {
         NSLog(@"网络请求成功");
         NSNumber *num = [response objectForKey:@"code"];
         NSString *str = [NSString stringWithFormat:@"%@",num];
         NSLog(@"%@",num);
         if (i==1) {
             
             if ([str isEqualToString:@"200"]) {
                 [self AlertViewController:@"登陆成功"];
             }else{
                 
                 [self AlertViewController:@"用户名不存在或密码不正确"];
             }

             
        }else if (i==2){
            
            if ([str isEqualToString:@"200"]) {
                [self AlertViewController:@"注册成功"];
            }else{
                
                [self AlertViewController:@"用户名被占用"];
            }

             
        }
             
    } failure:^(AFHTTPRequestOperation *operation,NSError *error)
     {
         NSLog(@"网络请求失败");
     }];
}
#pragma mark 提示框AlertController
- (void)AlertViewController:(NSString *)str
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"通知" message:str preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        //[self.delegate changeUserName:_login.userNameTextField.text];
        if ([str isEqualToString:@"注册成功"]) {
            [self.navigationController popToRootViewControllerAnimated:YES];
            self.navigationController.navigationBarHidden = YES;
            }
        if ([str isEqualToString:@"登陆成功"]) {
            [self.navigationController popToRootViewControllerAnimated:YES];
            [self.delegate changeUserName:_login.userNameTextField.text];
            NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
            [user setValue:_login.userNameTextField.text forKey:@"userName"];
            self.navigationController.navigationBarHidden = YES;
        }
    }];
    [alert addAction:action];
    [self presentViewController:alert animated:YES completion:nil];
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
