//
//  DidSearchViewController.h
//  万表
//
//  Created by mac on 16/3/3.
//  Copyright © 2016年 zm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SearchFoot.h"
#import "DataGet.h"
#import "SuperSearchView.h"

//点击搜索之后进入的显示界面

@interface DidSearchViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,sure>

@property NSString *searchKey;
@property SearchFoot *searchFoot;
@property DataGet *dataGet;
@property NSMutableArray *searchResult;
@property int flag;



@end
