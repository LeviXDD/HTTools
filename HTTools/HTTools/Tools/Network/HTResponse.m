//
//  HTResponse.m
//  HT
//
//  Created by 黎海涛 on 17/3/23.
//  Copyright © 2017年 黎海涛. All rights reserved.
//

#import "HTResponse.h"
//#import "NetworkAPI.h"

#define RESPONSE_OBJECT_KEY @"data"
#define MESSAGE_KEY @"msg"
#define TOTAL_SIZE_KEY @"max_page"
#define CURRENT_PAGE_KEY @"page"
#define DATALIST_KEY @"list"

@implementation HTResponse

-(void)parseDataWithRespon:(id)respon{
    NSDictionary *dic = [NSDictionary dictionary];
    if ([respon isKindOfClass:[NSDictionary class]]) {
        dic = respon;
    } else if ([respon isKindOfClass:[NSData class]]) {
        NSData *strData = respon;
        NSString *nameStr = [strData mj_JSONString];
        NSData *data = [nameStr dataUsingEncoding:NSUTF8StringEncoding];
        dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        NSLog(@"%@",nameStr);
    } else {
        NSAssert(![respon isKindOfClass:[NSDictionary class]]&&![respon isKindOfClass:[NSData class]], @"响应参数格式有误");
    }
    self.responseObject = dic;
    NSString *codeStr = [dic valueForKey:@"code"];
    if ([codeStr isEqualToString:@"SUCCESS"]) {
        self.responseType = HTResponseTypeSuccess;
    }
    if ([codeStr isEqualToString:@"ERROR"]) {
        self.responseType = HTResponseTypeError;
    }
    if ([codeStr isEqualToString:@"REFRESH"]) {
        self.responseType = HTResponseTypeRefresh;
    }
    self.isSuccess = (self.responseType == HTResponseTypeSuccess);
    self.data = [dic valueForKey:RESPONSE_OBJECT_KEY]?:@{};
    self.responseMsg = EMPTY_IF_NIL([dic valueForKey:MESSAGE_KEY]);
    if ([self.data isKindOfClass:[NSDictionary class]]) {
        if ([[self.data allKeys] containsObject:TOTAL_SIZE_KEY]){  //总页数
            self.totalSize = [EMPTY_IF_NIL([self.data objectForKey:TOTAL_SIZE_KEY]) integerValue];
        }
        if ([[self.data allKeys] containsObject:CURRENT_PAGE_KEY]){ //当前页码
            self.currentPage = [EMPTY_IF_NIL([self.data objectForKey:CURRENT_PAGE_KEY]) integerValue];
        }
        if ([[self.data allKeys] containsObject:DATALIST_KEY]){  //数据列表
            self.list = [self.data objectForKey:DATALIST_KEY];
        }
    }
    
    if (IsNilOrNull(self.data)) {
        self.data = nil;
    }

}
@end
