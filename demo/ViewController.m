//
//  ViewController.m
//  demo
//
//  Created by iVermisseDich on 2017/7/3.
//  Copyright © 2017年 com.ksyun. All rights reserved.
//

#import "ViewController.h"
#import "KSYCfgViewController.h"
#import "FilterManager.h"
#import "ReLogViewController.h"
#import "KSYNavigationController.h"
#define kGetAkURI       @"http://ksvs-demo.ks-live.com:8321/Auth"

//#define kToken @"siE71VDDm2aDQVJXOgzGDux1DM+s0ISFh1ksTZReXYaXaK1PUSjG2lwQbrv6y+tldpJf7icL44p3nUQG7uoOyXhjtI7rtK+QdLIUvLj6JvULkNoer2PINzl4n+6aymVFRWuduuP/FATJsCMHTJxKlfAi656Zhb9cLg7RhlJ8a8I=knxbvEib/gbJwRO62EMmn2YuFPtdtwOkCUQAaR9VPX6AtlVFlr76dBnq7bU1fUtlc/mDciv7sdlsk27eZYdqhyXxL7mnK2jonyjKzdrPTi/R5Px4/dnZ0ME62kWtmf08dzCgv43sSUYfCnerXiuQIi9ILniDLpB15XQ62OJs8NE="

#define kToken @"YahPDqVwLZWFL3C7xKm0cbFFJ7HEVlp0P3eXGQIt/WbgYGxTw692z9D4CG30LwLyJGFhzjjCW269taRHYzKuOb8VbTvsAmHSgMae8cl+3IXB2nXLZHlcDl8PT/B9JXaaNAkImkysKdd4kklzKd8IVe2t8zN3vvoMnSM5+1GN79M=IBfXT3wH0UuZO1A2PMQKttrlAZZZojXzZ5lYtv3szPzC985IF9mFa82ie+fkqweXS5lTfXIyFlfzLey1pjp4OoHOifUwhIUIXtWdgo9fiFTyJPtEpScicoiFXiyK9g+xzrASo3divXLqi+fG+ksu71AkJApFwB5Sa1YS1Q1U35Y="

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *versionLabel;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = YES;
    // 短视频SDK鉴权
    [self requestOffLineAuth];
    
    // 商汤第三方鉴权
    [[FilterManager instance] setupWithTokeID:@"557dd71f0c01c67ab36d5318b2cdfb9f" Onsuccess:^{
        NSLog(@"获取列表完成");
    }];
    
    NSString *version = [[[NSBundle mainBundle] infoDictionary] valueForKey:@"CFBundleVersion"];
    _versionLabel.text = [NSString stringWithFormat:@"SDK V%@版本", version];
}

- (void)awakeFromNib{
    [super awakeFromNib];
}

- (IBAction)startShortVideoAction:(UIButton *)sender {
    KSYCfgViewController *ksyCfgVC = [[KSYCfgViewController alloc] initWithNibName:@"KSYCfgViewController" bundle:[NSBundle mainBundle]];
    KSYNavigationController *nvg = [[KSYNavigationController alloc] initWithRootViewController:ksyCfgVC];
    [[UIApplication sharedApplication].keyWindow setRootViewController:nvg];
}

#pragma mark - SDK离线鉴权示例（具体流程请参考wiki）

- (void)requestOffLineAuth{
    [KSYMEAuth sendClipSDKAuthRequestWithToken:kToken complete:^(KSYStatusCode rc, NSError *error) {
        if(error == nil) {
            NSLog(@"离线鉴权成功");
        } else {
            NSLog(@"code:%zd,reason:%@",rc,error);
        }
    }];
}

- (IBAction)versionLogAction:(UIButton *)sender {
    ReLogViewController *logVC = [[ReLogViewController alloc] initWithNibName:@"ReLogViewController" bundle:nil];
    [self.navigationController pushViewController:logVC animated:YES];
}


#pragma mark -
#pragma mark - life cycle 视图的生命周期
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
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
