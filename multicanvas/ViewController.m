//
//  ViewController.m
//  multicanvas
//
//  Created by sunyazhou on 2017/11/23.
//  Copyright © 2017年 com.ksyun. All rights reserved.
//

#import "ViewController.h"

#import "KSYConfigViewController.h"

#define kToken @"YahPDqVwLZWFL3C7xKm0cbFFJ7HEVlp0P3eXGQIt/WbgYGxTw692z9D4CG30LwLyJGFhzjjCW269taRHYzKuOb8VbTvsAmHSgMae8cl+3IXB2nXLZHlcDl8PT/B9JXaaNAkImkysKdd4kklzKd8IVe2t8zN3vvoMnSM5+1GN79M=rVMG9F/aepnNDdj7bWNEmvzSzcFj9JMPUVI+RuQ86zerMPWhI2+sEtg/Vr2uOyitrJGBxob2nEhkpdLf3C5PI44mmvexpM3YB3oIStmcqXQAnCax7cgws2lpTcdjphSAbuMQIpVetIMKwxCdlq0yITdPoDLJgg/VYHKRAUABNzM="


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.hidden = YES;
    [self requestOffLineAuth];
}

#pragma mark -
#pragma mark - private methods 私有方法
//SDK离线鉴权示例（具体流程请参考wiki）
- (void)requestOffLineAuth{
    [KSYMEAuth sendClipSDKAuthRequestWithToken:kToken complete:^(KSYStatusCode rc, NSError *error) {
        if(error == nil) {
            NSLog(@"离线鉴权成功");
        } else {
            NSLog(@"code:%zd,reason:%@",rc,error);
        }
    }];
}
#pragma mark -
#pragma mark - public methods 公有方法
#pragma mark -
#pragma mark - override methods 复写方法
#pragma mark -
#pragma mark - getters and setters 设置器和访问器
#pragma mark -
#pragma mark - UITableViewDelegate
#pragma mark -
#pragma mark - CustomDelegate 自定义的代理
#pragma mark -
#pragma mark - event response 所有触发的事件响应 按钮、通知、分段控件等
- (IBAction)startShortVideoAction:(UIButton *)sender {
    //进入短视频SDK for 多画布
    KSYConfigViewController *configVC = [[KSYConfigViewController alloc] initWithNibName:[KSYConfigViewController className] bundle:[NSBundle mainBundle]];
    
    [self.navigationController pushViewController:configVC animated:YES];
}
#pragma mark -
#pragma mark - life cycle 视图的生命周期
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}
#pragma mark -
#pragma mark - StatisticsLog 各种页面统计Log

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

- (BOOL)shouldAutorotate{
    return NO;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskPortrait;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return UIInterfaceOrientationPortrait;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
