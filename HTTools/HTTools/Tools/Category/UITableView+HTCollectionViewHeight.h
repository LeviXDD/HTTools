//
//  UITableView+HTCollectionViewHeight.h
//  caomall
//
//  Created by 谭康 on 2018/7/13.
//  Copyright © 2018 Levi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UITableView+FDTemplateLayoutCell.h"

typedef CGFloat(^editCellHeightAction)(id cell, CGFloat cellHeight);

@interface UITableView (HTCollectionViewHeight)

- (CGFloat)ht_heightForCellWithIdentifier:(NSString *)identifier
                         cacheByIndexPath:(NSIndexPath *)indexPath
                            configuration:(void (^)(id cell))configuration
                               editAction:(editCellHeightAction)editAction;
@end
