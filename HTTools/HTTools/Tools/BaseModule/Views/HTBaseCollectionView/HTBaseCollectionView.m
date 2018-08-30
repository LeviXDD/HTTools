////
////  LJBaseCollectionView.m
////  LeJiaYP
////
////  Created by 海涛 黎 on 2017/2/24.
////  Copyright © 2017年 gaodong. All rights reserved.
////
//
//#import "HTBaseCollectionView.h"
//#import "UIScrollView+EmptyDataSet.h"
//@interface HTBaseCollectionView()<DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>
//
///** <#注释#> */
//@property (nonatomic, strong) CHTCollectionViewWaterfallLayout *layout ;
//@end
//
//@implementation HTBaseCollectionView
//-(instancetype)initWithFrame:(CGRect)frame sectionInset:(UIEdgeInsets)sectionInset{
//    self.layout = [[CHTCollectionViewWaterfallLayout alloc] init];
//    self.layout.sectionInset = sectionInset;
//    self.layout.headerHeight = sectionInset.top;
//    self.layout.footerHeight = sectionInset.bottom;
//    self.layout.minimumColumnSpacing = sectionInset.left;
//    self.layout.minimumInteritemSpacing = sectionInset.right;
//    self = [super initWithFrame:frame collectionViewLayout:self.layout];
//    if (self) {
//        self.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
//    }
//    return self;
//}
//
//-(void)awakeFromNib{
//    
//    [super awakeFromNib ];
//    UIEdgeInsets  sectionInset =UIEdgeInsetsMake(10, 10, 10, 10);
//    self.layout = [[CHTCollectionViewWaterfallLayout alloc] init];
//    self.layout.sectionInset = sectionInset;
//    self.layout.headerHeight = sectionInset.top;
//    self.layout.footerHeight = sectionInset.bottom;
//    self.layout.minimumColumnSpacing = sectionInset.left;
//    self.layout.minimumInteritemSpacing = sectionInset.right;
//    [self setCollectionViewLayout:self.layout];
////    self.backgroundColor = commonBackgroundGrayColor;
//        self.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
//}
//
//-(void)setColumnCount:(NSInteger )count{
//    self.layout.columnCount =count;
//    
//}
//
//
//- (void)setCanRefresh:(BOOL)canRefresh {
//    if(canRefresh) {
//        self.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
//            // 模拟延迟加载数据，因此2秒后才调用（真实开发中，可以移除这段gcd代码）
//            [self.baseCollectionDelegate collectionViewDelegateRefresh:self];
//        }];
//    }else{
//    
//        self.mj_header =nil;
//    }
//}
//
//-(void)setCanShowNoDataView:(BOOL)canShowNoDataView{
//    if (!canShowNoDataView) {
//        self.emptyDataSetSource = nil;
//        self.emptyDataSetDelegate = nil;
//        return;
//    }
//    self.emptyDataSetSource = self;
//    self.emptyDataSetDelegate = self;
//}
//
//- (void)setCanLoadMoreData:(BOOL)canLoadMoreData {
//    if(canLoadMoreData) {
//        MJRefreshAutoNormalFooter*footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
//                [self.baseCollectionDelegate collectionViewDelegateLoadMoreData:self];
//        }];
//        [footer setTitle:@" " forState:MJRefreshStateIdle];
//        [footer setTitle:@"加载中..."forState:MJRefreshStateRefreshing];
//        self.mj_footer= footer;
//    }else{
//        
//        self.mj_footer =nil;
//    }
//}
//
//- (void)setShowLogo:(BOOL)showLogo {
//    
//    //    ((MJDIYHeader*)self.mj_header).logo.hidden= !showLogo;
//    
//}
//
//
//- (void)endRefreshingWithNoMoreData {
//    
//    //显示没有更多内容
//    
//    [self.mj_footer endRefreshingWithNoMoreData];
//    
//}
//
//- (void)resetNoMoreData {
//    
//    [self.mj_footer resetNoMoreData];
//    
//}
//
//- (void)endHeaderRefresh {
//    
//    [self.mj_header endRefreshing];
//    
//}
//
//- (void)endFooterRefresh {
//    
//    [self.mj_footer endRefreshing];
//    
//}
//
//- (void)beginRefresh {
//    
//    [self.mj_header beginRefreshing];
//    
//}
//
//-(BOOL)headerIsRefresh{
//    
//    return [self.mj_header isRefreshing];
//    
//}
//-(BOOL)footerIsRefresh{
//    
//    return [self.mj_footer isRefreshing];
//    
//}
//
//#pragma mark -- DZNEmptyData delegate
///*
// - (UIView *)customViewForEmptyDataSet:(UIScrollView *)scrollView{
// 
// return   [self.GXBaseTableViewDelegate qCustomViewForEmptyDataSet:scrollView];
// }
// */
//- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView
//{
//    
//    if ([self.baseCollectionDelegate respondsToSelector:@selector(baseCollectionViewImageForEmptyDataSet:)]) {
//        return [self.baseCollectionDelegate baseCollectionViewImageForEmptyDataSet:scrollView];
//    }else{
//        return [UIImage imageNamed:@"ic_collection"];
//    }
//}
//
//- (CGFloat)spaceHeightForEmptyDataSet:(UIScrollView *)scrollView{
//    
//    if ([self.baseCollectionDelegate respondsToSelector:@selector(baseCollectionViewHeightForEmptyDataSet:)]) {
//        return [self.baseCollectionDelegate baseCollectionViewHeightForEmptyDataSet:scrollView];
//    }else{
//        return 50;
//    }
//}
//
//- (BOOL)emptyDataSetShouldAllowTouch:(UIScrollView *)scrollView
//{
//    return YES;
//}
//
//- (UIImage *)buttonImageForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state
//{
//    //    return [UIImage imageNamed:@"otherBtn"];
//    if ([self.baseCollectionDelegate respondsToSelector:@selector(baseCollectionViewImageForEmptyDataSet:forState:)]) {
//        return [self.baseCollectionDelegate baseCollectionViewImageForEmptyDataSet:scrollView forState:state];
//    }else{
//        return nil;
//    }
//}
//
//- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView{
//    if ([self.baseCollectionDelegate respondsToSelector:@selector(baseCollectionViewOffsetForEmptyDataSet:)]) {
//        return [self.baseCollectionDelegate baseCollectionViewOffsetForEmptyDataSet:scrollView];
//    }else{
//        return 10;
//    }
//}
//
//- (NSAttributedString *)descriptionForEmptyDataSet:(UIScrollView *)scrollView{
//    if ([self.baseCollectionDelegate respondsToSelector:@selector(baseCollectionViewDescriptionForEmptyDataSet:)]) {
//        return [self.baseCollectionDelegate baseCollectionViewDescriptionForEmptyDataSet:scrollView];
//    }else{
//        NSAttributedString * string =[[NSAttributedString alloc]initWithString:@"暂时没有数据，精彩等你发现!"];
//        return string;
//    }
//}
//- (UIColor *)backgroundColorForEmptyDataSet:(UIScrollView *)scrollView{
//    
//    return [UIColor whiteColor];
//}
//
//- (void)emptyDataSetDidTapButton:(UIScrollView *)scrollView
//{
//    if ([self.baseCollectionDelegate respondsToSelector:@selector(baseCollectionViewEmptyDataSetDidTapButton)]) {
//        [self.baseCollectionDelegate baseCollectionViewEmptyDataSetDidTapButton];
//    }
//}
//
//
//@end
