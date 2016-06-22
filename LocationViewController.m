//
//  LocationViewController.m
//  TestScan
//
//  Created by mac on 16/3/9.
//  Copyright © 2016年 Michael. All rights reserved.
//

#import "LocationViewController.h"
#import "SNLocationManager.h"
@interface LocationViewController ()
@property (weak, nonatomic) IBOutlet UILabel *Location;

@end

@implementation LocationViewController
- (IBAction)btnClick:(id)sender {
    [[SNLocationManager shareLocationManager] startUpdatingLocationWithSuccess:^(CLLocation *location, CLPlacemark *placemark) {
        NSString *str = placemark.name;
        
        NSString *str1 = [NSString stringWithFormat:@"%@%@",str,placemark.thoroughfare];
        _Location.text = str1;
        NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
        [user setValue:_Location.text forKey:@"lo"];
        NSLog(@"%@",placemark.thoroughfare);
    } andFailure:^(CLRegion *region, NSError *error) {
        
    }];
}
- (IBAction)la:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
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
