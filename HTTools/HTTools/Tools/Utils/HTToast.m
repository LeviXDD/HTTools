//
//  HTToast.m
//  LaiCiMai
//
//  Created by 海涛 黎 on 2017/11/1.
//  Copyright © 2017年 ShengJiTong. All rights reserved.
//

#import "HTToast.h"
#import "MBProgressHUD+MJ.h"
@implementation HTToast
+(void)showMessagetoWindow:(NSString *)msg{
    [MBProgressHUD showMessage:EMPTY_IF_NIL(msg) toView:[UIApplication sharedApplication].keyWindow];
}

+(void)showMessage:(NSString *)msg{
    [MBProgressHUD showMessage:EMPTY_IF_NIL(msg)];
}

+(void)showErrorWithMessage:(NSString *)errorMsg{
    [MBProgressHUD showSuccess:EMPTY_IF_NIL(errorMsg)];
}

+(void)showProgress{
    [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
}

+(void)hideProgress{
    [MBProgressHUD hideHUDForView:[UIApplication sharedApplication].keyWindow];
}
@end
