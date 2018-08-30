//
//  HTBaseTableViewController.m
//  caomall
//
//  Created by 海涛 on 2018/5/11.
//Copyright © 2018年 Levi. All rights reserved.
//

#import "HTBaseTableViewController.h"
// Controllers

// Model

// Views

//Tools

//#define <#macro#> <#value#>


@interface HTBaseTableViewController ()
#pragma mark - Class Variables


@end

#pragma mark - Class Definition
@implementation HTBaseTableViewController
#pragma mark - View Controller LifeCyle
- (void)dealloc
{
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self basicSettings];
    [self createViews];
    [self layoutSettings];
    [self createEvents];
    [self loadData];
}

//页面基本设置
-(void)basicSettings{
}

// 创建页面内控件的地方。
- (void)createViews{
}

//页面控件约束
- (void)layoutSettings{
    //    @weakify(self);
    //    [self.; mas_makeConstraints:^(MASConstraintMaker *make) {
    //        @strongify(self);
    //    }];
}


// 创建页面内控件事件的地方
- (void)createEvents{
}

// 如果页面加载过程需要读取数据, 则写在这个地方。
- (void)loadData
{
    
}

#pragma mark - UITableViewDelegate, UITableViewDataSource

#pragma mark - Privater Methods

#pragma mark - Setter Getter Methods
@end

