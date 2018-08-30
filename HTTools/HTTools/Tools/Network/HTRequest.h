//
//  HTRequest.h
//  caomall
//
//  Created by 谭康 on 2018/5/19.
//  Copyright © 2018年 Levi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HTRequest : NSObject
//@property (nonatomic, copy, readonly) NSString *deviceIdentifier;
//
//@property (nonatomic, copy, readonly) NSString *version;
//
//@property (nonatomic, copy, readonly) NSString *deviceModel;
//
//@property (nonatomic, copy, readonly) NSString *sdkVersion;
//
//@property (nonatomic, copy, readonly) NSString *screen_width;
//
//@property (nonatomic, copy, readonly) NSString *screen_height;

@property (nonatomic, copy, readonly) NSString *token;

@property (nonatomic, copy, readonly) NSString *uid;

//@property (nonatomic, copy, readonly) NSString *from;

+ (instancetype)requestParams;
@end
