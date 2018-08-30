//
//  UITableView+HTCollectionViewHeight.m
//  caomall
//
//  Created by 谭康 on 2018/7/13.
//  Copyright © 2018 Levi. All rights reserved.
//

#import "UITableView+HTCollectionViewHeight.h"

@implementation UITableView (HTCollectionViewHeight)

- (CGFloat)ht_heightForCellWithIdentifier:(NSString *)identifier
                         cacheByIndexPath:(NSIndexPath *)indexPath
                            configuration:(void (^)(id cell))configuration
                               editAction:(editCellHeightAction)editAction {
    if (!identifier || !indexPath) {
        return 0;
    }
    // Hit cache
    if ([self.fd_indexPathHeightCache existsHeightAtIndexPath:indexPath]) {
        [self fd_debugLog:[NSString stringWithFormat:@"hit cache by index path[%@:%@] - %@", @(indexPath.section), @(indexPath.row), @([self.fd_indexPathHeightCache heightForIndexPath:indexPath])]];
        return [self.fd_indexPathHeightCache heightForIndexPath:indexPath];
    }
    
    CGFloat height = 0;
    //获取缓存中的cell
    UITableViewCell *templateLayoutCell = [self fd_templateCellForReuseIdentifier:identifier];
    //这里插入编辑行高的代码
    if (editAction) {
        height = editAction(templateLayoutCell, [self fd_heightForCellWithIdentifier:identifier configuration:configuration]);
    }
    else {
        height = [self fd_heightForCellWithIdentifier:identifier configuration:configuration];
    }
    
    [self.fd_indexPathHeightCache cacheHeight:height byIndexPath:indexPath];
    [self fd_debugLog:[NSString stringWithFormat: @"cached by index path[%@:%@] - %@", @(indexPath.section), @(indexPath.row), @(height)]];
    return height;
}
@end
