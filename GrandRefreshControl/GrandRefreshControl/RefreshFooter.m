//
//  RefreshFooter.m
//  GrandRefreshControl
//
//  Created by jack on 16/11/3.
//  Copyright © 2016年 jack. All rights reserved.
//

#import "RefreshFooter.h"

@interface RefreshFooter()
@end

@implementation RefreshFooter

+ (RefreshFooter *)footerWithNetStep:(void(^)())next
{
    RefreshFooter *footer = [[self alloc]init];
    footer.refreshStyle = RefreshFooterStyle;
    footer.footerHandle = next;
    return footer;
}

- (void)refreshControlContentOffsetChange:(CGFloat)y isDragging:(BOOL)dragging
{
    dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"fact==%f,y==%f",self.scrollView.contentSize.height - self.scrollView.frame.size.height + RefreshControlContentInset,y);
        if (y>=self.scrollView.contentSize.height - self.scrollView.frame.size.height + RefreshControlContentInset)
        {
            [self refreshControlWillEnterRefreshState];
            if (!dragging) {
                [self refreshControlRefreshing];
            }
            return;
        }
        [self refreshControlWillQuitRefreshState];
    });
}

- (void)refreshControlRefreshing
{
    [super refreshControlRefreshing];
    [UIView animateWithDuration:0.1f animations:^{
        self.scrollView.contentInset = UIEdgeInsetsMake(0, 0, RefreshControlContentInset, 0);
    }];
    self.arrow.hidden = YES;
}
@end