//
//  ShowViewController.m
//  Test3DTouchDemo
//
//  Created by 曾飞 on 2019/2/24.
//  Copyright © 2019年 浙江集商优选电子商务有限公司. All rights reserved.
//

#import "ShowViewController.h"

@interface ShowViewController ()

@end

@implementation ShowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//
//    });
    self.showLabel.text = self.showStr;
}
- (IBAction)saveTitleDataAction:(id)sender {
    NSUserDefaults *defaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.Test3DTouch"];
//    NSString *title = [defaults objectForKey:@"Test_Title_key"];
    if (self.textField.text.length) {
        [defaults setObject:self.textField.text forKey:@"Test_Title_key"];
        [defaults synchronize];
        NSDictionary *query = @{//
                                (__bridge id)kSecAttrAccessible:(__bridge id)kSecAttrAccessibleWhenUnlocked,
                                (__bridge id)kSecClass:(__bridge id)kSecClassGenericPassword,
                                (__bridge id)kSecValueData:[self.textField.text dataUsingEncoding:NSUTF8StringEncoding],
                                (__bridge id)kSecAttrAccount:self.showStr,
                                (__bridge id)kSecAttrService:@"loginPassword"
                                
                                };
        CFTypeRef result;
        OSStatus status = SecItemAdd((__bridge CFDictionaryRef)query, &result);
        if (status == errSecSuccess) {
            NSLog(@"添加成功");
        }else{
            NSLog(@"添加失败");
        }
    }

    
}

- (NSArray<id<UIPreviewActionItem>> *)previewActionItems
{
    NSMutableArray *arrItem = [NSMutableArray array];
    UIPreviewAction *previewAction0 = [UIPreviewAction actionWithTitle:@"取消" style:UIPreviewActionStyleDestructive handler:^(UIPreviewAction * _Nonnull action, UIViewController * _Nonnull previewViewController) {
        NSLog(@"取消了");
    }];
    UIPreviewAction *previewAction1 = [UIPreviewAction actionWithTitle:@"功能1" style:UIPreviewActionStyleDefault handler:^(UIPreviewAction * _Nonnull action, UIViewController * _Nonnull previewViewController) {
        
    }];
    UIPreviewAction *previewAction2 = [UIPreviewAction actionWithTitle:@"被选中功能2" style:UIPreviewActionStyleSelected handler:^(UIPreviewAction * _Nonnull action, UIViewController * _Nonnull previewViewController) {
        
    }];
    [arrItem addObjectsFromArray:@[previewAction0,previewAction1,previewAction2]];
    return arrItem;
}

@end
