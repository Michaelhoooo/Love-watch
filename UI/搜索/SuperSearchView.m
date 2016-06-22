//
//  SuperSearchView.m
//  万表
//
//  Created by mac on 16/3/3.
//  Copyright © 2016年 zm. All rights reserved.
//

#import "SuperSearchView.h"
#define SCREEN_WIDTH    ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT   ([[UIScreen mainScreen] bounds].size.height)
#define  WIDTH self.frame.size.width
#define  HEIGHT self.frame.size.height

@implementation SuperSearchView

- (void)load {
    
    _searchDic = [[SearchDic alloc]init].array;
    _flag = -1;
    self.backgroundColor = [UIColor clearColor];
    
    _cancle = [[UIButton alloc]init];
    _backLast = [[UIButton alloc]init];
    _myTableView = [[UITableView alloc]init];
    [self changeSmall];
    [self addSubview:_backLast];
    [self addSubview:_cancle];
    [self addSubview:_myTableView];
    [_cancle setTitle:@"取消" forState:UIControlStateNormal];
    [_backLast setTitle:@"返回上一层" forState:UIControlStateNormal];
    _myTableView.delegate = self;
    _myTableView.dataSource = self;
    _cancle.backgroundColor = [UIColor whiteColor];
    _myTableView.backgroundColor = [UIColor whiteColor];
    _backLast.backgroundColor = [UIColor whiteColor];
    [_cancle setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_backLast setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_cancle addTarget:self action:@selector(cancle:) forControlEvents:UIControlEventTouchUpInside];
    [_backLast addTarget:self action:@selector(returnLast:) forControlEvents:UIControlEventTouchUpInside];
}

//显示界面，从右侧滑chulai
- (void)changeBig {
    self.cancle.frame = CGRectMake(SCREEN_WIDTH/4, 64, SCREEN_WIDTH*3/4, 44);
    self.myTableView.frame = CGRectMake(SCREEN_WIDTH/4, 108, SCREEN_WIDTH*3/4, HEIGHT-88-64-44);
    self.backLast.frame = CGRectMake(SCREEN_WIDTH/4, HEIGHT-88, SCREEN_WIDTH*3/4, 44);
}

//收起界面，从右侧滑chuqu
- (void)changeSmall {
    self.frame = CGRectMake(1000, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    self.cancle.frame = CGRectMake(1000, 64, SCREEN_WIDTH*3/4, 44);
    self.myTableView.frame = CGRectMake(1000, 108, SCREEN_WIDTH*3/4, HEIGHT-88-64-44);
    self.backLast.frame = CGRectMake(1000, HEIGHT-88, SCREEN_WIDTH*3/4, 44);
}

//取消按钮，收起界面
- (void)cancle:(id)sender {
    [UIView animateWithDuration:1 animations:^(){
        [self changeSmall];
    }];
    
    NSLog(@"cancle");
}
//筛选栏返回上一层筛选界面
- (void)returnLast:(id)sender {
    self.flag = -1;
    [self reload];
    NSLog(@"return last");
}
//刷新
- (void)reload {
    [_myTableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (_flag == -1) {
        return _searchDic.count;
    }else{
        return _classDic.count-1;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (_flag) {
        case -1:{
           UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"-1"];
            if (cell == nil) {
                cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"-1"];
                NSArray *array = _searchDic[indexPath.row];
                cell.textLabel.text = array[0];
            }
            return cell;
        }
        case 0:{
            UITableViewCell *cell ;
            if (cell == nil) {
                cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"0"];;
                cell.textLabel.text = _classDic[indexPath.row+1];
            }
            return cell;
        }

        default:
            return nil;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_flag == -1) {
        _classDic = _searchDic[indexPath.row];
        _flag = 0;
        [_myTableView reloadData];
    }else if (_flag == 0){
        //把选择结果传递回二级界面，进行搜索
        [self.delegate chooseSearch];
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        if (_classDic == _searchDic.lastObject) {
            [self.delegate searchByPrice:indexPath.row];
        }else{
            [self.delegate searchByString:cell.textLabel.text];
        }
    }
}


@end
