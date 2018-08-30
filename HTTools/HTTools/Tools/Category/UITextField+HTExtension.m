//
//  UITextField+HTExtension.m
//  shengjitong
//
//  Created by 海涛 黎 on 2018/4/17.
//  Copyright © 2018年 sj. All rights reserved.
//

#import "UITextField+HTExtension.h"

@implementation UITextField (HTExtension)

/**
 限制只能输入数字

 @param textField 输入框
 @param range range
 @param string string
 @param numberOfFractionalPart 允许输入小数的位数
 @return 是否符合要求
 */
+ (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string numberOfFractionalPart:(NSInteger)numberOfFractionalPart{
    //    限制只能输入数字
    BOOL isHaveDian = YES;
    if ([string isEqualToString:@" "]) {
        return NO;
    }
    
    if ([textField.text rangeOfString:@"."].location == NSNotFound) {
        isHaveDian = NO;
    }
    if ([string length] > 0) {
        
        unichar single = [string characterAtIndex:0];//当前输入的字符
        if ((single >= '0' && single <= '9') || single == '.') {//数据格式正确
            
            if([textField.text length] == 0){
                if(single == '.') {
//                    [HTToast showMessage:@"数据格式有误"];
                    [textField.text stringByReplacingCharactersInRange:range withString:@""];
                    return NO;
                }
            }
            
            //输入的字符是否是小数点
            if (single == '.') {
                if(!isHaveDian)//text中还没有小数点
                {
                    isHaveDian = YES;
                    return YES;
                    
                }else{
//                    [HTToast showMessage:@"数据格式有误"];
                    [textField.text stringByReplacingCharactersInRange:range withString:@""];
                    return NO;
                }
            }else{
                if (isHaveDian) {//存在小数点
                    
                    //判断小数点的位数
                    NSRange ran = [textField.text rangeOfString:@"."];
                    if (range.location - ran.location <= 2) {
                        return YES;
                    }else{
//                        [HTToast showMessage:@"最多两位小数"];
                        return NO;
                    }
                }else{
                    return YES;
                }
            }
        }else{//输入的数据格式不正确
//            [HTToast showMessage:@"数据格式有误"];
            [textField.text stringByReplacingCharactersInRange:range withString:@""];
            return NO;
        }
    }
    else
    {
        return YES;
    }
}
@end
