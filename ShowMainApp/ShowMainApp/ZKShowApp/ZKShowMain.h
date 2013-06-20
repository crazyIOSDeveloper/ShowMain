//
//  ZKShowMain.h
//  ShowMainApp
//
//  Created by zhangchaoqun on 13-6-20.
//  Copyright (c) 2013年 zhangchaoqun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZKShowAppDelegate.h"
//用来绘图，并确认点击事件的响应位置
@interface ZKShowMain : UIView
{
    UIScrollView * _mainScroll;
    int appNum;
    
    NSMutableArray * _appViews;
    id<ZKShowAppDelegate> _appDelegate;
}

//展示代理
@property (nonatomic,assign) id<ZKShowAppDelegate> _delegate;

//事件代理
@property (nonatomic,assign) id<ZKAPPClickedDelegate> _clickDelegate;

//相当于初始化
-(void)createShowMainView;




-(int)numberOfApps;

-(void)reloadData;


@end
