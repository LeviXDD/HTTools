//
//  BaseViewController.h
//  Channel
//
//  Created by user on 16/2/22.
//  Copyright © 2016年 ruanxianxiang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, HTNavgationBarType) {
    HTNavgationBarTypeNoraml = 0,
    HTNavgationBarTypeClear  = 1,
};

@interface BaseViewController : UIViewController
/**
 *  VIEW是否渗透导航栏
 * (YES_VIEW渗透导航栏下／NO_VIEW不渗透导航栏下)
 */
@property (assign,nonatomic) BOOL isExtendLayout;

/**
 *  是否需要显示导航栏
 * (YES_显示／NO_不显示)
 */
@property(nonatomic, assign) BOOL isShowNavigationgBar;  //默认YES

@property(nonatomic, assign) HTNavgationBarType navType;

/**
 移除导航控制器堆栈中的某些控制器
 
 @param controllers 要移除的控制器数组（元素为要移除控制器的类名）
 */
-(void)removeControllers:(NSArray<NSString*>*)controllers;

/**
 Push方法
 
 @param controller <#controller description#>
 @param animated <#animated description#>
 @param block <#block description#>
 */
-(void)pushViewController:(UIViewController*)controller animated:(BOOL)animated complete:(void (^)(BOOL finished))block;
@end
