//
//  ShopCarViewController.m
//  万表
//
//  Created by mac on 16/3/1.
//  Copyright © 2016年 zm. All rights reserved.
//

#import "ShopCarViewController.h"
#import "ShopCar.h"
#import "BtnSelf.h"
#import "DataGet.h"
#import "Goods.h"
#import "ShopCarCell.h"
#import "DetailViewController.h"
#import <AlipaySDK/AlipaySDK.h>
#import "Product.h"
#import "Order.h"
#import "DataSigner.h"
#define SCREEN_WIDTH    ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT   ([[UIScreen mainScreen] bounds].size.height)

@interface ShopCarViewController ()
@property ShopCar *shopCar;
@property DataGet *dataGet;
@property BOOL isAllChoose;
@property NSMutableArray *array;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *payBtn;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *bianji;
@property (weak, nonatomic) IBOutlet UIView *payView;
@property (weak, nonatomic) IBOutlet UIButton *chooseAll;
@property (weak, nonatomic) IBOutlet UILabel *priceAll;
@property (weak, nonatomic) IBOutlet UIImageView *kongkong;

@end

@implementation ShopCarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _shopCar = [[ShopCar alloc]init];
    _dataGet = [[DataGet alloc]init];
    
    _tableView.frame = CGRectMake(0, 0, SCREEN_WIDTH, self.view.frame.size.height) ;
    _payView.hidden = YES;
    _isAllChoose = NO;
    _array = [NSMutableArray array];
    [_chooseAll setImage:[UIImage imageNamed:@"unchoose.jpg"] forState:UIControlStateNormal];
    [_kongkong setImage:[UIImage imageNamed:@"kongkong.jpg"]];
    if (_shopCar.array == nil || _shopCar.array.count == 0) {
        _kongkong.hidden = NO;
    }else{
        _kongkong.hidden = YES;
    }
    [self setItemBadgeValue];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//cell数目
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _shopCar.array.count;
}

//cell高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 120;
}

//生成cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
#if 0
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        BtnSelf *btn = [[BtnSelf alloc]initWithGoods:_shopCar.array[indexPath.row] andNav:self.navigationController andFrame:CGRectMake(0, 0, SCREEN_WIDTH, 120)];
        [cell.contentView addSubview:btn];
    }
#endif
    ShopCarCell *cell = [[NSBundle mainBundle]loadNibNamed:@"ShopCarCell" owner:nil options:nil].lastObject;
    [cell getGoods:_shopCar.array[indexPath.row]];
    [_array insertObject:cell.chooseBtn atIndex:_array.count];
    cell.delegate = self;
    return cell;
}

//允许编辑的范围
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

//编辑模式 删除模式
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleDelete;
}

//删除事件
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    [_shopCar.array removeObjectAtIndex:indexPath.row];
    [_tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationRight];
    if (_shopCar.array == nil || _shopCar.array.count == 0) {
        _kongkong.hidden = NO;
    }else{
        _kongkong.hidden = YES;
    }
    [self refreshPriceAll];
    [_shopCar saveCar];
}

//点击事件，进入详情界面
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"准备进入详情界面");
    DetailViewController *vc = [[DetailViewController alloc]init];
   vc.goods = [_shopCar.array objectAtIndex:indexPath.row];
    self.navigationController.navigationBarHidden = YES;
    vc.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:vc animated:YES];
    vc.flag = 2;
    vc.hidesBottomBarWhenPushed=NO;
}

//滚动结束时显示支付按钮
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    _payView.hidden = NO;
    [self refreshPriceAll];
    if (_shopCar.array == nil || _shopCar.array.count == 0) {
        _kongkong.hidden = NO;
        _payView.hidden = YES;
        return;
    }else{
        _kongkong.hidden = YES;
    }
}

#if 0
//滑动结束时显示支付按钮（滚动和滑动判定为不一样，操蛋）
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    _payView.hidden = NO;
    [self refreshPriceAll];
    if (_shopCar.array == nil || _shopCar.array.count == 0) {
        _kongkong.hidden = NO;
        _payView.hidden = YES;
        return;
    }else{
        _kongkong.hidden = YES;
    }
}
#endif

//滚动时隐藏支付按钮
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    _payView.hidden = YES;
}

//全选按钮
- (IBAction)chooseAll:(id)sender {
    if (_shopCar.array.count == 0||_shopCar.array == nil) {
        return;
    }
    if (_isAllChoose == YES) {
        for (Goods *tmp in _shopCar.array) {
            tmp.isChoosed = NO;
        }
        _isAllChoose = NO;
        [_chooseAll setImage:[UIImage imageNamed:@"unchoose.jpg"] forState:UIControlStateNormal];
        for (UIButton *tmp in _array) {
            [tmp setImage:[UIImage imageNamed:@"unchoose.jpg"] forState:UIControlStateNormal];
        }
    }else{
        for (Goods *tmp in _shopCar.array) {
            tmp.isChoosed = YES;
        }
        _isAllChoose = YES;
        [_chooseAll setImage:[UIImage imageNamed:@"choose.png"] forState:UIControlStateNormal];
        for (UIButton *tmp in _array) {
            [tmp setImage:[UIImage imageNamed:@"choose.png"] forState:UIControlStateNormal];
        }
    }
    
    [self refreshPriceAll];
    [_tableView reloadData];
}

//协议方法，使得cell和—_payview联系起来，点击cell里面的按钮会更新_payview里面的界面
- (void)reload {
    [_tableView reloadData];
    [self setItemBadgeValue];
}

- (void)refreshPriceAll {
    int i = 0;
    _payView.hidden = NO;
    _priceAll.text = [NSString stringWithFormat:@"%i",i];
    _isAllChoose = YES;
    for (Goods *tmp in _shopCar.array) {
        _isAllChoose *= tmp.isChoosed;
        if (tmp.isChoosed == YES) {
            int price = [(NSNumber *)tmp.price intValue];
            int num = [(NSNumber *)tmp.num intValue];
            i += price * num;
            _priceAll.text = [tmp getNumByPrice:[NSString stringWithFormat:@"%i",i]];
        }
    }
    if (_isAllChoose == YES) {
        [_chooseAll setImage:[UIImage imageNamed:@"choose.png"] forState:UIControlStateNormal];
    }else{
        [_chooseAll setImage:[UIImage imageNamed:@"unchoose.jpg"] forState:UIControlStateNormal];
    }
    if (_shopCar.array == nil || _shopCar.array.count == 0) {
        _kongkong.hidden = NO;
        _payView.hidden = YES;
    }else{
        _kongkong.hidden = YES;
    }
    [self setItemBadgeValue];
}

- (void)setItemBadgeValue {
    UITabBarItem * item=[self.tabBarController.tabBar.items objectAtIndex:2];
    item.badgeValue=[NSString stringWithFormat:@"%lu",(unsigned long)_shopCar.array.count];
    if (_shopCar.array.count == 0||_shopCar.array==nil) {
        item.badgeValue = nil;
    }
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

//进入支付界面
- (IBAction)goToPay:(id)sender {
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

- (IBAction)bianji:(id)sender {
    if (_tableView.editing) {
        [_tableView setEditing:NO animated:YES];
        _bianji.title = @"编辑";
    } else {
        [_tableView setEditing:YES animated:YES];
        _bianji.title = @"完成";
    }
    if (_shopCar.array == nil || _shopCar.array.count == 0) {
        _kongkong.hidden = NO;
        _payView.hidden = YES;
    }else{
        _kongkong.hidden = YES;
    }
    [self setItemBadgeValue];
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
