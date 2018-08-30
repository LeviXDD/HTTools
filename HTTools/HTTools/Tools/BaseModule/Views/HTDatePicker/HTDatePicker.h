//
//  HTDatePicker.h
//  WorkNet
//
//  Created by 海涛 黎 on 2018/7/7.
//  Copyright © 2018年 LiangZi. All rights reserved.
//

#import "HTPopUpView.h"

@interface HTDatePicker : HTPopUpView

+(HTDatePicker*)showDatePicker:(void(^)(NSDate *selectedDate))selectedBlock;

@property (nonatomic, strong) NSDate *maxDate;
@end
