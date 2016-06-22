//
//  FirstTabBarController.m
//  ProjectDemo
//
//  Created by mac on 16/2/17.
//  Copyright © 2016年 Tea.Wu. All rights reserved.
//

#import "FirstTabBarController.h"
#import "HomeViewController.h"
#import "LikeViewController.h"
#import "ShopCarController.h"
#import "MeViewController.h"
#import "ShopCarViewController.h"
#import "ShopCar.h"
@interface FirstTabBarController ()
@property ShopCarController *shopView;
@end

@implementation FirstTabBarController
@synthesize shopView;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIStoryboard *homeViewStoryB = [UIStoryboard storyboardWithName:@"HomeStoryboard" bundle:nil];
    
    HomeViewController *homeView= [homeViewStoryB instantiateViewControllerWithIdentifier:@"HomeViewID"];
    UIImage *image1 = [UIImage imageNamed:@"home@2x.png"];
    UIImage *image2 = [UIImage imageNamed:@"home_selected@2x.png"];
    homeView.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"首页" image:image1 selectedImage:image2];
    
    UIStoryboard *LikeViewStoryB = [UIStoryboard storyboardWithName:@"LikeStoryboard" bundle:nil];
    LikeViewController *likeView = [LikeViewStoryB instantiateViewControllerWithIdentifier:@"LikeViewID"];
    UIImage *image3 = [UIImage imageNamed:@"tabbar_discover@2x.png"];
    UIImage *image4 = [UIImage imageNamed:@"tabbar_discover_selected@2x.png"];
    likeView.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"分类" image:image3 selectedImage:image4];
    
    UIStoryboard *ShopViewStoryB = [UIStoryboard storyboardWithName:@"ShopCarStoryboard" bundle:nil];
    shopView = [ShopViewStoryB instantiateViewControllerWithIdentifier:@"ShopViewID"];
    UIImage *image5 = [UIImage imageNamed:@"item@2x.png"];
    UIImage *image6 = [UIImage imageNamed:@"item_selected@2x.png"];
    shopView.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"购物车" image:image5 selectedImage:image6];
    shopView.tabBarItem.tag = 1;
    
    UIStoryboard *MeViewStoryB = [UIStoryboard storyboardWithName:@"MeStoryboard" bundle:nil];
    MeViewController *meView = [MeViewStoryB instantiateViewControllerWithIdentifier:@"MeViewID"];
    UIImage *image7 = [UIImage imageNamed:@"profile@2x.png"];
    UIImage *image8 = [UIImage imageNamed:@"profile_selected@2x.png"];
    meView.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"我" image:image7 selectedImage:image8];
    NSArray *arry = [NSArray arrayWithObjects:homeView,likeView,shopView,meView, nil];
    
    self.tabBarController.tabBar.delegate = self;
    [self setViewControllers:arry];
    // Do any additional setup after loading the view.
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
    if (item.tag == 1) {
        [shopView.viewControllers.firstObject reload];
    }
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
