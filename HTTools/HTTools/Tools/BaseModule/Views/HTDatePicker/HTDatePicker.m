//
//  HTDatePicker.m
//  WorkNet
//
//  Created by 海涛 黎 on 2018/7/7.
//  Copyright © 2018年 LiangZi. All rights reserved.
//

#import "HTDatePicker.h"
#import "PGDatePicker.h"

typedef void(^selectedBlock)(NSDate *selectedDate);

@interface HTDatePicker()
@property(nonatomic, copy) selectedBlock selectedBlock;
//UI
@property(nonatomic, strong) UIView *buttonBackView;
@property(nonatomic, strong) UIButton *cancelButton;
@property(nonatomic, strong) UIButton *confirmButton;
@property(nonatomic, strong) PGDatePicker *datePicker;
@end

@implementation HTDatePicker
+(HTDatePicker*)showDatePicker:(void (^)(NSDate *selectedDate))selectedBlock{
    HTDatePicker *picker = [[HTDatePicker alloc] init];
    picker.selectedBlock = selectedBlock;
    [picker showPopView];
    return picker;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.popBackView.height = self.buttonBackView.height+self.datePicker.height;
        [self.popBackView addSubview:self.buttonBackView];
        [self.popBackView addSubview:self.datePicker];
    }
    return self;
}

-(void)confirmButtonDidClicked:(id)sender{
    [self.datePicker tapSelectedHandler];
}

#pragma mark - Setters
-(void)setMaxDate:(NSDate *)maxDate{
    _maxDate = maxDate;
    self.datePicker.maximumDate = maxDate;
}

#pragma mark - Getters
-(UIView *)buttonBackView{
    if (!_buttonBackView) {
        _buttonBackView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
        _buttonBackView.backgroundColor = [UIColor whiteColor];
        UIView *line = [[UIView alloc] init];
        line.backgroundColor = LINE_COLOR;
        [_buttonBackView addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(self.buttonBackView);
            make.bottom.mas_equalTo(self.buttonBackView.mas_bottom);
            make.height.mas_equalTo(0.5);
        }];
        [_buttonBackView addSubview:self.cancelButton];
        [_buttonBackView addSubview:self.confirmButton];
        [self.cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.buttonBackView.mas_left).offset(16);
            make.height.mas_equalTo(35);
            make.width.mas_equalTo(50);
            make.centerY.mas_equalTo(self.buttonBackView.mas_centerY);
        }];
        [self.confirmButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.buttonBackView.mas_right).offset(-16);
            make.height.mas_equalTo(self.cancelButton.mas_height);
            make.width.mas_equalTo(self.cancelButton.mas_width);
            make.centerY.mas_equalTo(self.buttonBackView.mas_centerY);
        }];
    }
    return _buttonBackView;
}

-(PGDatePicker *)datePicker{
    if (!_datePicker) {
        _datePicker = [[PGDatePicker alloc] initWithFrame:CGRectMake(0, self.buttonBackView.height, SCREEN_WIDTH, 260)];
        _datePicker.backgroundColor = [UIColor whiteColor];
        _datePicker.datePickerMode = PGDatePickerModeYearAndMonth;
        _datePicker.maximumDate = [NSDate date];
        @weakify(self);
        _datePicker.selectedDate = ^(NSDateComponents *dateComponents) {
            @strongify(self);
            if (self.selectedBlock) {
                NSCalendar *gregorian = [[NSCalendar alloc]    initWithCalendarIdentifier:NSGregorianCalendar];
                NSDate *date = [gregorian dateFromComponents:dateComponents];
//                NSDate *date = dateComponents.date;
                self.selectedBlock(date);
            }
            [self dismiss];
        };
    }
    return _datePicker;
}

-(UIButton *)cancelButton{
    if (!_cancelButton) {
        _cancelButton = [HTQuickUITools ht_quickButtonWithTitle:@"取消" titleColor:MAIN_COLOR titleFont:Font(12) tartget:self action:@selector(dismiss) borderColor:MAIN_COLOR];
    }
    return _cancelButton;
}

-(UIButton *)confirmButton{
    if (!_confirmButton) {
        _confirmButton = [HTQuickUITools ht_quickButtonWithTitle:@"确定" titleColor:MAIN_COLOR titleFont:Font(12) tartget:self action:@selector(confirmButtonDidClicked:) borderColor:MAIN_COLOR];
    }
    return _confirmButton;
}
@end
