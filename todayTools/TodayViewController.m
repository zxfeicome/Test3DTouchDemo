//
//  TodayViewController.m
//  TodayTools
//
//  Created by 曾飞 on 2019/3/3.
//  Copyright © 2019年 浙江集商优选电子商务有限公司. All rights reserved.
//

#import "TodayViewController.h"
#import <NotificationCenter/NotificationCenter.h>

@interface TodayViewController () <NCWidgetProviding>

@property (nonatomic, strong) UIButton *button;

@end

@implementation TodayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self layoutUI];

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self updateButtonTitle];
}

- (void)widgetPerformUpdateWithCompletionHandler:(void (^)(NCUpdateResult))completionHandler {
    // Perform any setup necessary in order to update the view.
    
    // If an error is encountered, use NCUpdateResultFailed
    // If there's no update required, use NCUpdateResultNoData
    // If there's an update, use NCUpdateResultNewData

    completionHandler(NCUpdateResultNewData);
}
//点击组件展开和收起的代理回调
- (void)widgetActiveDisplayModeDidChange:(NCWidgetDisplayMode)activeDisplayMode withMaximumSize:(CGSize)maxSize
API_AVAILABLE(ios(10.0)){
    //收起
    if (activeDisplayMode == NCWidgetDisplayModeCompact) {
        
        self.preferredContentSize = CGSizeMake(self.view.frame.size.width, 110);
        
    }
    //展开
    else if (activeDisplayMode == NCWidgetDisplayModeExpanded)
    {
        
        self.preferredContentSize = CGSizeMake(self.view.frame.size.width, 379);
        
    }
}

- (void)layoutUI
{
    //系统默认高度为110
    CGFloat viewHeight = 110;
    CGFloat viewWidth;
    //根据不同的系统版本设置颜色
    UIColor *textColor = [UIColor blackColor];
    //根据系统进行UI处理
    if (@available(iOS 10.0, *)) {
        //进入组件设置为展开模式
        [self.extensionContext setWidgetLargestAvailableDisplayMode:NCWidgetDisplayModeExpanded];
        //获取收起时的大小
        CGSize size = [self.extensionContext widgetMaximumSizeForDisplayMode:NCWidgetDisplayModeCompact];
        viewWidth = size.width;
        //10以后背景颜色偏白
        textColor = [UIColor blackColor];
    } else {
        // 10系统之前的宽度是屏幕宽度
        viewWidth = [UIScreen mainScreen].bounds.size.width;
        //10以前背景颜色偏黑
        textColor = [UIColor whiteColor];
        self.preferredContentSize = CGSizeMake(self.view.frame.size.width, 379);
    }
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, viewWidth, viewHeight)];
    
    //如果不设置颜色，只有文字区域可以响应点击事件
    button.backgroundColor = [UIColor colorWithWhite:1 alpha:0.5];
    [button setTitleColor:textColor forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonClickAction:) forControlEvents:UIControlEventTouchUpInside];
    self.button = button;
    [self updateButtonTitle];
    [self.view addSubview:button];
}

- (void)buttonClickAction:(UIButton *)sender
{
    //设置跳转到APP
    [self.extensionContext openURL:[NSURL URLWithString:@"Test3DTouch://test"] completionHandler:^(BOOL success) {
        
    }];
}
//iOS 10以下的系统设置，不然左边和下边会空出几个像素。
- (UIEdgeInsets)widgetMarginInsetsForProposedMarginInsets:(UIEdgeInsets)defaultMarginInsets
{
    return UIEdgeInsetsZero;
}

- (void)updateButtonTitle
{
    if (self.button) {
        NSUserDefaults *defaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.Test3DTouch"];
        NSString *title = [defaults objectForKey:@"Test_Title_key"];
        if ([title isKindOfClass:[NSString class]]) {
            [self.button setTitle:title forState:UIControlStateNormal];
        }else{
            [self.button setTitle:@"点击跳转" forState:UIControlStateNormal];
        }
    }
    
}

@end
