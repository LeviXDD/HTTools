//
//  BaseViewController.m
//  Channel
//
//  Created by user on 16/2/22.
//  Copyright © 2016年 ruanxianxiang. All rights reserved.
//

#import "BaseViewController.h"
#import "UIImage+Extension.h"
#import "RTRootNavigationController.h"
//#import "UMMobClick/MobClick.h"
#define BarImageWidth  20
#define BarImageHight  22
#define kNormalNavBarColor [UIColor whiteColor]
@interface BaseViewController ()<UIGestureRecognizerDelegate>
@property(nonatomic, strong) UIButton *navBackButton;
@end

@implementation BaseViewController
-(void)dealloc{
    NSString *className = NSStringFromClass([self class]);
    NSLog(@"销毁页面----%@----",className);
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSString *className = NSStringFromClass([self class]);
    NSLog(@"进入页面----%@----",className);
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    self.isShowNavigationgBar = YES;
    //设置导航栏文字的主题
    self.navType = HTNavgationBarTypeNoraml;
    self.view.backgroundColor = MAIN_BG_COLOR;
    self.rt_disableInteractivePop = NO;  //开启手势
}

#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    return self.navigationController.childViewControllers.count > 1;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return self.navigationController.viewControllers.count > 1;
}

#pragma mark - Public Methods

/**
 移除导航控制器堆栈中的某些控制器

 @param controllers 要移除的控制器数组（元素为要移除控制器的类名）
 */
-(void)removeControllers:(NSArray<NSString*> *)controllers{
    for (RTContainerController *controller in self.rt_navigationController.viewControllers) {
        NSString* vcClassName = NSStringFromClass([controller.contentViewController class]);
        
        if ([controllers containsObject:vcClassName]) {
            [self.rt_navigationController removeViewController:controller.contentViewController];
        }
    }
}


/**
 Push方法

 @param controller <#controller description#>
 @param animated <#animated description#>
 @param block <#block description#>
 */
-(void)pushViewController:(UIViewController *)controller animated:(BOOL)animated complete:(void (^)(BOOL finished))block{
    [self.rt_navigationController pushViewController:controller animated:animated complete:^(BOOL finished) {
        block(finished);
    }];
}

-(void)backAction:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Getters
-(UIButton *)navBackButton{
    if (!_navBackButton) {
        UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
        [button setTitle:@"" forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"Navigation_back"] forState:UIControlStateNormal];
        button.imageEdgeInsets = UIEdgeInsetsMake(12, -8, 11, 30);
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
        _navBackButton = button;
    }
    return _navBackButton;
}

#pragma mark - Setters
- (void)setIsExtendLayout:(BOOL)isExtendLayout {
    _isExtendLayout = isExtendLayout;
    if (!isExtendLayout) {
        [self initializeSelfVCSetting];
    }
}

-(void)setIsShowNavigationgBar:(BOOL)isShowNavigationgBar{
    _isShowNavigationgBar = isShowNavigationgBar;
    if (isShowNavigationgBar) {
        self.navigationController.navigationBar.hidden = NO;
        
    } else {
        self.navigationController.navigationBar.hidden = YES;;
    }
}

-(void)setNavType:(HTNavgationBarType)navType{
    _navType = navType;
    if(self!=[self.navigationController.viewControllers objectAtIndex:0]){
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:self.navBackButton];
    }
    switch (navType) {
        case HTNavgationBarTypeNoraml:
        {
            [self.navigationController.navigationBar setShadowImage:[UIImage imageWithColor:[UIColor whiteColor] size:CGSizeMake(self.view.frame.size.width, 0.5)]];
            self.navigationController.navigationBar.barStyle = UIStatusBarStyleDefault;
            [self.navigationController.navigationBar setBarTintColor:kNormalNavBarColor];
            [self.navigationController.navigationBar setTintColor:kNormalNavBarColor];
            [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:kNormalNavBarColor]
                                                         forBarPosition:UIBarPositionAny
                                                             barMetrics:UIBarMetricsDefault];
        }
            break;
            
        case HTNavgationBarTypeClear:
        {
            UIImage *colorImage = [UIImage imageWithColor:[UIColor clearColor] size:CGSizeMake(self.view.frame.size.width, 0.5)];
            [self.navigationController.navigationBar setBackgroundImage:colorImage forBarMetrics:UIBarMetricsDefault];
            [self.navigationController.navigationBar setShadowImage:[UIImage imageWithColor:[UIColor clearColor] size:CGSizeMake(self.view.frame.size.width, 0.5)]];
            
            [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:16],NSForegroundColorAttributeName:[UIColor whiteColor]}];
            self.navigationController.navigationBar.barStyle = UIStatusBarStyleDefault;
            [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:[UIColor clearColor]]
                                                         forBarPosition:UIBarPositionAny
                                                             barMetrics:UIBarMetricsDefault];
        }
            break;
            
        default:
            break;
    }
}

- (void)initializeSelfVCSetting {
    if ([self respondsToSelector:@selector(setAutomaticallyAdjustsScrollViewInsets:)]) {
        [self setAutomaticallyAdjustsScrollViewInsets:NO];
    }
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        self.edgesForExtendedLayout=UIRectEdgeNone;
    }
}
@end
