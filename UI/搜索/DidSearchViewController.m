//
//  DidSearchViewController.m
//  万表
//
//  Created by mac on 16/3/3.
//  Copyright © 2016年 zm. All rights reserved.
//

#import "DidSearchViewController.h"
#import "BtnSelf.h"
#import "SuperSearchView.h"
#define SCREEN_WIDTH    ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT   ([[UIScreen mainScreen] bounds].size.height)



@interface DidSearchViewController ()

@property  UITableView *searchTableView;
@property  SuperSearchView *SuperView;
@property  UIButton *hot;
@property  UIButton *price;
@property  UILabel *labelLeft;
@property  UIButton *upchoose;
@property  UIButton *downchoose;


@end

@implementation DidSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"进入搜索详情界面");
    _searchTableView = [[UITableView alloc]init];
    _SuperView = [[SuperSearchView alloc]init];
    _hot = [[UIButton alloc]init];
    _price = [[UIButton alloc]init];
    _labelLeft = [[UILabel alloc]init];
    _upchoose = [[UIButton alloc]init];
    _downchoose = [[UIButton alloc]init];
    // Do any additional setup after loading the view from its nib.
    //自定义返回按钮（返回分类界面，不是返回上一层界面）
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"<- 商品列表" style:UIBarButtonItemStylePlain target:self action:@selector(back:)];
    //右侧的按钮，进入搜索一级界面和筛选界面
    UIBarButtonItem *item1 = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(gotoSearch)];
    UIBarButtonItem *item2 = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemBookmarks target:self action:@selector(gotoChoose)];
    self.navigationItem.rightBarButtonItems = @[item2,item1];
    
    //ba搜索内容加入到搜索足迹当中（沙盒保存）
    _searchFoot  = [[SearchFoot alloc]init];
    [_searchFoot footadd:_searchKey];
    _dataGet = [[DataGet alloc]init];
    _searchResult = [NSMutableArray array];
    [self searchByString:_searchKey];
    
    //人气按钮（默认排序）
    _hot.frame = CGRectMake(0, 64, SCREEN_WIDTH/2, 60);
    [_hot setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [_hot setTitle:@"人气" forState:UIControlStateNormal];
    _hot.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_hot];
    [_hot addTarget:self action:@selector(chooseHot:) forControlEvents:UIControlEventTouchUpInside];
    
    //价格按钮，弹出按照价格排序选项
    _price.frame = CGRectMake(SCREEN_WIDTH/2, 64, SCREEN_WIDTH/2, 60);
    [_price setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_price setTitle:@"价格" forState:UIControlStateNormal];
    _price.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_price];
    [_price addTarget:self action:@selector(choosePrice:) forControlEvents:UIControlEventTouchUpInside];
    
    //红色滑biao
    _labelLeft.frame = CGRectMake(0, 114, SCREEN_WIDTH/2, 5);
    _labelLeft.backgroundColor = [UIColor redColor];
    [self.view addSubview:_labelLeft];
    
    //查找结果，tableview
    _searchTableView.frame = CGRectMake(0, 129, SCREEN_WIDTH, self.view.frame.size.height-109);
    _searchTableView.delegate = self;
    _searchTableView.dataSource = self;
    [self.view addSubview:_searchTableView];
    
    //升序排列按钮
    _upchoose.frame = CGRectMake(-1000, 129, SCREEN_WIDTH/2, 60);
    [_upchoose setTitle:@"从低到高" forState:UIControlStateNormal];
    [_upchoose setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _upchoose.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_upchoose];
    [_upchoose addTarget:self action:@selector(upReload:) forControlEvents:UIControlEventTouchUpInside];
    
    //降序排列按钮
    _downchoose.frame = CGRectMake(1000, 129, SCREEN_WIDTH/2, 60);
    [_downchoose setTitle:@"从高到低" forState:UIControlStateNormal];
    _downchoose.backgroundColor = [UIColor whiteColor];
    [_downchoose setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.view addSubview:_downchoose];
    [_downchoose addTarget:self action:@selector(downReload:) forControlEvents:UIControlEventTouchUpInside];
    
    //筛选界面，初期不显示
    _SuperView = [[SuperSearchView alloc]initWithFrame:CGRectMake(1000, 0, 1000, 1000)];
    [self.view addSubview:_SuperView];
    _SuperView.delegate = self;
    [_SuperView load];
}

