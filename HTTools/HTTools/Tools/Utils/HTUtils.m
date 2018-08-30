//
//  HTUtils.m
//  黎海涛
//
//  Created by dm on 16/3/30.
//  Copyright © 2016年 taigu. All rights reserved.
//

#import "HTUtils.h"
#import "MBProgressHUD.h"
#define XZRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16)) / 255.0 green:((float)((rgbValue & 0xFF00) >> 8)) / 255.0 blue:((float)(rgbValue & 0xFF)) / 255.0 alpha:1.0]

@implementation HTUtils
#pragma mark - 手机号/密码校验
+ (BOOL)phoneNumberCheck:(NSString*)phoneNumber{
    return phoneNumber.length == 11;
}
+ (BOOL)passWordCheck:(NSString*)passWord{
    return (passWord.length >= 6 && passWord.length <= 16);
}

+ (BOOL)codeCheck:(NSString*)code{
    return code.length == 6;
}

+(BOOL)emailCheck:(NSString*)email{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

+ (BOOL)nickName:(NSString*)nickName{
    NSString *      regex = @"^[a-zA-Z0-9\u4e00-\u9fa5_-]+$";
    NSPredicate *   pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [pred evaluateWithObject:nickName];
}
/*!
 @author DM, 16-03-30 14:03:11
 
 @brief   UIView * vline = [[UIView alloc] initWithFrame:CGRectMake(0,10,0.5,40)];
 vline.center = topView.center;
 vline.backgroundColor = [UIColor grayColor];
 [topView addSubview:vline];
 
 */

/*生成随机整数
 *包括from 包括to
 */
+ (NSInteger)randomIntegerFrom:(NSInteger)from to:(NSInteger)to{
     return (NSInteger)(from + (arc4random() % (to - from + 1)));
}

+ (CGSize)sizeString:(NSString *)string font:(UIFont *)font
{
    CGRect rect = [string boundingRectWithSize:CGSizeMake(MAXFLOAT,MAXFLOAT)
                                       options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesFontLeading  |NSStringDrawingUsesLineFragmentOrigin
                                    attributes:@{NSFontAttributeName:font}
                                       context:nil];
    
    return rect.size;
}

+ (UIColor *) randomColor
{
    CGFloat hue = ( arc4random() % 256 / 256.0 ); //0.0 to 1.0
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5; // 0.5 to 1.0,away from white
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5; //0.5 to 1.0,away from black
    return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
}

+ (UIViewController*) currentViewController {
    // Find best view controller
    UIViewController* viewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    return [self findBestViewController:viewController];
}


/**
 获取当前TabbarControoler上某个位置的控制器

 @param index 位置
 @return controller
 */
+ (UIViewController*)viewControllerAtIndexOfTabbar:(NSInteger)index{
    UIViewController *currentVc = [HTUtils currentViewController];
    UITabBarController *currentTab = currentVc.tabBarController;
    NSArray *vcs = currentTab.viewControllers;
    id wannaVc = vcs[index];
    if ([wannaVc isKindOfClass:[UINavigationController class]]) {
        UINavigationController *nav = (UINavigationController*)wannaVc;
        return nav.topViewController;
    } else if ([wannaVc isKindOfClass:[UIViewController class]]) {
        return wannaVc;
    } else {
        return nil;
    }
}

+ (UIViewController*) findBestViewController:(UIViewController*)vc {
    if (vc.presentedViewController) {
        // Return presented view controller
        return [self findBestViewController:vc.presentedViewController];
    } else if ([vc isKindOfClass:[UISplitViewController class]]) {
        // Return right hand side
        UISplitViewController* svc = (UISplitViewController*) vc;
        if (svc.viewControllers.count > 0)
            return [self findBestViewController:svc.viewControllers.lastObject];
        else
            return vc;
    } else if ([vc isKindOfClass:[UINavigationController class]]) {
        
        // Return top view
        UINavigationController* svc = (UINavigationController*) vc;
        if (svc.viewControllers.count > 0)
            return [self findBestViewController:svc.topViewController];
        else
            return vc;
    } else if ([vc isKindOfClass:[UITabBarController class]]) {
        
        // Return visible view
        UITabBarController* svc = (UITabBarController*) vc;
        if (svc.viewControllers.count > 0)
            return [self findBestViewController:svc.selectedViewController];
        else
            return vc;
    } else {
        return vc;
    }
}

#pragma mark - 跳转到指定页面
+ (void)popToViewController:(Class)controllerClass{
    if (controllerClass == nil) {
        [[HTUtils currentViewController].navigationController popToRootViewControllerAnimated:YES];
        return;
    }
    NSMutableArray *vcArr = [NSMutableArray array];
    for (UIViewController *vc in [HTUtils currentViewController].navigationController.viewControllers) {
        if ([vc isKindOfClass:controllerClass]) {
            [vcArr addObject:vc];
        }
    }
    if (vcArr.count > 0) {
        UIViewController *vc = vcArr.firstObject;
        [[HTUtils currentViewController].navigationController popToViewController:vc animated:YES];
    } else {
        [[HTUtils currentViewController].navigationController popToRootViewControllerAnimated:YES];
    }
}

//字符串相关操作
#pragma mark - 去除字符串两边空格
+ (NSString*)removeAllSpaceCharacterInString:(NSString*)string{
    return [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}

#pragma mark - 时间格式转换
/*date -> string*/
+ (NSString*)dateToString:(NSDate*)date format:(NSString*)format{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    dateFormat.dateFormat = format;
    NSString *string = [dateFormat stringFromDate:date];
    return string;
}

#pragma mark NSDate转毫秒时间戳
+ (NSInteger)getDateTimeTOMilliSeconds:(NSDate *)datetime
{
    NSTimeInterval interval = [datetime timeIntervalSince1970];
    NSLog(@"转换的时间戳=%f",interval);
    NSInteger totalMilliseconds = interval*1000 ;
    NSLog(@"totalMilliseconds=%llu",totalMilliseconds);
    return totalMilliseconds;
}

#pragma mark 时间戳转时间
+ (NSString*)timeSpToTime:(NSString*)timeSp WithFormatter:(NSString*)timeFormatter{
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[timeSp doubleValue]/1000.];
    NSLog(@"1296035591  = %@",confromTimesp);
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:timeFormatter];
    NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];
    return confromTimespStr;
}
#pragma mark -- string 转 date
//NSString转NSDate
+ (NSDate *)dateFromString:(NSString *)string
{
    //设置转换格式
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    [formatter setDateFormat:yyyy_MM_dd_HH_mm_ss];
    //NSString转NSDate
    NSDate *date=[formatter dateFromString:string];
    return date;
}

