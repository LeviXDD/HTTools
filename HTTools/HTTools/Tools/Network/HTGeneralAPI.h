//
//  HTGeneralAPI.h
//  HT
//
//  Created by 黎海涛 on 17/3/23.
//  Copyright © 2017年 黎海涛. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "HTResponse.h"

@class HTGeneralAPI;

typedef void(^HTGeneralAPISuccessBlock)(HTGeneralAPI * change,NSError * error);
typedef void(^HTGeneralAPIFailBlock)(HTGeneralAPI * change,NSError * error);
typedef void(^HTGeneralAPIProgressBlock)(float progress);

typedef enum : NSUInteger{
    HTGeneralAPIStateWaiting,
    HTGeneralAPIStateInProgress,
    HTGeneralAPIStateFinished,
    HTGeneralAPIStateFail
}HTGeneralAPIState;

typedef enum {
    HTGeneralAPIMethodTypeGet,
    HTGeneralAPIMethodTypePost,
    HTGeneralAPIMethodTypeDelete,
    HTGeneralAPIMethodTypePut,
    HTGeneralAPIMethodTypeFileUpload,
    HTGeneralAPIMethodPutTypeFileDownload
}HTGeneralAPIMethodType;



@interface HTGeneralAPI : NSObject
/**
 是否需要显示报错信息
 */
@property(nonatomic, assign) BOOL showErrorMessage;

/**
 是否需要显示菊花
 */
@property(nonatomic, assign) BOOL showProgress;

/**
 是否需要显示错误信息
 */
@property(nonatomic, assign) BOOL shouldShowErrDesc;

/**
 所需服务
 */
@property(nonatomic, copy) NSString *service;

/**
 服务所属模块
 */
@property(nonatomic, copy) NSString *module;

/**
 请求参数
 */
@property(nonatomic, strong) NSDictionary *params;

/**
 请求方法
 */
@property(nonatomic, assign) HTGeneralAPIMethodType method;

/**
 请求成功返回参数
 */
@property(nonatomic, strong) HTResponse * responseObject;

/**
 当前请求状态
 */
@property(nonatomic, assign, readonly) HTGeneralAPIState state;

/**
 要上传的文件
 */
@property (nonatomic, strong) NSArray *uploadFiles;

/**
 要上传的文件名
 */
@property (nonatomic, strong) NSArray<NSString*> *uploadFileNames;

/**
 要上传的文件名对应key
 */
@property (nonatomic, strong) NSArray <NSString*> *uploadFileKeyNames;

/**
 发起请求

 @param successBlock 成功回调
 @param failBlock 失败回调
 @return 请求任务实例
 */
-(NSURLSessionDataTask *)doServiceSuccessBlock:(HTGeneralAPISuccessBlock)successBlock failBlock:(HTGeneralAPIFailBlock)failBlock;
@end
