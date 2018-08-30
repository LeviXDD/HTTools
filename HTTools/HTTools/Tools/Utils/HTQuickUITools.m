//
//  HTQuickUITools.m
//  XiaotanFresh
//
//  Created by 谭康 on 2018/5/15.
//  Copyright © 2018年 caomall. All rights reserved.
//

#import "HTQuickUITools.h"

@implementation HTQuickUITools
+ (UILabel*)ht_quickLabelWithText:(NSString*)text font:(UIFont*)font textColor:(UIColor*)textColor {
    UILabel *label = [[UILabel alloc] init];
    label.font = font;
    label.textColor = textColor;
    label.text = EMPTY_IF_NIL(text);
    label.textAlignment = NSTextAlignmentCenter;
    return label;
}

+(UIButton*)ht_quickButtonWithTitle:(NSString*)title titleColor:(UIColor*)titleColor titleFont:(UIFont*)font tartget:(nullable id)target action:(SEL)action{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    if (!IsNilOrNull(title)) {
        [btn setTitle:title forState:UIControlStateNormal];
    }
    if (!IsNilOrNull(titleColor)) {
        [btn setTitleColor:titleColor forState:UIControlStateNormal];
    }
    if (!IsNilOrNull(font)) {
        btn.titleLabel.font = font;
    }
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return btn;
}

+(UIButton*)ht_quickButtonWithTitle:(NSString*)title titleColor:(UIColor*)titleColor titleFont:(UIFont*)font tartget:(nullable id)target action:(SEL)action borderColor:(UIColor*)borderColor{
    UIButton *btn = [HTQuickUITools ht_quickButtonWithTitle:title titleColor:titleColor titleFont:font tartget:target action:action];
    btn.layer.borderColor = borderColor.CGColor;
    btn.layer.borderWidth = 1.;
    btn.layer.cornerRadius = 4.;
    return btn;
}
@end
