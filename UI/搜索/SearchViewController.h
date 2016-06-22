//
//  SearchViewController.h
//  万表
//
//  Created by mac on 16/3/3.
//  Copyright © 2016年 zm. All rights reserved.
//


//初始状态的搜索界面，返回时不会进入此界面
#import <UIKit/UIKit.h>

@interface SearchViewController : UIViewController<UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate>
@property int flag;

@end