#pragma tableview
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _searchResult.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc]init];
    BtnSelf *btn = [[BtnSelf alloc]initWithGoods:_searchResult[indexPath.row] andNav:self.navigationController andFrame:CGRectMake(0, 0, self.view.frame.size.width, 120)];
    [cell.contentView addSubview:btn];
    btn.flag = _flag;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 120;
}

#pragma item click 导航栏按钮的功能
//返回分类界面
- (void)back:(id)sender {
    
    
    if (_flag == 1) {
        self.navigationController.navigationBarHidden = YES;
    }else{
        self.navigationController.navigationBarHidden = NO;
    }
    [self.navigationController popToRootViewControllerAnimated:YES];
}
//返回搜索界面
- (void)gotoSearch {
    self.navigationController.navigationBarHidden = YES;
    [self.navigationController popViewControllerAnimated:YES];
}
//打开筛选界面
- (void)chooseSearch {
    [UIView animateWithDuration:1 animations:^(){
        [_SuperView changeSmall];
    }];
}

#pragma 排序相关
//左侧人气按钮
- (void)chooseHot:(id)sender {
    [UIView animateWithDuration:0.5 animations:^(){
        [_hot setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [_price setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _labelLeft.frame = CGRectMake(0, 114, SCREEN_WIDTH/2, 5);
        _upchoose.frame = CGRectMake(-1000, 129, SCREEN_WIDTH/2, 60);
        _downchoose.frame = CGRectMake(1000, 129, SCREEN_WIDTH/2, 60);
    }];
    NSArray *array = [_searchResult sortedArrayUsingComparator:^NSComparisonResult(Goods *goods1,Goods *goods2){
        NSComparisonResult result = [goods1.name compare:goods2.name];
        return result;
    }];
    _searchResult = nil;
    _searchResult = [NSMutableArray arrayWithArray:array];
    [_searchTableView reloadData];
}

//价格排序按钮
- (void)choosePrice:(id)sender {
    [UIView animateWithDuration:0.5 animations:^(){
        [_hot setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_price setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        _labelLeft.frame = CGRectMake(SCREEN_WIDTH/2, 114, SCREEN_WIDTH/2, 5);
        _upchoose.frame = CGRectMake(0, 129, SCREEN_WIDTH/2, 60);
        _downchoose.frame = CGRectMake(SCREEN_WIDTH/2, 129, SCREEN_WIDTH/2, 60);
    }];
}

//升序
- (void)upReload:(id)sender {
    NSArray *array = [_searchResult sortedArrayUsingComparator:^NSComparisonResult(Goods *goods1,Goods *goods2){
        float price1 = [goods1.price floatValue];
        float price2 =  [goods2.price floatValue];
        NSComparisonResult result;
        if (price1 < price2) {
            result = NSOrderedAscending;
        }else if (price1 > price2){
            result = NSOrderedDescending;
        }else{
            result = [goods1.name compare:goods2.name];
        }
        return result;
    }];
    _searchResult = nil;
    _searchResult = [NSMutableArray arrayWithArray:array];
    [_searchTableView reloadData];
    _upchoose.frame = CGRectMake(-1000, 113, SCREEN_WIDTH/2, 44);
    _downchoose.frame = CGRectMake(1000, 113, SCREEN_WIDTH/2, 44);
}
//降序
- (void)downReload:(id)sender {
    NSArray *array = [_searchResult sortedArrayUsingComparator:^NSComparisonResult(Goods *goods1,Goods *goods2){
        float price1 = [goods1.price floatValue];
        float price2 =  [goods2.price floatValue];
        NSComparisonResult result;
        if (price1 < price2) {
            result = NSOrderedDescending;
        }else if (price1 > price2){
            result = NSOrderedAscending;
        }else{
            result = [goods1.name compare:goods2.name];
        }
        return result;
    }];
    _searchResult = nil;
    _searchResult = [NSMutableArray arrayWithArray:array];
    [_searchTableView reloadData];
    _upchoose.frame = CGRectMake(-1000, 113, SCREEN_WIDTH/2, 44);
    _downchoose.frame = CGRectMake(1000, 113, SCREEN_WIDTH/2, 44);
}

#pragma sure协议方法 完成筛选界面和当前界面的数据同步
//点击搜索
- (void)gotoChoose {
    [UIView animateWithDuration:1 animations:^(){
        _SuperView.frame = self.view.frame ;
        [_SuperView changeBig];
        [self.view addSubview:_SuperView];
    } completion:nil];
}
//按照价格区间搜索（蛋疼，数据库太烂，搜索这么麻烦）
- (void)searchByPrice:(int)index; {
    _searchResult = nil;
    _searchResult = [NSMutableArray array];
    switch (index) {
        case 0:{
            for (Goods *goods in _dataGet.laolishi) {
                float price = [goods.price floatValue];
                if (price<=1000) {
                    [_searchResult addObject:goods];
                }
            }
            for (Goods *goods in _dataGet.ck) {
                float price = [goods.price floatValue];
                if (price<=1000) {
                    [_searchResult addObject:goods];
                }
            }
            for (Goods *goods in _dataGet.kaxiou) {
                float price = [goods.price floatValue];
                if (price<=1000) {
                    [_searchResult addObject:goods];
                }
            }
            for (Goods *goods in _dataGet.jiangshidandun) {
                float price = [goods.price floatValue];
                if (price<=1000) {
                    [_searchResult addObject:goods];
                }
            }
            for (Goods *goods in _dataGet.baidafeili) {
                float price = [goods.price floatValue];
                if (price<=1000) {
                    [_searchResult addObject:goods];
                }
            }
            for (Goods *goods in _dataGet.oumiga) {
                float price = [goods.price floatValue];
                if (price<=1000) {
                    [_searchResult addObject:goods];
                }
            }
            break;
        }
        case 1:{
            for (Goods *goods in _dataGet.laolishi) {
                float price = [goods.price floatValue];
                if (price>1000 && price<=3000) {
                    [_searchResult addObject:goods];
                }
            }
            for (Goods *goods in _dataGet.ck) {
                float price = [goods.price floatValue];
                if (price>1000 && price<=3000) {
                    [_searchResult addObject:goods];
                }
            }
            for (Goods *goods in _dataGet.kaxiou) {
                float price = [goods.price floatValue];
                if (price>1000 && price<=3000) {
                    [_searchResult addObject:goods];
                }
            }
            for (Goods *goods in _dataGet.jiangshidandun) {
                float price = [goods.price floatValue];
                if (price>1000 && price<=3000) {
                    [_searchResult addObject:goods];
                }
            }
            for (Goods *goods in _dataGet.baidafeili) {
                float price = [goods.price floatValue];
                if (price>1000 && price<=3000) {
                    [_searchResult addObject:goods];
                }
            }
            for (Goods *goods in _dataGet.oumiga) {
                float price = [goods.price floatValue];
                if (price>1000 && price<=3000) {
                    [_searchResult addObject:goods];
                }
            }
            break;
        }
        case 2:{
            for (Goods *goods in _dataGet.laolishi) {
                float price = [goods.price floatValue];
                if (price<=10000 && price>3000) {
                    [_searchResult addObject:goods];
                }
            }
            for (Goods *goods in _dataGet.ck) {
                float price = [goods.price floatValue];
                if (price<=10000 && price>3000) {
                    [_searchResult addObject:goods];
                }
            }
            for (Goods *goods in _dataGet.kaxiou) {
                float price = [goods.price floatValue];
                if (price<=10000 && price>3000) {
                    [_searchResult addObject:goods];
                }
            }
            for (Goods *goods in _dataGet.jiangshidandun) {
                float price = [goods.price floatValue];
                if (price<=10000 && price>3000) {
                    [_searchResult addObject:goods];
                }
            }
            for (Goods *goods in _dataGet.baidafeili) {
                float price = [goods.price floatValue];
                if (price<=10000 && price>3000) {
                    [_searchResult addObject:goods];
                }
            }
            for (Goods *goods in _dataGet.oumiga) {
                float price = [goods.price floatValue];
                if (price<=10000 && price>3000) {
                    [_searchResult addObject:goods];
                }
            }
            break;
        }
        case 3:{
            for (Goods *goods in _dataGet.laolishi) {
                float price = [goods.price floatValue];
                if (price>10000 && price<=30000) {
                    [_searchResult addObject:goods];
                }
            }
            for (Goods *goods in _dataGet.ck) {
                float price = [goods.price floatValue];
                if (price>10000 && price<=30000) {
                    [_searchResult addObject:goods];
                }
            }
            for (Goods *goods in _dataGet.kaxiou) {
                float price = [goods.price floatValue];
                if (price>10000 && price<=30000) {
                    [_searchResult addObject:goods];
                }
            }
            for (Goods *goods in _dataGet.jiangshidandun) {
                float price = [goods.price floatValue];
                if (price>10000 && price<=30000) {
                    [_searchResult addObject:goods];
                }
            }
            for (Goods *goods in _dataGet.baidafeili) {
                float price = [goods.price floatValue];
                if (price>10000 && price<=30000) {
                    [_searchResult addObject:goods];
                }
            }
            for (Goods *goods in _dataGet.oumiga) {
                float price = [goods.price floatValue];
                if (price>10000 && price<=30000) {
                    [_searchResult addObject:goods];
                }
            }
            break;
        }
        case 4:{
            for (Goods *goods in _dataGet.laolishi) {
                float price = [goods.price floatValue];
                if (price>30000 && price<=50000) {
                    [_searchResult addObject:goods];
                }
            }
            for (Goods *goods in _dataGet.ck) {
                float price = [goods.price floatValue];
                if (price>30000 && price<=50000) {
                    [_searchResult addObject:goods];
                }
            }
            for (Goods *goods in _dataGet.kaxiou) {
                float price = [goods.price floatValue];
                if (price>30000 && price<=50000) {
                    [_searchResult addObject:goods];
                }
            }
            for (Goods *goods in _dataGet.jiangshidandun) {
                float price = [goods.price floatValue];
                if (price>30000 && price<=50000) {
                    [_searchResult addObject:goods];
                }
            }
            for (Goods *goods in _dataGet.baidafeili) {
                float price = [goods.price floatValue];
                if (price>30000 && price<=50000) {
                    [_searchResult addObject:goods];
                }
            }
            for (Goods *goods in _dataGet.oumiga) {
                float price = [goods.price floatValue];
                if (price>30000 && price<=50000) {
                    [_searchResult addObject:goods];
                }
            }
            break;
        }
        case 5:{
            for (Goods *goods in _dataGet.laolishi) {
                float price = [goods.price floatValue];
                if (price>50000 && price<=100000) {
                    [_searchResult addObject:goods];
                }
            }
            for (Goods *goods in _dataGet.ck) {
                float price = [goods.price floatValue];
                if (price>50000 && price<=100000) {
                    [_searchResult addObject:goods];
                }
            }
            for (Goods *goods in _dataGet.kaxiou) {
                float price = [goods.price floatValue];
                if (price>50000 && price<=100000) {
                    [_searchResult addObject:goods];
                }
            }
            for (Goods *goods in _dataGet.jiangshidandun) {
                float price = [goods.price floatValue];
                if (price>50000 && price<=100000) {
                    [_searchResult addObject:goods];
                }
            }
            for (Goods *goods in _dataGet.baidafeili) {
                float price = [goods.price floatValue];
                if (price>50000 && price<=100000) {
                    [_searchResult addObject:goods];
                }
            }
            for (Goods *goods in _dataGet.oumiga) {
                float price = [goods.price floatValue];
                if (price>50000 && price<=100000) {
                    [_searchResult addObject:goods];
                }
            }
            break;
        }
        case 6:{
            for (Goods *goods in _dataGet.laolishi) {
                float price = [goods.price floatValue];
                if (price>100000 && price<=1000000) {
                    [_searchResult addObject:goods];
                }
            }
            for (Goods *goods in _dataGet.ck) {
                float price = [goods.price floatValue];
                if (price>100000 && price<=1000000) {
                    [_searchResult addObject:goods];
                }
            }
            for (Goods *goods in _dataGet.kaxiou) {
                float price = [goods.price floatValue];
                if (price>100000 && price<=1000000) {
                    [_searchResult addObject:goods];
                }
            }
            for (Goods *goods in _dataGet.jiangshidandun) {
                float price = [goods.price floatValue];
                if (price>100000 && price<=1000000) {
                    [_searchResult addObject:goods];
                }
            }
            for (Goods *goods in _dataGet.baidafeili) {
                int price = [goods.price intValue];
                if (price>100000 && price<=1000000) {
                    [_searchResult addObject:goods];
                }
            }
            for (Goods *goods in _dataGet.oumiga) {
                float price = [goods.price floatValue];
                if (price>100000 && price<=1000000) {
                    [_searchResult addObject:goods];
                }
            }
            break;
        }
        case 7:{
            for (Goods *goods in _dataGet.laolishi) {
                float price = [goods.price floatValue];
                if (price>1000000) {
                    [_searchResult addObject:goods];
                }
            }
            for (Goods *goods in _dataGet.ck) {
                float price = [goods.price floatValue];
                if (price>1000000) {
                    [_searchResult addObject:goods];
                }
            }
            for (Goods *goods in _dataGet.kaxiou) {
                float price = [goods.price floatValue];
                if (price>1000000) {
                    [_searchResult addObject:goods];
                }
            }
            for (Goods *goods in _dataGet.jiangshidandun) {
                float price = [goods.price floatValue];
                if (price>1000000) {
                    [_searchResult addObject:goods];
                }
            }
            for (Goods *goods in _dataGet.baidafeili) {
                float price = [goods.price floatValue];
                if (price>1000000) {
                    [_searchResult addObject:goods];
                }
            }
            for (Goods *goods in _dataGet.oumiga) {
                float price = [goods.price floatValue];
                if (price>1000000) {
                    [_searchResult addObject:goods];
                }
            }
            break;
        }

        default:
            break;
    }
    NSArray *array = [_searchResult sortedArrayUsingComparator:^NSComparisonResult(Goods *goods1,Goods *goods2){
        NSComparisonResult result = [goods1.name compare:goods2.name];
        return result;
    }];
    _searchResult = nil;
    _searchResult = [NSMutableArray arrayWithArray:array];
    [_searchTableView reloadData];
}

//按照关键字搜索（蛋疼x2）
- (void)searchByString:(NSString *)string {
    _searchResult = nil;
    _searchResult = [NSMutableArray array];
    for (Goods *goods in _dataGet.laolishi) {
        if ([goods.name containsString:string]) {
            [_searchResult addObject:goods];
            continue;
        }else if ([goods.pinpai containsString:string]) {
            [_searchResult addObject:goods];
            continue;
        }else if ([goods.xinghao containsString:string]) {
            [_searchResult addObject:goods];
            continue;
        }else if ([goods.kuanshi containsString:string]) {
            [_searchResult addObject:goods];
            continue;
        }else if ([goods.chandi containsString:string]) {
            [_searchResult addObject:goods];
            continue;
        }else if ([goods.bianhao containsString:string]) {
            [_searchResult addObject:goods];
            continue;
        }else{
        }
    }
    for (Goods *goods in _dataGet.jiangshidandun) {
        if ([goods.name containsString:string]) {
            [_searchResult addObject:goods];
            continue;
        }else if ([goods.pinpai containsString:string]) {
            [_searchResult addObject:goods];
            continue;
        }else if ([goods.xinghao containsString:string]) {
            [_searchResult addObject:goods];
            continue;
        }else if ([goods.kuanshi containsString:string]) {
            [_searchResult addObject:goods];
            continue;
        }else if ([goods.chandi containsString:string]) {
            [_searchResult addObject:goods];
            continue;
        }else if ([goods.bianhao containsString:string]) {
            [_searchResult addObject:goods];
            continue;
        }else{
        }
    }
    for (Goods *goods in _dataGet.ck) {
        if ([goods.name containsString:string]) {
            [_searchResult addObject:goods];
            continue;
        }else if ([goods.pinpai containsString:string]) {
            [_searchResult addObject:goods];
            continue;
        }else if ([goods.xinghao containsString:string]) {
            [_searchResult addObject:goods];
            continue;
        }else if ([goods.kuanshi containsString:string]) {
            [_searchResult addObject:goods];
            continue;
        }else if ([goods.chandi containsString:string]) {
            [_searchResult addObject:goods];
            continue;
        }else if ([goods.bianhao containsString:string]) {
            [_searchResult addObject:goods];
            continue;
        }else{
        }
    }
    for (Goods *goods in _dataGet.baidafeili) {
        if ([goods.name containsString:string]) {
            [_searchResult addObject:goods];
            continue;
        }else if ([goods.pinpai containsString:string]) {
            [_searchResult addObject:goods];
            continue;
        }else if ([goods.xinghao containsString:string]) {
            [_searchResult addObject:goods];
            continue;
        }else if ([goods.kuanshi containsString:string]) {
            [_searchResult addObject:goods];
            continue;
        }else if ([goods.chandi containsString:string]) {
            [_searchResult addObject:goods];
            continue;
        }else if ([goods.bianhao containsString:string]) {
            [_searchResult addObject:goods];
            continue;
        }else{
        }
    }
    for (Goods *goods in _dataGet.oumiga) {
        if ([goods.name containsString:string]) {
            [_searchResult addObject:goods];
            continue;
        }else if ([goods.pinpai containsString:string]) {
            [_searchResult addObject:goods];
            continue;
        }else if ([goods.xinghao containsString:string]) {
            [_searchResult addObject:goods];
            continue;
        }else if ([goods.kuanshi containsString:string]) {
            [_searchResult addObject:goods];
            continue;
        }else if ([goods.chandi containsString:string]) {
            [_searchResult addObject:goods];
            continue;
        }else if ([goods.bianhao containsString:string]) {
            [_searchResult addObject:goods];
            continue;
        }else{
        }
    }
    for (Goods *goods in _dataGet.kaxiou) {
        if ([goods.name containsString:string]) {
            [_searchResult addObject:goods];
            continue;
        }else if ([goods.pinpai containsString:string]) {
            [_searchResult addObject:goods];
            continue;
        }else if ([goods.xinghao containsString:string]) {
            [_searchResult addObject:goods];
            continue;
        }else if ([goods.kuanshi containsString:string]) {
            [_searchResult addObject:goods];
            continue;
        }else if ([goods.chandi containsString:string]) {
            [_searchResult addObject:goods];
            continue;
        }else if ([goods.bianhao containsString:string]) {
            [_searchResult addObject:goods];
            continue;
        }else{
        }
    }
    NSArray *array = [_searchResult sortedArrayUsingComparator:^NSComparisonResult(Goods *goods1,Goods *goods2){
        NSComparisonResult result = [goods1.name compare:goods2.name];
        return result;
    }];
    _searchResult = nil;
    _searchResult = [NSMutableArray arrayWithArray:array];
    [_searchTableView reloadData];
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
