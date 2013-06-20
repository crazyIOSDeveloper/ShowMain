//
//  ZKShowAppDelegate.h
//  ShowMainApp
//
//  Created by zhangchaoqun on 13-6-20.
//  Copyright (c) 2013年 zhangchaoqun. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ZKShowMain;
//此代理为定制UIview做准备
@protocol ZKShowAppDelegate <NSObject>

-(int)numberOfAppsInZKShowMain:(ZKShowMain *)main;
@optional
-(UIView *)ZKShowMain:(ZKShowMain *)main showViewForIndex:(int)index;

@end

@protocol ZKAPPClickedDelegate <NSObject>

@optional
-(void)ZKShowMain:(ZKShowMain *)main clickedOnIndex:(int)index;
@end
