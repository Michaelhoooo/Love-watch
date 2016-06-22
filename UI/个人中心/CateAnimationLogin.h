//
//  CateAnimationLogin.h
//  cutelogin
//
//  Created by Michael.
//  Copyright © 2016年 . All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,ClickType){
    clicktypeNone,
    clicktypeUser,
    clicktypePass
};
@interface CateAnimationLogin : UIView
@property (strong, nonatomic)UITextField *userNameTextField;
@property (strong, nonatomic)UITextField *PassWordTextField;
@end
