////
////  LJBaseCollectionView.h
////  LeJiaYP
////
////  Created by 海涛 黎 on 2017/2/24.
////  Copyright © 2017年 gaodong. All rights reserved.
////
//
//#import <UIKit/UIKit.h>
//#import "CHTCollectionViewWaterfallLayout.h"
//#import "MJRefresh.h"
//@class HTBaseCollectionView;
//
//@protocol HTBaseCollectionViewDelegate<NSObject>
//@required
//- (void)collectionViewDelegateRefresh:(HTBaseCollectionView*)collectionView;
//
//- (void)collectionViewDelegateLoadMoreData:(HTBaseCollectionView*)collectionView;
//
////-(void)test;
//- (UIView *)baseCollectionViewForEmptyDataSet:(UIScrollView *)scrollView;
//- (UIImage *)baseCollectionViewImageForEmptyDataSet:(UIScrollView *)scrollView;
//- (CGFloat)baseCollectionViewHeightForEmptyDataSet:(UIScrollView *)scrollView;
//- (BOOL)QemptyDataSetShouldAllowTouch:(UIScrollView *)scrollView;
//- (UIImage *)baseCollectionViewImageForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state;
//- (CGFloat)baseCollectionViewOffsetForEmptyDataSet:(UIScrollView *)scrollView;
//- (NSAttributedString *)baseCollectionViewDescriptionForEmptyDataSet:(UIScrollView *)scrollView;
//- (void)baseCollectionViewEmptyDataSetDidTapButton;
//@end
//
//@interface HTBaseCollectionView : UICollectionView
//@property(nonatomic,assign)BOOL canRefresh;
//
//@property(nonatomic,assign)BOOL canLoadMoreData;
//
//@property(nonatomic,assign)BOOL showLogo;
//
//@property(nonatomic,assign)BOOL canShowNoDataView;
//
//@property(nonatomic,weak) id<HTBaseCollectionViewDelegate> baseCollectionDelegate;
//
//-(instancetype)initWithFrame:(CGRect)frame sectionInset:(UIEdgeInsets)sectionInset;
//
//-(void)setColumnCount:(NSInteger )count;
////下拉属性显示没有更多数据
//- (void)endRefreshingWithNoMoreData;
//
//- (void)resetNoMoreData;
////下拉刷新完毕
//- (void)endHeaderRefresh;
////上拉加载更多完毕
//- (void)endFooterRefresh;
////开始刷新
//- (void)beginRefresh;
//
////- (void)removeCustomNocontentView;
//
//-(BOOL)headerIsRefresh;
//-(BOOL)footerIsRefresh;
//@end
