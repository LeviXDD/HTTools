//
//  HTPopUpView.m
//  LiHaiTao
//
//  Created by Levi on 2018/6/25.
//  Copyright © 2018 Levi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HTPopUpView : UIView

typedef void(^dismissBlock)(BOOL finished);

@property (nonatomic, copy) dismissBlock dismissBlock;

/**
 用于放置展示要弹出的视图
 */
@property (strong, nonatomic) UIView *popBackView;


/**
 弹出动画
 */
-(void)showPopView;


/**
 消失动画
 */
- (void)dismiss;
@end
