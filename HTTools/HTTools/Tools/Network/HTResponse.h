//
//  HTResponse.h
//  HT
//
//  Created by 黎海涛 on 17/3/23.
//  Copyright © 2017年 黎海涛. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, HTResponseType) {
    HTResponseTypeSuccess = 0,//请求成功
    HTResponseTypeError,   //请求错误
    HTResponseTypeRefresh  //登录token过期
};

@interface HTResponse : NSObject

@property (nonatomic, assign) BOOL isSuccess; //接口请求是否成功

@property (nonatomic, assign) HTResponseType responseType;  //错误码()

@property(nonatomic, strong) NSString *responseMsg; //错误信息

@property (nonatomic, assign) NSInteger totalSize;  //列表集合数量

@property (nonatomic, assign) NSInteger currentPage;  //当前所在页

@property(nonatomic, strong) NSArray *list;  //供列表使用数据

@property (nonatomic, strong) id data;  //供页面使用的数据

@property (nonatomic, strong) id responseObject;  //返回的完整信息

-(void)parseDataWithRespon:(id)respon;

@end
