//
//  ViewController.m
//  EULAView
//
//  Created by jabraknight on 2021/10/25.
//

#import "ViewController.h"
#import "EULAAlertView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *userAgreementButton = [[UIButton alloc] init];
    userAgreementButton.frame = CGRectMake(self.view.center.x-25, self.view.center.y-25, 50, 50);
    [userAgreementButton setTitle:@"点击" forState:(UIControlStateNormal)];
    [userAgreementButton setTitleColor:UIColor.yellowColor forState:(UIControlStateNormal)];
    userAgreementButton.backgroundColor = [UIColor blueColor];
    [userAgreementButton addTarget:self action:@selector(clickUserAgreement) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:userAgreementButton];
}
- (void)clickUserAgreement{
    if (![[NSUserDefaults standardUserDefaults] objectForKey:@"firstValue"] ) {//NO
        EULAAlertView*alertView = [[EULAAlertView alloc]initWithFrame:self.view.bounds];
        [self.view addSubview:alertView];
        [[UIApplication sharedApplication].keyWindow addSubview:alertView];
    }
}

@end

