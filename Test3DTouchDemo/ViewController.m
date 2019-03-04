//
//  ViewController.m
//  Test3DTouchDemo
//
//  Created by 曾飞 on 2019/2/21.
//  Copyright © 2019年 浙江集商优选电子商务有限公司. All rights reserved.
//

#import "ViewController.h"
#import "ShowViewController.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,UIViewControllerPreviewingDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDelegate,UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        //判断3DTouch是否支持
        if ([self respondsToSelector:@selector(traitCollection)]) {
            if ([self.traitCollection respondsToSelector:@selector(forceTouchCapability)]) {
                if (self.traitCollection.forceTouchCapability == UIForceTouchCapabilityAvailable) {
                    //注册peek和pop手势
                    [self registerForPreviewingWithDelegate:self sourceView:cell];
                }
            }
        }
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%@ -- %@",[@(indexPath.row) stringValue],[self getPasswordData:[@(indexPath.row) stringValue]]];
    
    return cell;
}

- (NSString *)getPasswordData:(NSString *)accoutName
{

    NSDictionary *query = @{
                            (__bridge id)kSecClass : (__bridge id)kSecClassGenericPassword,
                            (__bridge id)kSecReturnData:@YES,
                            (__bridge id)kSecMatchLimit:(__bridge id)kSecMatchLimitOne,
                            (__bridge id)kSecAttrAccount:accoutName,
                            (__bridge id)kSecAttrService:@"loginPassword"
                             };
    CFTypeRef dataTypeRef = NULL;
    OSStatus status = SecItemCopyMatching((__bridge CFDictionaryRef)query, &dataTypeRef);
    if (status == errSecSuccess) {
        NSString *pwd = [[NSString alloc]initWithData:(__bridge NSData*)dataTypeRef encoding:NSUTF8StringEncoding];
        return pwd;
    }else
    {
        return @"";
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ShowViewController *showVC = [self.storyboard instantiateViewControllerWithIdentifier:@"ShowViewController"];
    showVC.showStr = [@(indexPath.row) stringValue];
    [self.navigationController pushViewController:showVC animated:YES];
}


#pragma mark - UIViewControllerPreviewingDelegate
// peek 预览功能代理
- (nullable UIViewController *)previewingContext:(id <UIViewControllerPreviewing>)previewingContext viewControllerForLocation:(CGPoint)location NS_AVAILABLE_IOS(9_0)
{
    if ([[previewingContext sourceView] isKindOfClass:[UITableViewCell class]]){
        NSIndexPath *indexPath = [self.tableView indexPathForCell:(UITableViewCell *)[previewingContext sourceView]];
        ShowViewController *showVC = [self.storyboard instantiateViewControllerWithIdentifier:@"ShowViewController"];
        showVC.showStr = [@(indexPath.row) stringValue];
        //通过上下文可以调整不被虚化的范围
//        CGRect rect = self.view.bounds;
//        previewingContext.sourceRect = rect;
        return showVC;
    }
    
    return nil;
}
//pop 跳转功能代理
- (void)previewingContext:(id<UIViewControllerPreviewing>)previewingContext commitViewController:(UIViewController *)viewControllerToCommit
{
    // 这个相当于push操作,push到预览的控制器
    [self showViewController:viewControllerToCommit sender:self];
}

@end
