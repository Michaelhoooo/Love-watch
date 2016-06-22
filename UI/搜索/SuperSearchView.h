//
//  SuperSearchView.h
//  万表
//
//  Created by mac on 16/3/3.
//  Copyright © 2016年 zm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SearchDic.h"
@protocol sure

- (void)chooseSearch;
- (void)searchByString:(NSString *)string;
- (void)searchByPrice:(int)index;

@end

@interface SuperSearchView : UIView <UITableViewDataSource,UITableViewDelegate>

@property  UITableView *myTableView;
@property  UIButton *backLast;
@property  UIButton *cancle;

@property NSArray *searchDic;
@property int flag;
@property NSArray *classDic;

//完成搜索二级界面和本界面的数据同步、传递
@property id<sure> delegate;
- (void)reload;
- (void)load;
- (void)changeSmall;
- (void)changeBig;

@end
