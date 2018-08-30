//
//  NSDecimalNumber+HTExtension.m
//  shengjitong
//
//  Created by 海涛 黎 on 2018/4/17.
//  Copyright © 2018年 sj. All rights reserved.
//

#import "NSDecimalNumber+HTExtension.h"

@implementation NSDecimalNumber (HTExtension)
/**
 比较两个数字的大小
 
 @param num1 被比较的数字
 @param num2 比较的数字
 @param numberOfFractionalPart 小数的位数
 @return 返回结果
 */
+(HTCompareResult)ht_compareNum1:(float)num1 num2:(float)num2 numberOfFractionalPart:(NSInteger)numberOfFractionalPart{
    
    NSDecimalNumber *afterMultiplying_clearrate = [NSDecimalNumber decimalNumberWithString:[NSDecimalNumber ht_floatToStringWithFloatNumber:num1 numberOfFractionalPart:numberOfFractionalPart]];
    NSDecimalNumber *decimalNumber_per_assurescale_value = [NSDecimalNumber decimalNumberWithString:[NSDecimalNumber ht_floatToStringWithFloatNumber:num2 numberOfFractionalPart:numberOfFractionalPart]];
    NSComparisonResult result_clearrate_float = [afterMultiplying_clearrate compare:decimalNumber_per_assurescale_value];
    switch (result_clearrate_float) {
        case NSOrderedDescending:
            return HTCompareResultMoreThan;
            break;
            
        case NSOrderedSame:
            return HTCompareResultSame;
            break;
            
        case NSOrderedAscending:
            return HTCompareResultLessThan;
            break;
            
        default:
            return HTCompareResultUnKnown;
            break;
    }
}


/**
 将float类型转化为指定小数点后位数的字符串

 @param floatNumber float类型数据
 @param numberOfFractionalPart 小数点后的位数
 @return 转换后的字符串
 */
+ (NSString *)ht_floatToStringWithFloatNumber:(CGFloat)floatNumber numberOfFractionalPart:(NSInteger)numberOfFractionalPart{
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
//    formatter.numberStyle = NSNumberFormatterDecimalStyle;
//    formatter.groupingSize = 3;
    //设置最多保留几位小数
    formatter.maximumFractionDigits = numberOfFractionalPart;
    //设置最少保留几位小数
    formatter.minimumFractionDigits = numberOfFractionalPart;
    //由于最多与最少是不矛盾的所以要精确到几位小数只要同时设置就好了，如果只是最多，或只是最少的话可以把上面两行中的一行注释即可
//    formatter.groupingSeparator = @",";
    
    NSString *floatNumberStr = [formatter stringFromNumber:@(floatNumber)];
    return floatNumberStr;
}
@end
