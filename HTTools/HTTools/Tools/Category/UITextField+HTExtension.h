//
//  UITextField+HTExtension.h
//  shengjitong
//
//  Created by 海涛 黎 on 2018/4/17.
//  Copyright © 2018年 sj. All rights reserved.
//



@interface UITextField (HTExtension)
/**
 限制只能输入数字
 
 @param textField 输入框
 @param range range
 @param string 输入的string
 @param numberOfFractionalPart 允许输入小数的位数
 @return 是否符合要求
 */
+ (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string numberOfFractionalPart:(NSInteger)numberOfFractionalPart;
@end
