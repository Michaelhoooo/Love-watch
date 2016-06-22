//
//  HomeViewController2.m
//  万表
//
//  Created by mac on 16/3/3.
//  Copyright © 2016年 zm. All rights reserved.
//

#import "HomeViewController2.h"
#import "DataGet.h"
#import "Goods.h"
#import "AFHTTPRequestOperationManager.h"
#import "myView.h"
#import "ShouYeCell.h"
#import "FirstCell.h"
#import "SearchViewController.h"
#import "MeViewController.h"
#import <LBXScanViewController.h>
#import "SubLBXScanViewController.h"
#import "MBProgressHUD.h"

#define SCREEN_WIDTH    ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT   ([[UIScreen mainScreen] bounds].size.height)
#define SERVER_URL @"http://115.28.55.133:8000/getall"

@interface HomeViewController2 ()<UITableViewDataSource,UITableViewDelegate>
@property DataGet *dataGet;
@property UITableView *mytable;
@property UISearchBar *seachBar;
@property UIView *myview;
@property NSMutableArray *dataArry;
@property NSMutableArray *dataArry2;
@property MBProgressHUD *hud;
@property UIView *loadingview;
@end

@implementation HomeViewController2
@synthesize loadingview;

- (void)viewDidLoad {
    
    [super viewDidLoad];
   
    
    _dataGet = [[DataGet alloc]init];
    
    [self connectToServer:_dataGet];
   
    
    [self addtableView];
    [self addsearchBar];
     [self addloading];
    
    
    
}


-(void)addloading
{
    UIView *view = [[UIView alloc]initWithFrame:self.view.frame];
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
   _hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
   _hud.label.text = NSLocalizedString(@"正在加载...", @"HUD loading title");
    _hud.label.backgroundColor = [UIColor clearColor];
    
    dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), ^{
        [self doSomeWork];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [_hud hideAnimated:YES];
            [view removeFromSuperview];
            
        });
    });
    [view addSubview:_hud];
}
- (void)doSomeWork {
    
    sleep(3.);
}
- (void)reloadDate
{
    
    Goods *goods = [_dataGet.kaxiou objectAtIndex:0];
    Goods *goods1 = [_dataGet.ck objectAtIndex:2];
    Goods *goods2 = [_dataGet.kaxiou objectAtIndex:7];
    Goods *goods3 = [_dataGet.ck objectAtIndex:9];
    Goods *goods4 = [_dataGet.ck objectAtIndex:1];
    Goods *goods5 = [_dataGet.ck objectAtIndex:7];
    Goods *goods6 = [_dataGet.ck objectAtIndex:6];
    Goods *goods7 = [_dataGet.kaxiou objectAtIndex:4];
    Goods *goods8 = [_dataGet.kaxiou objectAtIndex:1];
    Goods *goods9 = [_dataGet.kaxiou objectAtIndex:2];
    _dataArry2 = [NSMutableArray arrayWithArray:@[goods,goods1,goods2,goods3,goods4]];
    _dataArry = [NSMutableArray arrayWithArray:@[goods5,goods6,goods7,goods8,goods9]];
    
    
}
#pragma mark 增加tableView
- (void)addtableView{
    _mytable = [[UITableView alloc]initWithFrame:CGRectMake(0, -20, SCREEN_WIDTH, SCREEN_HEIGHT+20)];
    
    myView *view = [[myView alloc]init];
    view.frame = CGRectMake(0, 0, SCREEN_WIDTH, 400);
    _mytable.tableHeaderView = view;
    _mytable.dataSource =self;
    _mytable.delegate = self;
    [self.view addSubview:_mytable];
    
}
#pragma mark 增加searchBar(自定义的)
- (void)addsearchBar{
    _myview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)];
    //view.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.5];
    
    
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(13, 22, 30, 30)];
    btn.backgroundColor = [UIColor clearColor];
    [btn setImage:[UIImage imageNamed:@"nav_bar_pop_highlighted@2x.png"] forState:UIControlStateNormal];
    [_myview addSubview:btn];
    [btn addTarget:self action:@selector(saoyisao) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *btn1 = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-24-15, 22, 30, 30)];
    btn1.backgroundColor = [UIColor clearColor];
    [btn1 setImage:[UIImage imageNamed:@"profile_selected@2x.png"] forState:UIControlStateNormal];
    [_myview addSubview:btn1];
    [btn1 addTarget:self action:@selector(goToSelf) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIButton *btn2 = [[UIButton alloc]initWithFrame:CGRectMake(44, 22, SCREEN_WIDTH-88, 30)];
    btn2.backgroundColor = [UIColor clearColor];
    [btn2 setImage:[UIImage imageNamed:@"search001.png"] forState:UIControlStateNormal];
    [_myview addSubview:btn2];
    [btn2 addTarget:self action:@selector(goToSearch) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:_myview];
    
    
}

