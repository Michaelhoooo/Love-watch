//
//  DetailViewController.m
//  万表
//
//  Created by mac on 16/3/3.
//  Copyright © 2016年 zm. All rights reserved.
//

#import "DetailViewController.h"
#import "DetailView.h"
#import "NameAndPriceView.h"
#import "ShopCar.h"
#import <AlipaySDK/AlipaySDK.h>
#import "Product.h"
#import "Order.h"
#import "DataSigner.h"

@interface DetailViewController ()<UITableViewDataSource,UITableViewDelegate>
@property UILabel *lable;
@property int i,x;
@property UITableView *mytableView;
@property (weak, nonatomic) IBOutlet UIButton *joinInShopingCar;
@property (weak, nonatomic) IBOutlet UIButton *BuyNow;
@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addGunDongView];
    [self addTableView];
}
#pragma mark 增加滚动广告视图
- (void)addGunDongView
{
    DetailView *view = [[DetailView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 64)];
    view.vc = self;
   [self.view addSubview:view];
    view.flag = _flag;
    

}
#pragma mark 增加tableView

- (void)addTableView
{
    _mytableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 65, self.view.frame.size.width, self.view.frame.size.height)];
    
    NameAndPriceView *view = [[NameAndPriceView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 550) and:self.goods];
    view.vc = self;
    _mytableView.dataSource = self;
    _mytableView.delegate =self;
    _mytableView.tableHeaderView = view;
    [self.view addSubview:_mytableView];
    
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    _BuyNow.hidden = YES;
    _joinInShopingCar.hidden = YES;

}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    _BuyNow.hidden = NO;
    _joinInShopingCar.hidden = NO;
}
- (IBAction)joinInShopingCar:(id)sender {
    ShopCar *car = [[ShopCar alloc]init];
    [car addGoodsToCar:_goods];
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"通知" message:@"加入购物车成功" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        
    }];
    [alert addAction:action];
    [self presentViewController:alert animated:YES completion:nil];
    
}
- (NSString *)generateTradeNO
{
    static int kNumber = 15;
    
    NSString *sourceStr = @"0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    NSMutableString *resultStr = [[NSMutableString alloc] init];
    srand((unsigned)time(0));
    for (int i = 0; i < kNumber; i++)
    {
        unsigned index = rand() % [sourceStr length];
        NSString *oneStr = [sourceStr substringWithRange:NSMakeRange(index, 1)];
        [resultStr appendString:oneStr];
    }
    return resultStr;
}

- (IBAction)BuyNow:(id)sender {
    Product *product = [[Product alloc]init];
    product.price = 0.01;
    product.subject = @"1";
    product.body=@"测试";
    product.orderId =[self generateTradeNO];
    /*
     *商户的唯一的parnter和seller。
     *签约后，支付宝会为每个商户分配一个唯一的 parnter 和 seller。
     */
    
    /*============================================================================*/
    /*=======================需要填写商户app申请的===================================*/
    /*============================================================================*/
    NSString *partner = @"2088021328701004";
    NSString *seller = @"712291753@qq.com";
    NSString *privateKey = @"MIICeAIBADANBgkqhkiG9w0BAQEFAASCAmIwggJeAgEAAoGBAMtB3fAm4cStHD4FMwrvC6tTCIdnhcVJPgnrgYp0Tug65DBlW/xUq7CbCrjVEj36V2Bz1SjYpLCUl/FHO02VZTGCXVDwtKoEyf303/skO6S+A+KhqISmR6qH8gSZuynVtsykb1OkM0qI9GFkfyeCHdj2ESH+nY878W4DsZZtCNkTAgMBAAECgYEAlzjHHaBgAork40PNCQp2vR2Gz+72eKSYcpr0AwWrm14NXfBbcq2wGzIO1Rs5ekEh9xHW+o/MX8/+B7X+aieHY+x3URVafVxUNzoEqxuDDqpvGPL5EKYg9AdDZDa3zhCiTjx/QrEMhzgAlVWT6wXgAtgB92pZ6F6Jm/gRUmtuhZkCQQD6dqJUMoG8L0OieQP13krksSaUP/JB6l9SHZJlbAoQ3H4PiqZ3y/8pyzlFREweptyp9r4kBSxiKH69i+1bPuV/AkEAz8AYOndhRX5B+RWd1elpok/IKhtLYsPiUtn02OgCVAF++DNIfJBp2NUiWzah8NGbf0YMp6/AYfkOblo8CEPebQJBAO466Sws3jmguzRO5vV1+saLuaZJLKSFySTR++18VhazozQlLTHFV27pXhAEZmLBVCJWD4UzZoP3AJZKAfpIWQECQHCWfUrqOagMtbpE0cYE+j+Bl0vigOdkmzolbsFCc0iNiv794/HF3ecqErV2FStKnUfLcb5KzCsMa5q4gkJEbb0CQQCp0KQLIVgXxHnNthvFOVPipbFO6v422e1ps4IqJRu4DSQ2HrNJT3Bi2IsiNsZ05XrYdYZKtKkDIpmmEv1zj5nI";
    /*============================================================================*/
    /*============================================================================*/
    /*============================================================================*/
    
    //partner和seller获取失败,提示
    if ([partner length] == 0 ||
        [seller length] == 0 ||
        [privateKey length] == 0)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:@"缺少partner或者seller或者私钥。"
                                                       delegate:self
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil];
        [alert show];
        
        return;
    }
    
    /*
     *生成订单信息及签名
     */
    //将商品信息赋予AlixPayOrder的成员变量
    Order *order = [[Order alloc] init];
    order.partner = partner;
    order.seller = seller;
    order.tradeNO = [self generateTradeNO]; //订单ID（由商家自行制定）
    order.productName = product.subject; //商品标题
    order.productDescription = product.body; //商品描述
    order.amount = [NSString stringWithFormat:@"%.2f",product.price]; //商品价格
    order.notifyURL =  @"http://www.xxx.com"; //回调URL
    
    order.service = @"mobile.securitypay.pay";
    order.paymentType = @"1";
    order.inputCharset = @"utf-8";
    order.itBPay = @"30m";
    order.showUrl = @"m.alipay.com";
    
    //应用注册scheme,在AlixPayDemo-Info.plist定义URL types
    NSString *appScheme = @"payDemo";
    
    //将商品信息拼接成字符串
    NSString *orderSpec = [order description];
    NSLog(@"orderSpec = %@",orderSpec);
    
    //获取私钥并将商户信息签名,外部商户可以根据情况存放私钥和签名,只需要遵循RSA签名规范,并将签名字符串base64编码和UrlEncode
    id<DataSigner> signer = CreateRSADataSigner(privateKey);
    NSString *signedString = [signer signString:orderSpec];
    
    //将签名成功字符串格式化为订单字符串,请严格按照该格式
    NSString *orderString = nil;
    if (signedString != nil) {
        orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",
                       orderSpec, signedString, @"RSA"];
        
        [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
            NSLog(@"reslut = %@",resultDic);
        }];
    }
    

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *str1 = @"cell1";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str1];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str1];
    }
    return cell;

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
