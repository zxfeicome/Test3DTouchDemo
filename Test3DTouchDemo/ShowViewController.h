//
//  ShowViewController.h
//  Test3DTouchDemo
//
//  Created by 曾飞 on 2019/2/24.
//  Copyright © 2019年 浙江集商优选电子商务有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ShowViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *showLabel;
@property (nonatomic, strong) NSString *showStr;
@property (weak, nonatomic) IBOutlet UITextField *textField;


@end

NS_ASSUME_NONNULL_END
