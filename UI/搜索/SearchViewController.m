//
//  SearchViewController.m
//  万表
//
//  Created by mac on 16/3/3.
//  Copyright © 2016年 zm. All rights reserved.
//

#import "SearchViewController.h"
#import "DidSearchViewController.h"
#import "SearchFoot.h"

@interface SearchViewController ()
@property (weak, nonatomic) IBOutlet UITextField *textFiled;
@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property SearchFoot *searchFoot;
@property NSArray *array;

@end

@implementation SearchViewController

//取消键，取消搜索，返回上一层界面
- (IBAction)cancle:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
    if (_flag == 1) {
        self.navigationController.navigationBarHidden = YES;
    }else{
        self.navigationController.navigationBarHidden = NO;
    }
    
}

#pragma TableView Delegate&&DataSource
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    DidSearchViewController *dsvc = [[DidSearchViewController alloc]init];
    [self.textFiled endEditing:YES];
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    dsvc.searchKey = cell.textLabel.text;
    dsvc.flag = _flag;
    [self.navigationController pushViewController:dsvc animated:YES];
    self.navigationController.navigationBarHidden = NO;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return @"热门分类";
    }else{
        return @"历史记录";
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return _array.count;
    }else{
        return _searchFoot.array.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"search"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"search"];
    }
    if (indexPath.section == 0) {
        cell.textLabel.text = _array[indexPath.row];
    }else{
        cell.textLabel.text = _searchFoot.array[indexPath.row];
    }
    return cell;
}

#pragma TextField Delegate
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    _myTableView.frame = CGRectMake(0, 74, _myTableView.frame.size.width, _myTableView.frame.size.height-250);
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.textFiled endEditing:YES];
    _myTableView.frame = CGRectMake(0, 74, _myTableView.frame.size.width, _myTableView.frame.size.height+250);
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    DidSearchViewController *dsvc = [[DidSearchViewController alloc]init];
    [self.textFiled endEditing:YES];
    dsvc.searchKey = _textFiled.text;
    dsvc.flag = _flag;
    [self.navigationController pushViewController:dsvc animated:YES];
    self.navigationController.navigationBarHidden = NO;
    
    return YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationController.navigationBarHidden = YES;
    _textFiled.leftViewMode = UITextFieldViewModeAlways;
    UIImageView *sim = [[UIImageView alloc]init];
    sim.frame = CGRectMake(0, 0, 20, 20) ;
    [sim setImage:[UIImage imageNamed:@"tabbar_discover@2x.png"]];
    _textFiled.leftView = sim;
    _textFiled.delegate = self;
    _textFiled.returnKeyType = UIReturnKeySearch;
    _textFiled.clearButtonMode = UITextFieldViewModeAlways;
    
    _myTableView.delegate = self;
    _myTableView.dataSource = self;
    _searchFoot = [[SearchFoot alloc]init];
    _array = @[@"劳力士",@"江诗丹顿",@"机械",@"男表",@"女表"];

    _myTableView.frame = CGRectMake(0, 74, self.view.frame.size.width, self.view.frame.size.height-114);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    NSLog(@"进入搜索界面");
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
