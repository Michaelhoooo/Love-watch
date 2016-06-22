//
//  SCGuideViewController.m
//  SCGuide
//
//  Created by show class on 15/11/30.
//  Copyright © 2015年 show class. All rights reserved.
//

#import "SCGuideViewController.h"
#import "CALayer+Transition.h"
#import "UIView+Uitls.h"

@interface SCGuideViewController () <UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *pageScroll;
@property (nonatomic, strong) UIViewController *con;

@end

@implementation SCGuideViewController

- (id)initWithViewController:(UIViewController *)controller
{
    if (self = [super init]) {
        _con = controller;
    }
    return self;
}

- (void)loadView
{
    [super loadView];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSArray *imageNameArray = [NSArray arrayWithObjects: @"20140505110627_eBXed.thumb.600_0.jpeg" ,nil];
    
    _pageScroll = [[UIScrollView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    _pageScroll.bounces = NO;
    _pageScroll.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _pageScroll.showsHorizontalScrollIndicator = NO;
    _pageScroll.delegate = self;
    _pageScroll.pagingEnabled = YES;
    _pageScroll.contentSize = CGSizeMake(self.view.frame.size.width * imageNameArray.count, self.view.frame.size.height);
    [self.view addSubview:_pageScroll];
    
    
    NSString *imageName = nil;
    for (int i = 0; i < imageNameArray.count; i++) {
        imageName = [imageNameArray objectAtIndex:i];
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
        imageView.frame = [UIScreen mainScreen].bounds;
        imageView.origin = CGPointMake(i * imageView.width, 0);
        imageView.contentMode = UIViewContentModeScaleToFill;
        imageView.userInteractionEnabled = YES;
        [self.pageScroll addSubview:imageView];
        
        UIButton *enterBtn = nil;
        if (i == imageNameArray.count - 1) {
            
            enterBtn = [[UIButton alloc] initWithFrame:self.view.frame];
//            enterBtn = [[UIButton alloc] initWithFrame:(CGRect){
//                .origin = {.x = (self.view.width - 70) / 2, .y = self.view.height - 45},
//                .size = {.width = 70 , .height = 20}
//            }];
//            
//            [enterBtn setBackgroundImage:[UIImage imageNamed:@"entry"] forState:UIControlStateNormal];
//            [enterBtn setBackgroundImage:[UIImage imageNamed:@"entry"] forState:UIControlStateHighlighted];
            [enterBtn addTarget:self action:@selector(enter) forControlEvents:UIControlEventTouchUpInside];
            //[imageView addSubview:enterBtn];
            
            [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(enter) userInfo:nil repeats:NO];
        }
        
    }
    [_pageScroll setContentOffset:CGPointMake(0.f, 0.f)];
}

- (BOOL)prefersStatusBarHidden
{
    return YES; // 返回NO表示要显示，返回YES将hiden
}

- (void)enter
{
    [self transition:TransitionAnimTypeRippleEffect];
}


- (void)transition:(TransitionAnimType)type
{
    [UIApplication sharedApplication].delegate.window.rootViewController = _con;
    [[UIApplication sharedApplication].delegate.window.layer transitionWithAnimType:type subType:TransitionSubtypesFromRight curve:TransitionCurveLinear duration:0.6f];
}

@end
