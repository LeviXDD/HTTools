//
//  HTUtils.h
//  黎海涛
//
//  Created by dm on 16/3/30.
//  Copyright © 2016年 taigu. All rights reserved.
//

/*!
 @author DM, 16-03-30 14:03:26
 
 @brief <#Description#>
 */
//typedef NS_ENUM(NSUInteger, UILabelResizeType) {
//    UILabelResizeTypeHorizontal,
//    UILabelResizeTypeVertical,
//};

/*时间格式定义*/
#define yyyy_MM_dd_HH_mm_ss @"yyyy-MM-dd HH:mm:ss"
#define yyyy_MM_dd @"yyyy-MM-dd"
#define yyyy_MM_dd_hh_mm_ss @"yyyy-MM-dd hh:mm:ss"
#define yyyyYearMMMonthddDay_EEEE_HH_mm @"yyyy年MM月dd日 EEEE HH:mm"  //xxxx年xx月xx日 星期x xx:xx
#define yyyyYearMMMonthddDay_EEEE_aaa_HH_mm @"yyyy年MM月dd日 EEEE aaa HH:mm"
#define yyyy_MM_dd_A_mm_ss @"yyyy/MM/dd   a h:mm "

/*文字字体*/
#define kPingFangSC_Regular @"PingFangSC-Regular"  //苹方
#define kPingFangSC_Medium @"PingFangSC-Medium"  //苹方
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
@interface HTUtils : NSObject
#pragma mark - 手机号/密码/验证码/邮箱校验
+(BOOL)phoneNumberCheck:(NSString*)phoneNumber;
+(BOOL)passWordCheck:(NSString*)passWord;
+(BOOL)codeCheck:(NSString*)code;
+(BOOL)emailCheck:(NSString*)email;
+(BOOL)nickName:(NSString*)nickName; //昵称（仅包含汉字、大小写字母、下划线、横线）

/*生成随机整数
 *包括from 包括to
 */
+(NSInteger)randomIntegerFrom:(NSInteger)from to:(NSInteger)to;

#pragma mark - UI相关
///随机颜色
+(UIColor *)randomColor;

///字符串大小
+ (CGSize)sizeString:(NSString *)string font:(UIFont *)font;

#pragma mark - 获取当前控制器
+ (UIViewController*) currentViewController;

#pragma mark - 获取当前TabbarControoler上某个位置的控制器
+ (UIViewController*)viewControllerAtIndexOfTabbar:(NSInteger)index;

#pragma mark - 跳转到指定页面
+ (void)popToViewController:(Class)controllerClass;

#pragma mark - 字符串相关操作
#pragma mark  去除字符串两边空格
+ (NSString*)removeAllSpaceCharacterInString:(NSString*)string;

#pragma mark url参数编码
+ (NSString *)encodeParameter:(NSString *)originalPara;

#pragma mark - 时间相关
#pragma mark  时间格式转换
/*date -> string*/
+ (NSString*)dateToString:(NSDate*)date format:(NSString*)format;

+ (NSString *)AMPMFromRongweiTime:(NSString *)fromTime;

#pragma mark ss->hh:mm:ss
+ (NSString *)getMMSSFromSS:(NSString *)totalTime;

#pragma mark NSDate转毫秒时间戳
+ (NSInteger)getDateTimeTOMilliSeconds:(NSDate *)datetime;

#pragma mark 时间戳转时间
+ (NSString*)timeSpToTime:(NSString*)timeSp WithFormatter:(NSString*)timeFormatter;

#pragma mark  年龄计算
+ (NSString*)calculateAge:(NSString*)birthDayStr;

#pragma mark 时间差计算
+ (NSDateComponents*)timeDifferenceBetweenStartDate:(NSDate*)startDate endDate:(NSDate*)endDate;

+ (NSString *)timeFormateFromDetailsToNomalWithString:(NSString *)detailsStr;

/**
 *  将若干view等宽布局于容器containerView中
 *
 *  @param views         viewArray
 *  @param containerView 容器view
 *  @param LRpadding     距容器的左右边距
 *  @param viewPadding   各view的左右边距
 */
+ (void)makeEqualWidthViews:(NSArray *)views inView:(UIView *)containerView LRpadding:(CGFloat)LRpadding viewPadding :(CGFloat)viewPadding;

/**
 为控件创建局部圆角
 
 @param corners 需圆角位置
 @param radii 半径
 @param target 圆角对象
 */
+ (void)cornerRadiusForCorners:(UIRectCorner)corners withRadii:(CGFloat)radii target:(UIView*)target;

/*通过通知对textField输入字数做限制*/
+ (void)textFiledEditChanged:(NSNotification *)obj maxLength:(NSInteger)maxLength;

/**
 限制输入框内字符输入最大数量
 */
+ (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string maxTextLength:(NSInteger)maxTextLength;

/**
 提示框

 @param title 标题
 @param message 信息
 @param cancelTitle 取消按钮（不传入该参数则只显示确认按钮）
 @param confirmTitle 确认按钮
 @param confirmlHandler 确认回调
 @param cancelHandler 取消回调
 */
+(void)alertWithTitle:(NSString*_Nullable)title message:(NSString*_Nullable)message cancelTitle:(NSString*_Nullable)cancelTitle confirmTitle:(NSString*_Nullable)confirmTitle confirmlHandler:(void (^ __nullable)(UIAlertAction * _Nullable action))confirmlHandler cancelHandler:(void (^ __nullable)(UIAlertAction * _Nullable action))cancelHandler;

/**
 带输入框的弹窗
 
 @param title 标题
 @param message 信息
 @param placeHolder placeHolder
 @param confirmlHandler 回调
 */
+(void)textfieldAlertWithTitle:(NSString*_Nullable)title
                       message:(NSString*_Nullable)message
                   placeHolder:(NSString*)placeHolder
               confirmlHandler:(void (^ __nullable)(NSString * _Nullable textFieldText))confirmlHandler;
@end
