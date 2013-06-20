//
//  ZKShowMain.m
//  ShowMainApp
//
//  Created by zhangchaoqun on 13-6-20.
//  Copyright (c) 2013年 zhangchaoqun. All rights reserved.
//

#import "ZKShowMain.h"
#import "ZKShowTouch.h"

#define countRow 4 //行数
#define countLine 2 //列数

@implementation ZKShowMain
@synthesize _clickDelegate;
@synthesize _delegate=_appDelegate;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self createShowMainView];
    }
    return self;
}
-(void)dealloc
{
    [_appViews release];
    [_mainScroll release];
    [super dealloc];
}
//相当于初始化
-(void)createShowMainView
{
    _mainScroll= [[UIScrollView alloc] initWithFrame:CGRectZero];
    [self addSubview:_mainScroll];
    _mainScroll.pagingEnabled = YES;
    self.clearsContextBeforeDrawing = YES;
    
    _appViews = [[NSMutableArray alloc] init];
    
    appNum = -1;

}
-(int)numberOfApps
{
    return appNum;
}


-(void)layoutSubviews
{
    if ([_appViews count]==0)
    {
        [self createEveAppViews];
    }
    for (UIView * eve in _mainScroll.subviews)
    {
        [eve removeFromSuperview];
    }
    
    CGRect rect = self.bounds;
    float height = rect.size.height;
    float width = rect.size.width;
    _mainScroll.frame = rect;
    
    int appNumber = [self numberOfApps];
    //调整位置，大小，不做创建移除操作
    int pageNum = appNumber/(countRow*countLine);
    if (appNumber==pageNum*(countRow*countLine))
    {
        //刚好是整数的情况，需要
        pageNum--;
    }

    for (UIView * eveView in _appViews)
    {
        [_mainScroll addSubview:eveView];
    }
    
    CGSize newSize = CGSizeMake((pageNum+1)*width, height);
    _mainScroll.contentSize = newSize;
    
}
-(void)clickedOnView:(id)sender
{
    UITapGestureRecognizer * tap=(UITapGestureRecognizer *)sender;
    
    if (_clickDelegate&&[_clickDelegate respondsToSelector:@selector(ZKShowMain:clickedOnIndex:)])
    {
        UIView * eveView = tap.view;
        int index = [_appViews indexOfObject:eveView];
        if (index>=0)
        {
            [_clickDelegate ZKShowMain:self clickedOnIndex:index];
        }
    }
    
}


-(CGRect)appRectFromIndex:(int)countIndex
{
    CGRect rect = self.bounds;
    float height = rect.size.height;
    float width = rect.size.width;
    //两种可能，由间距控制排列，或由大小控制排列
    float appWith = 80.0;
    float appHeight = 120.0;
    float spaceWith = 5.0;
    float spaceHeight = 20.0;
    
    
//    spaceWith = (width-appWith*countLine)/(countLine+1.0);
//    spaceHeight = (height-appHeight*countRow)/(countRow+1.0);
    appHeight =(height-(countRow+1)*spaceHeight)/countRow;
    appWith = (width-(countLine+1)*spaceWith)/countLine;
    
//    appHeight = 105;
//    spaceHeight = 10;
    
    int containPage = countIndex/(countLine*countRow);
    //方便取用
    int index = countIndex%(countLine*countRow);
    int row = index%countLine;
    int line = index/countLine;
    //返回数据仅限一页的尺寸，不考虑分页
    float startX = containPage*width+(row+1)*spaceWith+row*appWith;
    float startY = (line+1)*spaceHeight + line*appHeight;
    CGRect newRect = CGRectMake(startX, startY, appWith,appHeight);
    return newRect;
}
-(void)createEveAppViews
{
    [_appViews removeAllObjects];
    
    if (_appDelegate&&[_appDelegate respondsToSelector:@selector(numberOfAppsInZKShowMain:)])
    {
        appNum = [_appDelegate numberOfAppsInZKShowMain:self];
    }
    
    int appNumber = [self numberOfApps];
    
    for (int index = 0; index<appNumber;index++ )
    {
        CGRect newRect = [self appRectFromIndex:index];
        UIView * theView = nil;
        if (_appDelegate&&[_appDelegate respondsToSelector:@selector(ZKShowMain:showViewForIndex:)]) {
            theView = [_appDelegate ZKShowMain:self showViewForIndex:index];
        }
        
        if (!theView)
        {
            theView=[[[ZKShowTouch alloc] init] autorelease];
        }
        
        theView.frame = newRect;
        
        UITapGestureRecognizer * tap =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickedOnView:)];
        [theView addGestureRecognizer:tap];
        [tap release];
        
        [_appViews addObject:theView];
    }

}
-(void)set_delegate:(id<ZKShowAppDelegate>)delegate
{
    _appDelegate = delegate;
    [self reloadData];
}



//给appViews填充数据，并且刷新试图
-(void)reloadData
{
    [self createEveAppViews];
    [self setNeedsLayout];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
