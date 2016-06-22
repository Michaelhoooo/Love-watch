//
//  ClassViewController.m
//  万表
//
//  Created by mac on 16/3/1.
//  Copyright © 2016年 zm. All rights reserved.
//

#import "ClassViewController.h"
#import "DataGet.h"
#import "Goods.h"
#import "BtnSelf.h"
#import "SearchViewController.h"
#define SCREEN_WIDTH    ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT   ([[UIScreen mainScreen] bounds].size.height)

@interface ClassViewController ()
@property (weak, nonatomic) IBOutlet UITableView *leftTab;
@property (weak, nonatomic) IBOutlet UIScrollView *rightScr;
@property NSMutableArray *array;
@property NSArray *name;
@property DataGet *dataGet;

@end

@implementation ClassViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = NO;
    _dataGet = [[DataGet alloc]init];
    if (_dataGet == nil || _dataGet.kaxiou == nil || _dataGet.kaxiou.count == 0 || _dataGet.oumiga == nil || _dataGet.oumiga.count == 0 || _dataGet.jiangshidandun == nil || _dataGet.jiangshidandun.count == 0 || _dataGet.baidafeili == nil || _dataGet.baidafeili.count == 0 || _dataGet.ck == nil || _dataGet.ck.count == 0 || _dataGet.laolishi == nil || _dataGet.laolishi.count == 0 ) {
        return;
    }
    _array = [NSMutableArray array];
    [_array addObject:_dataGet.baidafeili];
    [_array addObject:_dataGet.laolishi];
    [_array addObject:_dataGet.ck];
    [_array addObject:_dataGet.kaxiou];
    [_array addObject:_dataGet.oumiga];
    [_array addObject:_dataGet.jiangshidandun];
    _name = [NSArray arrayWithObjects:@"百达翡丽",@"劳力士",@"CK",@"卡西欧",@"欧米茄",@"江诗丹顿", nil];
//    _leftTab.frame = CGRectMake(0, 64, 77, self.view.frame.size.height) ;
    _rightScr.frame = CGRectMake(78, 0, SCREEN_WIDTH-77, self.view.frame.size.height);
    
    [self tableView:_leftTab didSelectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//进入查询界面
- (IBAction)goToSearch:(id)sender {
    SearchViewController *svc = [[SearchViewController alloc]init];
    svc.flag = 2;
    [self.navigationController pushViewController:svc animated:YES];
}

//cell数目
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _array.count;
}

//cell高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}

//生成cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = [_name objectAtIndex:indexPath.row];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.textLabel.font = [cell.textLabel.font fontWithSize:18];
    cell.textLabel.numberOfLines = 0;
    return cell;
}

//左侧的点击事件，刷新右侧
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //移除以往的界面
    for (id tmp in _rightScr.subviews) {
        [tmp removeFromSuperview];
    }
    //生成新界面
    NSArray *myarray = [_array objectAtIndex:indexPath.row];
    int i = 0;
    int height = 120;
    for (Goods *goods in myarray) {
        BtnSelf *btn = [[BtnSelf alloc]initWithGoods:goods andNav:self.navigationController andFrame:CGRectMake(0, (height+1)*i++, _rightScr.frame.size.width, height)];
        btn.backgroundColor = [UIColor whiteColor];
        [_rightScr addSubview:btn];
    }
    _rightScr.contentSize = CGSizeMake(0, height*i);
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