- (void)saoyisao{
    SubLBXScanViewController *vc = [SubLBXScanViewController new];
    vc.hidesBottomBarWhenPushed=YES;
    
    self.navigationController.navigationBarHidden=YES;
    
    [self.navigationController pushViewController:vc animated:YES];
    vc.navigationController.navigationBarHidden = NO;
}

- (void)goToSelf{
    AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    UITabBarController *tbc = (UITabBarController *)app.window.rootViewController;
    [tbc setSelectedIndex:3];
    
}

- (void)goToSearch {
    SearchViewController *svc = [[SearchViewController alloc]init];
    svc.flag = 1;
    [self.navigationController pushViewController:svc animated:YES];
}

#pragma mark tableview的协议方法和数据源方法的视线
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArry.count+1;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        static NSString *str1 = @"cell1";
        FirstCell *cell = [tableView dequeueReusableCellWithIdentifier:str1];
        if (cell==nil) {
            cell=[[NSBundle mainBundle]loadNibNamed:@"FirstCell" owner:nil options:nil].lastObject;
        }
        return cell;
    }
    else{
        static NSString *str = @"cell";
        ShouYeCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
        if (cell==nil) {
            cell=[[NSBundle mainBundle]loadNibNamed:@"ShouYeCell" owner:nil options:nil].lastObject;
        }
        [cell refreshData:_dataArry[indexPath.row-1] and:_dataArry2[indexPath.row-1]];
        cell.vc = self;
        return cell;
    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        return 58;
    }
    else{
        return 240;
    }
    
}
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CATransform3D rotation;
    rotation = CATransform3DMakeRotation( (90.0*M_PI)/360, 0.0, 0.7, 0.4);
    rotation.m34 = 1.0/ -600;
    
    cell.layer.shadowColor = [[UIColor blackColor]CGColor];
    cell.layer.shadowOffset = CGSizeMake(10, 10);
    cell.alpha = 0;
    cell.layer.transform = rotation;
    //cell.layer.anchorPoint = CGPointMake(0, 0.5);
    
    
    [UIView beginAnimations:@"rotation" context:NULL];
    [UIView setAnimationDuration:1];
    cell.layer.transform = CATransform3DIdentity;
    cell.alpha = 1;
    cell.layer.shadowOffset = CGSizeMake(0, 0);
    [UIView commitAnimations];
}

#pragma mark scrollView的协议方法，用来设置searchBar的透明度问题
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    _myview.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.8];
    
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    
    if (scrollView.contentOffset.y<=0) {
        _myview.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0];
    }
    
}

/**连接服务器*/
- (void)connectToServer:(DataGet*)tmp{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *dic = [NSDictionary dictionaryWithObject:@"kk" forKey:@"username"];
    
    [manager POST:SERVER_URL parameters:dic success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
       
        NSLog(@"连接成功");
       
        //保存数据到内存
        if (loadingview) {
                    [self addloading];
             [loadingview removeFromSuperview];
        }
        
        tmp.getAll = [responseObject objectForKey:@"result"];
        NSLog(@"getall:%lu",(unsigned long)tmp.getAll.count);
        [tmp didArray:tmp];
        [self reloadDate];
        [_mytable reloadData];

    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        
        loadingview = [[UIView alloc]initWithFrame:self.view.frame];
        loadingview.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:loadingview];
        UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2-120, self.view.frame.size.height/2-70, 240, 40)];
        lable.text = @"网络连接失败，请检查网络";
        lable.textAlignment = NSTextAlignmentCenter;
        [loadingview addSubview:lable];
        
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2-50-5, self.view.frame.size.height/2-10, 100, 40)];
       
        [btn setTitle:@"重新加载" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal ];
        [btn setTitleColor:[UIColor grayColor] forState: UIControlStateHighlighted  ];
        [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
        [loadingview addSubview:btn];
        NSLog(@"连接失败");
        [self addloading];
    }];
}
-(void)btnClick
{
    
    
    [self connectToServer:_dataGet];
    
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
