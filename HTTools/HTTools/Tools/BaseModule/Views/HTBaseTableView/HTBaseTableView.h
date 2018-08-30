//
//  HTBaseTableView.h
//  HT
//
//  Created by 海涛 黎 on 17/5/30.
//  Copyright © 2017年 海涛 黎. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HTBaseTableView;

@protocol HTBaseTableViewDelegate<NSObject>
@optional
- (void)ht_tableViewDelegateRefresh:(HTBaseTableView*_Nullable)tableView;

- (void)ht_tableViewDelegateLoadMoreData:(HTBaseTableView*_Nullable)tableView;

@optional
-(NSString*_Nullable)ht_descriptionForEmptyDataSet:(UIScrollView*_Nullable)scrollView;
-(NSString*_Nullable)ht_buttonTitleForEmptyDataSet:(HTBaseTableView*_Nonnull)tableView forState:(UIControlState)state;
-(void)ht_emptyDataSetDidTapView:(HTBaseTableView*_Nullable)tableView;
@end

@interface HTBaseTableView : UITableView
/**
 是否允许下拉刷新
 */
@property(nonatomic,assign)BOOL canRefresh;

/**
 是否允许上拉刷新
 */
@property(nonatomic,assign)BOOL canLoadMoreData;

/**
 是否允许展示空数据状态
 */
@property(nonatomic,assign)BOOL canShowNoDataView;

/**
 无更多数据时的描述内容
 */
@property(nonatomic, strong) NSString * _Nullable noMoreDataDescription;

/**
 加载更多数据时的描述内容
 */
@property(nonatomic, strong) NSString * _Nullable loadMoreDataDescription;

/**
 刷新状态时的描述内容
 */
@property(nonatomic, strong) NSString * _Nullable refreshingDataDescription;

@property (nonatomic, weak, nullable) id <HTBaseTableViewDelegate> baseDelegate;

/**
 初始化（分割线样式）
 */
- (instancetype)initWithSingleLineStyle;

/**
 开始下拉刷新
 */
- (void)beginRefresh;

/**
 底部刷新空间展示无更多数据状态
 */
- (void)endRefreshingWithNoMoreData;

/**
 获取顶部刷新状态

 @return 是否在刷新状态
 */
-(BOOL)headerIsRefresh;

/**
 获取底部刷新状态
 
 @return 是否在刷新状态
 */
-(BOOL)footerIsRefresh;

/**
 结束下拉刷新状态
 */
- (void)endHeaderRefresh;

/**
 上拉加载更多完毕
 */
- (void)endFooterRefresh;

- (void)resetNoMoreData;

@end
