//
//  HTQuickUITools.h
//  XiaotanFresh
//
//  Created by 谭康 on 2018/5/15.
//  Copyright © 2018年 caomall. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HTQuickUITools : NSObject

/**
 快速构建UILabel

 @param text 文字
 @param font 字体
 @param textColor 文字颜色
 @return 返回UILabel实例
 */
+ (UILabel*)ht_quickLabelWithText:(NSString*)text font:(UIFont*)font textColor:(UIColor*)textColor;


/**
 快速构建UIButton

 @param title 标题
 @param titleColor 标题颜色
 @param font 字体
 @param target target
 @param action 方法
 @return UIButton实例
 */
+(UIButton*)ht_quickButtonWithTitle:(NSString*)title titleColor:(UIColor*)titleColor titleFont:(UIFont*)font tartget:(nullable id)target action:(SEL)action;


/**
 快速构建UIButton
 
 @param title 标题
 @param titleColor 标题颜色
 @param font 字体
 @param target target
 @param action 方法
 @param borderColor 边框颜色
 @return UIButton实例
 */
+(UIButton*)ht_quickButtonWithTitle:(NSString*)title titleColor:(UIColor*)titleColor titleFont:(UIFont*)font tartget:(nullable id)target action:(SEL)action borderColor:(UIColor*)borderColor;
@end
