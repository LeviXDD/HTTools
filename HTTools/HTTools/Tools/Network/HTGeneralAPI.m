	//
//  HTGeneralAPI.m
//  HT
//
//  Created by 黎海涛 on 17/3/23.
//  Copyright © 2017年 黎海涛. All rights reserved.
//


#import "HTGeneralAPI.h"
#import "AFHTTPSessionManager.h"
#import "PDNetworkStatusManager.h"
#import "HTToast.h"
#import <sys/utsname.h>
#import "HTNetWorkApiDefine.h"
#import "HTRequest.h"

@interface HTGeneralAPI()
@property (nonatomic, strong) AFHTTPSessionManager *networkManager;
@property (nonatomic, strong) NSString *serviceUrl;
@end

@implementation HTGeneralAPI

-(instancetype)init{
    if(self = [super init])
    {
        self.responseObject = [[HTResponse alloc] init];
    }
    return   self;
}

-(NSURLSessionDataTask *)doServiceSuccessBlock:(HTGeneralAPISuccessBlock)successBlock failBlock:(HTGeneralAPIFailBlock)failBlock{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;

    
    if ([PDNetworkStatusManager netWorkState] == PDNetworkStatusNotReachable || [PDNetworkStatusManager netWorkState] == PDNetworkStatusUnknown) {
        [HTToast showMessage:@"网络暂时开小差儿，请检查网络连接，再试试。"];
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        failBlock(self,nil);
        return nil;
    }
    
    if (self.showProgress) {
        [HTToast showProgress];
    }
    
    switch (self.method) {
        case HTGeneralAPIMethodTypeGet:
        {
            return [self.networkManager GET:self.serviceUrl parameters:self.params progress:^(NSProgress * _Nonnull downloadProgress) {} success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                [self taskSuccessWithTask:task responseObject:responseObject];
                if (responseObject) {
                    successBlock(self,nil);
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                [self taskFailureWithTask:task error:error];
                failBlock(self,error);
            }];
        }
            break;
            
        case HTGeneralAPIMethodTypePost:
        {
            return [self.networkManager POST:self.serviceUrl parameters:self.params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                [self taskSuccessWithTask:task responseObject:responseObject];
               
                    if (responseObject) {
                        successBlock(self,nil);
                    }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                [self taskFailureWithTask:task error:error];
                failBlock(self,error);
            }];
        }
            break;
            
        case HTGeneralAPIMethodTypeFileUpload:
        {
            return [self.networkManager POST:self.serviceUrl parameters:self.params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
                for (NSInteger index = 0; index < self.uploadFiles.count; index++) {
                    id uploadFile = [self.uploadFiles objectAtIndexCheck:index];
                    NSString *uploadFileName = [self.uploadFileNames objectAtIndexCheck:index];
                    NSString *uploadFileKeyName = [self.uploadFileKeyNames objectAtIndexCheck:index];
                    
                    if ([uploadFile isKindOfClass:[UIImage class]]) {
                        UIImage *eachImg = uploadFile;
                        NSData *eachImgData = UIImageJPEGRepresentation(eachImg, 0.1);
                        [formData appendPartWithFileData:eachImgData name:uploadFileKeyName fileName:uploadFileName mimeType:@"image/png"];
                    }
                }
            } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                [self taskSuccessWithTask:task responseObject:responseObject];
                if (responseObject) {
                    successBlock(self,nil);
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                [self taskFailureWithTask:task error:error];
                failBlock(self,error);
            }];
        }
            break;
            
        default:
            return nil;
            break;
    }
}

#pragma mark - Private Methods

/**
 请求成功

 @param task NSURLSessionDataTask
 @param responseObject 请求返回内容
 */
-(void)taskSuccessWithTask:(NSURLSessionDataTask*)task responseObject:(id)responseObject{
    if (self.showProgress) {
        [HTToast hideProgress];
    }
    [self logTask:task andMsg:responseObject];
    if (responseObject) {
        [self.responseObject parseDataWithRespon:responseObject];
        self.state = HTGeneralAPIStateFinished;
        BOOL noSuccess = !self.responseObject.isSuccess;
        BOOL isRespNotMsgNil =  STRING_ISNOTNIL(self.responseObject.responseMsg);
        BOOL shouldShowErrorMsg = noSuccess&&isRespNotMsgNil&&self.showErrorMessage;
        if (shouldShowErrorMsg) {
            [HTToast showMessage:EMPTY_IF_NIL(self.responseObject.responseMsg)];
        }
    }
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

/**
 请求失败
 
 @param task NSURLSessionDataTask
 @param error 请求错误内容
 */
-(void)taskFailureWithTask:(NSURLSessionDataTask*)task error:(NSError*)error{
    if (self.showProgress) {
        [HTToast hideProgress];
    }
    [self logTask:task andMsg:nil];
    self.state = HTGeneralAPIStateFail;
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
//    [HTToast showMessage:@"好像出了点问题，稍后再试"];
}


/**
 打印请求信息

 @param task task
 @param responseDic 请求返回内容
 */
-(void)logTask:(NSURLSessionDataTask *)task andMsg:(id)responseDic{
    NSString * body;
    NSURLRequest *request = task.originalRequest;
    if ([request HTTPBody]) {
        body = [[NSString alloc] initWithData:[request HTTPBody] encoding:NSUTF8StringEncoding];
    }
    NSLog(@"请求打印信息:\n---------------%@?%@----------", [task.currentRequest URL].absoluteString,body);
    if (!IsNilOrNull(responseDic) && [responseDic isKindOfClass:[NSDictionary class]]) {
        NSLog(@"成功返回信息:\n%@",[(NSDictionary*)responseDic objectForKey:@"msg"]);
    }
}

#pragma mark - Getters
-(AFHTTPSessionManager *)networkManager{
    if (!_networkManager) {
        AFHTTPSessionManager *sessionManager = [AFHTTPSessionManager manager];
       sessionManager.requestSerializer = [AFHTTPRequestSerializer serializer];
        sessionManager.responseSerializer = [AFJSONResponseSerializer serializer];
        sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html",@"text/json", @"text/javascript", nil];
        AFSecurityPolicy *securityPolicy = [[AFSecurityPolicy alloc] init];
        [securityPolicy setAllowInvalidCertificates:YES];
        [sessionManager setSecurityPolicy:securityPolicy];
        _networkManager = sessionManager;
    }
    return _networkManager;
}

-(void)setState:(HTGeneralAPIState)state{
    _state = state;
}

#pragma mark - Getters
-(NSString *)serviceUrl{
    if (!_serviceUrl) {
        _serviceUrl = [NSString stringWithFormat:@"%@/%@/%@",BASE_URL,self.module,self.service];
    }
    return _serviceUrl;
}

-(NSDictionary *)params{
    if (!_params) {
        _params = [NSDictionary dictionary];
    }
    
    NSMutableDictionary *fullParam;
    fullParam = [NSMutableDictionary dictionaryWithDictionary:[HTRequest requestParams].mj_keyValues];
    if ([_params isKindOfClass:[NSDictionary class]]){//字典类入参
        [fullParam addEntriesFromDictionary:_params];
    }
    return fullParam;
}
@end
