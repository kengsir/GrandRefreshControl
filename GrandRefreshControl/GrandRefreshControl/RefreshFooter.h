//
//  RefreshFooter.h
//  GrandRefreshControl
//
//  Created by jack on 16/11/3.
//  Copyright © 2016年 jack. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RefreshControlElement.h"

@interface RefreshFooter : RefreshControlElement
+ (RefreshFooter *)footerWithNetStep:(void(^)())next;
@end