#pragma mark 时间差计算
+ (NSDateComponents*)timeDifferenceBetweenStartDate:(NSDate*)startDate endDate:(NSDate*)endDate{
    // 当前日历
    NSCalendar *calendar = [NSCalendar currentCalendar];
    // 需要对比的时间数据
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth
    | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    // 对比时间差
    NSDateComponents *dateCom = [calendar components:unit fromDate:startDate toDate:endDate options:0];
    return dateCom;
}

//url参数编码
+ (NSString *)encodeParameter:(NSString *)originalPara {
    if (STRING_ISNIL(originalPara)) {
        return @"";
    }
    CFStringRef encodeParaCf = CFURLCreateStringByAddingPercentEscapes(NULL, (__bridge CFStringRef)originalPara, NULL, CFSTR("!*'();:@&=+$,/?%#[]"), kCFStringEncodingUTF8);
    NSString *encodePara = (__bridge NSString *)(encodeParaCf);
    CFRelease(encodeParaCf);
    return encodePara;
}

// 日期转周几
+ (NSString *)getWeekDayFordate:(long long)data
{
    NSArray *weekday = [NSArray arrayWithObjects: [NSNull null], @"周日", @"周一", @"周二", @"周三", @"周四", @"周五", @"周六", nil];
    NSDate *newDate = [NSDate dateWithTimeIntervalSince1970:data];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierChinese];
    NSDateComponents *components = [calendar components:NSCalendarUnitWeekday fromDate:newDate];
    NSString *weekStr = [weekday objectAtIndex:components.weekday];
    return weekStr;
}

