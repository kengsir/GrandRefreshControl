//
//  RefreshHeader.m
//  GrandRefreshControl
//
//  Created by jack on 16/11/3.
//  Copyright © 2016年 jack. All rights reserved.
//

#import "RefreshHeader.h"

@interface RefreshHeader()
@end

@implementation RefreshHeader

+ (RefreshHeader *)headerWithNextStep:(void(^)())next
{
    RefreshHeader *header = [[self alloc]init];
    header.headerHandle = next;
    return header;
}

+ (RefreshHeader *)headerWithTarget:(id)target nextAction:(SEL)action
{
    RefreshHeader *header = [[self alloc]init];
    header.refreshTarget = target;
    header.refreshAction = action;
    return header;
}

- (void)afterMoveToSuperview
{
    [super afterMoveToSuperview];
    self.frame = CGRectMake(0, -RefreshControlContentHeight, self.scrollView.frame.size.width, RefreshControlContentHeight);
}

- (void)refreshControlContentOffsetDidChange:(CGFloat)y isDragging:(BOOL)dragging
{
    if (y< -RefreshControlContentInset&&y<0)
    {
        [self refreshControlWillEnterRefreshState];
        if (!dragging) {
            [self refreshControlRefreshing];
        }
        return;
    }
    [self refreshControlWillQuitRefreshState];
}

- (void)refreshControlRefreshing
{
    [super refreshControlRefreshing];
    [UIView animateWithDuration:RefreshControlTimeIntervalDuration animations:^{
        self.scrollView.contentInset = UIEdgeInsetsMake(RefreshControlContentInset, 0, 0, 0);
    }];
    self.arrow.hidden = YES;
}

@end
