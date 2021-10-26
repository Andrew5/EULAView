//
//  ViewController.m
//  EULAView
//
//  Created by jabraknight on 2021/10/25.
//

#import "ViewController.h"
#import "EULAAlertView.h"
#import <AVFoundation/AVFoundation.h>
#import <CoreLocation/CoreLocation.h>
#import <CoreTelephony/CTCellularData.h>
#import <Photos/Photos.h>
#import <MediaPlayer/MediaPlayer.h>

@interface ViewController ()<CLLocationManagerDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    
    [ViewController authWithAlertV:YES completion:^(BOOL isAuth) {
        
    }];
    [ViewController authWithAlertA:YES completion:^(BOOL isAuth) {
        
    }];
    [ViewController authWithAlertN:YES completion:^(BOOL isAuth) {
        
    }];
    [ViewController authWithAlertP:YES completion:^(BOOL isAuth) {
        
    }];
    [ViewController authWithAlertM:YES completion:^(BOOL isAuth) {
        
    }];
    [self checkAuth];
    UIButton *userAgreementButton = [[UIButton alloc] init];
    userAgreementButton.frame = CGRectMake(self.view.center.x-25, self.view.center.y-25, 50, 50);
    [userAgreementButton setTitle:@"点击" forState:(UIControlStateNormal)];
    [userAgreementButton setTitleColor:UIColor.yellowColor forState:(UIControlStateNormal)];
    userAgreementButton.backgroundColor = [UIColor blueColor];
    [userAgreementButton addTarget:self action:@selector(clickUserAgreement) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:userAgreementButton];
}


- (BOOL)checkAuth
{
    BOOL isAuth = NO;
    if ([CLLocationManager locationServicesEnabled]) {
        CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
        if (status == kCLAuthorizationStatusAuthorizedAlways || status == kCLAuthorizationStatusAuthorizedWhenInUse) {
            isAuth = YES;
        }
    }
    return isAuth;
}
+ (void)authWithAlertV:(BOOL)isAlert completion:(void(^)(BOOL isAuth))completion {
    [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (granted) {
                completion(YES);
            } else {
                if (isAlert) {

                }
                completion(NO);
            }
        });
    }];
}
+ (void)authWithAlertA:(BOOL)isAlert completion:(void(^)(BOOL isAuth))completion
{
    [AVCaptureDevice requestAccessForMediaType:AVMediaTypeAudio completionHandler:^(BOOL granted) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (granted) {
                completion(YES);
            } else {
                if (isAlert) {

                }
                completion(NO);
            }
        });
    }];
}
+ (void)authWithAlertN:(BOOL)isAlert completion:(nullable void(^)(BOOL isAuth))completion
{
    if (@available(iOS 9.0, *)) {
        CTCellularData *cellularData = [[CTCellularData alloc]init];
        cellularData.cellularDataRestrictionDidUpdateNotifier = ^(CTCellularDataRestrictedState state)
        {
            //获取联网状态
            switch (state)
            {
                case kCTCellularDataRestricted: NSLog(@"蜂窝移动网络权限：Restricrted"); break;
                case kCTCellularDataNotRestricted: NSLog(@"蜂窝移动网络权限：Not Restricted"); break;
                    //未知，第一次请求
                case kCTCellularDataRestrictedStateUnknown: NSLog(@"蜂窝移动网络权限：Unknown"); break;
                default: break;
            };
        };
    }
}
+ (void)authWithAlertP:(BOOL)isAlert completion:(void(^)(BOOL isAuth))completion
{
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (status == PHAuthorizationStatusAuthorized) {
                completion(YES);
            }else{
                if (isAlert) {
                }
                completion(NO);
            }
        });
    }];
}
+ (void)authWithAlertM:(BOOL)isAlert completion:(void(^)(BOOL isAuth))completion
{
    if (@available(iOS 9.3, *)) {
        [MPMediaLibrary requestAuthorization:^(MPMediaLibraryAuthorizationStatus status) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (status == MPMediaLibraryAuthorizationStatusAuthorized) {
                    completion(YES);
                } else{
                    if (isAlert) {
                    }
                    completion(NO);
                }
            });
        }];
    } else {
        NSLog(@"当前系统版本低于iOS9.3，直接返回获取到了权限（如果有问题请更改权限获取方式！）");
        completion(YES);
    }
}
- (void)clickUserAgreement{

//    if (![[NSUserDefaults standardUserDefaults] objectForKey:@"firstValue"] ) {//NO
//        EULAAlertView*alertView = [[EULAAlertView alloc]initWithFrame:self.view.bounds];
//        [self.view addSubview:alertView];
//        [[UIApplication sharedApplication].keyWindow addSubview:alertView];
//    }
}
- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    if (status == kCLAuthorizationStatusNotDetermined) {//第一次弹出授权页面，不处理

    }else{
        if (status == kCLAuthorizationStatusAuthorizedAlways || status == kCLAuthorizationStatusAuthorizedWhenInUse) {
            
        }
    }
}
@end