#pragma mark - 年龄计算
+ (NSString*)calculateAge:(NSString*)birthDayStr{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    //生日
    NSDate *birthDay = [dateFormatter dateFromString:birthDayStr];
    //当前时间
    NSString *currentDateStr = [dateFormatter stringFromDate:[NSDate date]];
    NSDate *currentDate = [dateFormatter dateFromString:currentDateStr];
    NSTimeInterval time=[currentDate timeIntervalSinceDate:birthDay];
    int age = ((int)time)/(3600*24*365);
    if (age == 0) {
        age = 1;
    }
    return [NSString stringWithFormat:@"%d",age];
}

/**
 *  将若干view等宽布局于容器containerView中
 *
 *  @param views         viewArray
 *  @param containerView 容器view
 *  @param LRpadding     距容器的左右边距
 *  @param viewPadding   各view的左右边距
 */
+ (void)makeEqualWidthViews:(NSArray *)views inView:(UIView *)containerView LRpadding:(CGFloat)LRpadding viewPadding :(CGFloat)viewPadding
{
    UIView *lastView;
    for (UIView *view in views) {
        [containerView addSubview:view];
        if (lastView) {
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.bottom.equalTo(containerView);
                make.left.equalTo(lastView.mas_right).offset(viewPadding);
                make.width.equalTo(lastView);
            }];
        }else
        {
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(containerView).offset(LRpadding);
                make.top.bottom.equalTo(containerView);
            }];
        }
        lastView=view;
    }
    [lastView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(containerView).offset(-LRpadding);
    }];
}

/**
 为控件创建局部圆角

 @param corners 需圆角位置
 @param radii 半径
 @param target 圆角对象
 */
+ (void)cornerRadiusForCorners:(UIRectCorner)corners withRadii:(CGFloat)radii target:(UIView*)target{
    UIBezierPath *pswMaskPath = [UIBezierPath bezierPathWithRoundedRect:target.bounds byRoundingCorners:corners cornerRadii:CGSizeMake(radii, radii)];
    CAShapeLayer *pswMaskLayer = [[CAShapeLayer alloc] init];
    pswMaskLayer.frame = target.bounds;
    pswMaskLayer.path = pswMaskPath.CGPath;
    target.layer.mask = pswMaskLayer;
}

/*通过通知对textField输入字数做限制*/
+ (void)textFiledEditChanged:(NSNotification *)obj maxLength:(NSInteger)maxLength{
    UITextField *textField = (UITextField *)obj.object;
    NSString *toBeString = textField.text;
    NSString *lang = [textField.textInputMode primaryLanguage];
    if ([lang isEqualToString:@"zh-Hans"])// 简体中文输入
    {
        //获取高亮部分
        UITextRange *selectedRange = [textField markedTextRange];
        UITextPosition *position = [textField positionFromPosition:selectedRange.start offset:0];
        
        // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
        if (!position)
        {
            if (toBeString.length > maxLength)
            {
                textField.text = [toBeString substringToIndex:maxLength];
            }
        }
        
    }
    // 中文输入法以外的直接对其统计限制即可，不考虑其他语种情况
    else
    {
        if (toBeString.length > maxLength)
        {
            NSRange rangeIndex = [toBeString rangeOfComposedCharacterSequenceAtIndex:maxLength];
            if (rangeIndex.length == 1)
            {
                textField.text = [toBeString substringToIndex:maxLength];
            }
            else
            {
                NSRange rangeRange = [toBeString rangeOfComposedCharacterSequencesForRange:NSMakeRange(0, maxLength)];
                textField.text = [toBeString substringWithRange:rangeRange];
            }
        }
    }
}

/**
 限制输入框内字符输入最大数量
 */
