//
//  NSDecimalNumber+HTExtension.h
//  shengjitong
//
//  Created by 海涛 黎 on 2018/4/17.
//  Copyright © 2018年 sj. All rights reserved.
//


typedef NS_ENUM(NSInteger, HTCompareResult) {
    HTCompareResultMoreThan,  //大于
    HTCompareResultSame,  //等于
    HTCompareResultLessThan,   //小于
    HTCompareResultUnKnown   //未知结果
};

@interface NSDecimalNumber (HTExtension)

/**
 比较两个数字的大小

 @param num1 被比较的数字
 @param num2 比较的数字
 @param numberOfFractionalPart 小数的位数
 @return 返回结果
 */
+ (HTCompareResult)ht_compareNum1:(float)num1 num2:(float)num2 numberOfFractionalPart:(NSInteger)numberOfFractionalPart;

/**
 将float类型转化为指定小数点后位数的字符串
 
 @param floatNumber float类型数据
 @param numberOfFractionalPart 小数点后的位数
 @return 转换后的字符串
 */
+ (NSString *)ht_floatToStringWithFloatNumber:(CGFloat)floatNumber numberOfFractionalPart:(NSInteger)numberOfFractionalPart;
@end
