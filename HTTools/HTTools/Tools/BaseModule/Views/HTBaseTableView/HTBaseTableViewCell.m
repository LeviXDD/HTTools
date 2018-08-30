//
//  HTBaseTableViewCell.m
//  caomall
//
//  Created by 谭康 on 2018/5/11.
//  Copyright © 2018年 Levi. All rights reserved.
//

#import "HTBaseTableViewCell.h"

@implementation HTBaseTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

@end
