//
//  QuickToolsDefine.h
//  caomall
//
//  Created by 谭康 on 2018/5/11.
//  Copyright © 2018年 Levi. All rights reserved.
//

#ifndef QuickToolsDefine_h
#define QuickToolsDefine_h

#define HEXCOLOR(c) [UIColor colorWithRed:((c>>24)&0xFF)/255.0 green:((c>>16)&0xFF)/255.0 blue:((c>>8)&0xFF)/255.0 alpha:((c)&0xFF)/255.0]

//word
#define WORD_COLOR_BLACK [UIColor hx_colorWithHexString:@"#333333"]
#define WORD_COLOR_GRAY [UIColor hx_colorWithHexString:@"#666666"]
#define WORD_COLOR_LIGHTGRAY [UIColor hx_colorWithHexString:@"#999999"]

//bg
#define MAIN_BG_COLOR HEXCOLOR(0xf7f7f7ff)
#define MAIN_COLOR [UIColor hx_colorWithHexString:@"#0081FE"]

//font
#define Font(c) [UIFont fontWithName:kPingFangSC_Regular size:c]
#define BoldFont(c) [UIFont fontWithName:kPingFangSC_Medium size:c]

//手机型号判断
#define IS_IPHONE_4_OR_LESS (IS_IPHONE && SCREEN_MAX_LENGTH < 568.0)
#define IS_IPHONE_5 (IS_IPHONE && SCREEN_MAX_LENGTH == 568.0)
#define IS_IPHONE_6 (IS_IPHONE && SCREEN_MAX_LENGTH == 667.0)
#define IS_IPHONE_6P (IS_IPHONE && SCREEN_MAX_LENGTH == 736.0)
#define IS_IPHONE_X (IS_IPHONE && SCREEN_MAX_LENGTH == 812.0)

/* 判定字符串是否为空 */
#define STRING_ISNIL(__POINTER) (__POINTER == nil || [__POINTER isEqualToString:@""] || [__POINTER isEqualToString:@"(null)"] || [__POINTER isEqualToString:@"null"] || [__POINTER isEqualToString:@"(NULL)"] || [__POINTER isEqualToString:@"NULL"] || [__POINTER isEqualToString:@"<null>"])?YES:NO

/* 判定字符串是否不为空 */
#define STRING_ISNOTNIL(__POINTER) (__POINTER == nil || [__POINTER isEqualToString:@""] || [__POINTER isEqualToString:@"(null)"] || [__POINTER isEqualToString:@"null"]|| [__POINTER isEqualToString:@"(NULL)"] || [__POINTER isEqualToString:@"NULL"] || [__POINTER isEqualToString:@"<null>"] || __POINTER == NULL || [__POINTER isKindOfClass:[NSNull class]] || [[__POINTER stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0)?NO:YES

//字符串空字符处理
#define EMPTY_IF_NIL(str) (str == nil ? @"" : (str == (id)[NSNull null] ? @"" : str))

//空对象处理
#define IsNilOrNull(_ref)   (((_ref) == nil) || ([(_ref) isEqual:[NSNull null]]))

#ifndef weakify
#if DEBUG
#if __has_feature(objc_arc)
#define weakify(object) autoreleasepool{} __weak __typeof__(object) weak##_##object = object;
#else
#define weakify(object) autoreleasepool{} __block __typeof__(object) block##_##object = object;
#endif
#else
#if __has_feature(objc_arc)
#define weakify(object) try{} @finally{} {} __weak __typeof__(object) weak##_##object = object;
#else
#define weakify(object) try{} @finally{} {} __block __typeof__(object) block##_##object = object;
#endif
#endif
#endif

#ifndef strongify
#if DEBUG
#if __has_feature(objc_arc)
#define strongify(object) autoreleasepool{} __typeof__(object) object = weak##_##object;
#else
#define strongify(object) autoreleasepool{} __typeof__(object) object = block##_##object;
#endif
#else
#if __has_feature(objc_arc)
#define strongify(object) try{} @finally{} __typeof__(object) object = weak##_##object;
#else
#define strongify(object) try{} @finally{} __typeof__(object) object = block##_##object;
#endif
#endif
#endif

//weakSelf
#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;

#endif /* QuickToolsDefine_h */
