//
//  HTBaseTableView.h
//  HT
//
//  Created by 海涛 黎 on 17/5/30.
//  Copyright © 2017年 海涛 黎. All rights reserved.
//

#import "HTBaseTableView.h"
#import "MJRefresh.h"
#import "UIScrollView+EmptyDataSet.h"
#import "HTRefreshHeader.h"
#import "AFNetworkReachabilityManager.h"
@interface HTBaseTableView()<DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>

@property (nonatomic,strong) UIView * noDataView;

@property(nonatomic, strong) HTRefreshHeader *refreshHeader;
@property (nonatomic, strong) MJRefreshAutoNormalFooter * footer;
@end

@implementation HTBaseTableView
#pragma mark -- life cycle
- (instancetype)initWithFrame:(CGRect)frame {
    if(self= [super initWithFrame:frame]) {
        self.showsVerticalScrollIndicator=YES;
        self.showsHorizontalScrollIndicator=NO;
        self.separatorStyle=UITableViewCellSeparatorStyleNone;
        self.backgroundColor = [UIColor hx_colorWithHexString:@"#F7F7F8"];
    }
    self.tableFooterView = [UIView new];
    return self;
}

- (instancetype)initWithSingleLineStyle;
{
    self = [super initWithFrame:CGRectZero];
    if (self) {
        self.showsVerticalScrollIndicator=YES;
        self.showsHorizontalScrollIndicator=NO;
        self.separatorStyle=UITableViewCellSeparatorStyleNone;
        self.backgroundColor = MAIN_BG_COLOR;
        self.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        self.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
        self.separatorColor = LINE_COLOR;
        self.tableFooterView = [UIView new];
    }
    return self;
}

#pragma mark - Public Methods
- (void)endRefreshingWithNoMoreData {
    //显示没有更多内容
    [self.mj_footer endRefreshingWithNoMoreData];
}


- (void)resetNoMoreData {
    [self.mj_footer resetNoMoreData];
    
}

- (void)endHeaderRefresh {
    [self.mj_header endRefreshing];
    
}

- (void)endFooterRefresh {
    [self.mj_footer endRefreshing];
}

- (void)beginRefresh {
        [self.mj_header beginRefreshing];
    
}

-(BOOL)headerIsRefresh{
    return [self.mj_header isRefreshing];
}

-(BOOL)footerIsRefresh{
    return [self.mj_footer isRefreshing];
}

#pragma mark - DZNEmptyData delegate
- (NSAttributedString *)descriptionForEmptyDataSet:(UIScrollView *)scrollView{
    if (self.baseDelegate && [self.baseDelegate respondsToSelector:@selector(ht_descriptionForEmptyDataSet:)]) {
        NSString *string = [self.baseDelegate ht_descriptionForEmptyDataSet:scrollView];
        return [[NSAttributedString alloc]initWithString:string];
    }else{
            NSAttributedString * string =[[NSAttributedString alloc]initWithString:@"暂无相关信息"];
            return string;
    }
}

-(NSAttributedString *)buttonTitleForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state{
    if (self.baseDelegate && [self.baseDelegate respondsToSelector:@selector(ht_buttonTitleForEmptyDataSet:forState:)]) {
        NSString *string = [self.baseDelegate ht_buttonTitleForEmptyDataSet:self forState:state];
        if (STRING_ISNIL(string)) {
            return nil;
        } else {
            NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:string];
            [text addAttribute:NSFontAttributeName value:[UIFont fontWithName:kPingFangSC_Regular size:16] range:NSMakeRange(0, string.length)];
            [text addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:NSMakeRange(0, string.length)];
            return text;
        }
    }else{
        return nil;
    }
}

-(void)emptyDataSet:(UIScrollView *)scrollView didTapButton:(UIButton *)button{
    if (self.baseDelegate && [self.baseDelegate respondsToSelector:@selector(ht_emptyDataSetDidTapView:)]) {
        [self.baseDelegate ht_emptyDataSetDidTapView:self];
    }
}

-(CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView{
    return 0.1*self.height;//(self.height/2.-(self.height*0.4));
}

#pragma mark - Setters
- (void)setCanRefresh:(BOOL)canRefresh {
    if(canRefresh) {
        self.mj_header = self.refreshHeader;
    } else {
        self.mj_header = nil;
    }
}

-(void)setCanShowNoDataView:(BOOL)canShowNoDataView{
    if (canShowNoDataView) {
        self.emptyDataSetSource = self;
        self.emptyDataSetDelegate = self;
        self.tableFooterView = [UIView new];
    }
}
- (void)setCanLoadMoreData:(BOOL)canLoadMoreData {
    if(canLoadMoreData) {
        self.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            if(self.baseDelegate && [self.baseDelegate respondsToSelector:@selector(ht_tableViewDelegateLoadMoreData:)]) {
                [self.baseDelegate ht_tableViewDelegateLoadMoreData:self];
            }
        }];
        self.mj_footer= self.footer;
    }
}
-(void)setNoMoreDataDescription:(NSString *)noMoreDataDescription{
    _noMoreDataDescription = noMoreDataDescription;
    [self.footer setTitle:noMoreDataDescription forState:MJRefreshStateNoMoreData];
}

-(void)setRefreshingDataDescription:(NSString *)refreshingDataDescription{
    _refreshingDataDescription = refreshingDataDescription;
    [self.footer setTitle:refreshingDataDescription forState:MJRefreshStateRefreshing];
}

-(void)setLoadMoreDataDescription:(NSString *)loadMoreDataDescription{
    _loadMoreDataDescription = loadMoreDataDescription;
    [self.footer setTitle:loadMoreDataDescription forState:MJRefreshStateIdle];
}

-(void)setEndMoreData:(NSString *)string{
    [self.footer setTitle:string forState:MJRefreshStateNoMoreData];
    [self.footer.stateLabel setTextColor:[UIColor hx_colorWithHexString:@"#A7A7A7"]];
}

#pragma mark - Getters
-(HTRefreshHeader *)refreshHeader{
    if (!_refreshHeader) {
        _refreshHeader = [HTRefreshHeader headerWithRefreshingBlock:^{
            if ([AFNetworkReachabilityManager sharedManager].networkReachabilityStatus ==AFNetworkReachabilityStatusUnknown || [AFNetworkReachabilityManager sharedManager].networkReachabilityStatus ==AFNetworkReachabilityStatusNotReachable) {
            }
            if (self.baseDelegate && [self.baseDelegate respondsToSelector:@selector(ht_tableViewDelegateRefresh:)]) {
                [self.baseDelegate ht_tableViewDelegateRefresh:self];
            }
        }];
        _refreshHeader.ignoredScrollViewContentInsetTop = -20;
        
    }
    return _refreshHeader;
}
@end