+ (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string maxTextLength:(NSInteger)maxTextLength
{
    UITextRange *selectedRange = [textField markedTextRange];
    //获取高亮部分
    UITextPosition *pos = [textField positionFromPosition:selectedRange.start offset:0];
    //获取高亮部分内容
    //NSString * selectedtext = [textView textInRange:selectedRange];
    
    //如果有高亮且当前字数开始位置小于最大限制时允许输入
    if (selectedRange && pos) {
        NSInteger startOffset = [textField offsetFromPosition:textField.beginningOfDocument toPosition:selectedRange.start];
        NSInteger endOffset = [textField offsetFromPosition:textField.beginningOfDocument toPosition:selectedRange.end];
        NSRange offsetRange = NSMakeRange(startOffset, endOffset - startOffset);
        
        if (offsetRange.location < maxTextLength) {
            return YES;
        }
        else
        {
            return NO;
        }
    }
    
    
    NSString *comcatstr = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    NSInteger caninputlen = maxTextLength - comcatstr.length;
    
    if (caninputlen >= 0)
    {
        return YES;
    }
    else
    {
        NSInteger len = string.length + caninputlen;
        //防止当text.length + caninputlen < 0时，使得rg.length为一个非法最大正数出错
        NSRange rg = {0,MAX(len,0)};
        
        if (rg.length > 0)
        {
            NSString *s = @"";
            //判断是否只普通的字符或asc码(对于中文和表情返回NO)
            BOOL asc = [string canBeConvertedToEncoding:NSASCIIStringEncoding];
            if (asc) {
                s = [string substringWithRange:rg];//因为是ascii码直接取就可以了不会错
            }
            else
            {
                __block NSInteger idx = 0;
                __block NSString  *trimString = @"";//截取出的字串
                //使用字符串遍历，这个方法能准确知道每个emoji是占一个unicode还是两个
                [string enumerateSubstringsInRange:NSMakeRange(0, [string length])
                                         options:NSStringEnumerationByComposedCharacterSequences
                                      usingBlock: ^(NSString* substring, NSRange substringRange, NSRange enclosingRange, BOOL* stop) {
                                          
                                          if (idx >= rg.length) {
                                              *stop = YES; //取出所需要就break，提高效率
                                              return ;
                                          }
                                          
                                          trimString = [trimString stringByAppendingString:substring];
                                          
                                          idx++;
                                      }];
                
                s = trimString;
            }
            //rang是指从当前光标处进行替换处理(注意如果执行此句后面返回的是YES会触发didchange事件)
            [textField setText:[textField.text stringByReplacingCharactersInRange:range withString:s]];
            //既然是超出部分截取了，哪一定是最大限制了。
//            self.countLabel.text = [NSString stringWithFormat:@"%d/%ld",MAX_LIMIT_NUMS,(long)MAX_LIMIT_NUMS];
        }
        return NO;
    }
}

+(void)alertWithTitle:(NSString*_Nullable)title message:(NSString*_Nullable)message cancelTitle:(NSString*_Nullable)cancelTitle confirmTitle:(NSString*_Nullable)confirmTitle confirmlHandler:(void (^ __nullable)(UIAlertAction * _Nullable action))confirmlHandler cancelHandler:(void (^ __nullable)(UIAlertAction * _Nullable action))cancelHandler{
    dispatch_async(dispatch_get_main_queue(), ^{
        UIAlertController *actionAlert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
        
        if (STRING_ISNOTNIL(cancelTitle)) {
            UIAlertAction *dropAction = [UIAlertAction actionWithTitle:cancelTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                if (cancelHandler) {
                    cancelHandler(action);
                }
            }];
            [actionAlert addAction:dropAction];
        }
        
        UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:confirmTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if (confirmlHandler) {
                confirmlHandler(action);
            }
        }];
        [actionAlert addAction:confirmAction];
        [[HTUtils currentViewController] presentViewController:actionAlert animated:YES completion:nil];
    });
}


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
               confirmlHandler:(void (^ __nullable)(NSString * _Nullable textFieldText))confirmlHandler{
    dispatch_async(dispatch_get_main_queue(), ^{
        UIAlertController *actionAlert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
        //取消按钮
        UIAlertAction *dropAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {}];
        [actionAlert addAction:dropAction];
    
        UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if (confirmlHandler) {
                UITextField *textField = actionAlert.textFields.firstObject;
                confirmlHandler(textField.text);
            }
        }];
        [actionAlert addAction:confirmAction];
    
        [actionAlert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = EMPTY_IF_NIL(placeHolder);
        }];
        [[HTUtils currentViewController] presentViewController:actionAlert animated:YES completion:nil];
    });
}
@end
