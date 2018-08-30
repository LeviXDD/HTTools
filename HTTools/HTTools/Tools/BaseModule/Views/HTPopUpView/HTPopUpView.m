//
//  HTPopUpView.m
//  LiHaiTao
//
//  Created by Levi on 2018/6/25.
//  Copyright © 2018 Levi. All rights reserved.
//

#import "HTPopUpView.h"

@interface HTPopUpView()
@property (nonatomic, strong) UIView *backView;
@end

@implementation HTPopUpView
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        self.backgroundColor = [UIColor clearColor];
        [self createViews];
        [self layoutSettings];
    }
    return self;
}

-(void)createViews{
    [self addSubview:self.backView];
    [self addSubview:self.popBackView];
}

-(void)layoutSettings{
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];
}

-(void)showPopView{
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    [UIView animateWithDuration:0.3 animations:^{
        self.backView.backgroundColor = [UIColor hx_colorWithHexString:@"#000000" alpha:0.6];
        self.popBackView.top = SCREEN_HEIGHT-self.popBackView.height;
    } completion:^(BOOL finished) {
    }];
}

- (void)dismiss{
    [UIView animateWithDuration:0.2 animations:^{
        self.backView.backgroundColor = [UIColor hx_colorWithHexString:@"#000000" alpha:0.0];
        self.popBackView.top = SCREEN_HEIGHT;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        if (self.dismissBlock) {
            self.dismissBlock(finished);
        }
    }];
}

#pragma mark - Target Method

#pragma mark - Notification Mehtod

#pragma mark - Setters

#pragma mark - Getters
-(UIView *)popBackView{
    if (!_popBackView) {
        _popBackView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 0)];
    }
    return _popBackView;
}

-(UIView *)backView{
    if (!_backView) {
        _backView = [[UIView alloc] init];
        _backView.backgroundColor = [UIColor clearColor];
        [_backView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)]];
    }
    return _backView;
}
@end
