//
//  HTRequest.m
//  caomall
//
//  Created by 谭康 on 2018/5/19.
//  Copyright © 2018年 Levi. All rights reserved.
//

#import "HTRequest.h"

@implementation HTRequest
- (instancetype)init {
    self = [super init];
    if (self) {
//        _deviceIdentifier = [[UIDevice currentDevice].identifierForVendor UUIDString];
//        _version = [[[NSBundle mainBundle] infoDictionary] valueForKey:@"CFBundleVersion"];
//        _deviceModel = [UIDevice currentDevice].model;
//        _sdkVersion = [UIDevice currentDevice].systemVersion;
//        _screen_width = [NSString stringWithFormat:@"%f", SCREEN_WIDTH];
//        _screen_height = [NSString stringWithFormat:@"%f", SCREEN_HEIGHT];
//        NSString *token = [LZUserManager shareInstance].user.token;
//        _token = token.length > 0 ? token : @"";
//        _uid = EMPTY_IF_NIL(USER_UID);
//        _from = @"ios";
    }
    return self;
}

+ (instancetype)requestParams {
    return [[self alloc] init];
}

@end
