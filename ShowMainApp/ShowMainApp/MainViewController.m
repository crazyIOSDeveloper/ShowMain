//
//  MainViewController.m
//  ShowMainApp
//
//  Created by zhangchaoqun on 13-6-20.
//  Copyright (c) 2013年 zhangchaoqun. All rights reserved.
//

#import "MainViewController.h"
#import "ZKShowMain.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(CGRect)showWebRect
{
    CGRect Rect = [[UIScreen mainScreen] bounds];
    
    
    //导航条
    if (!self.navigationController.navigationBarHidden)
    {
        Rect.size.height = Rect.size.height - 44;
    }
    
    BOOL barHidden = self.tabBarController.tabBar.hidden;
    if (self.tabBarController&&!barHidden)
    {//如果没有tabbar,或者被隐藏了
        
        //当在push里面，并且，push之后就隐藏tabbar//此时会隐藏tabbar不需要改变视图大小
        if (!(self.hidesBottomBarWhenPushed&&self.navigationController))
        {//此时，尽管barHidden为NO，但是实际上是被隐藏了的
            
            //此时不会显示tabbar，那么视图就大一些
            Rect.size.height = Rect.size.height - 49;
        }
    }
    
    //    int naCount = [[self.navigationController viewControllers] count];
    //    if(naCount>1&&self.hidesBottomBarWhenPushed)
    //    {//被推出的，并且设置了推出后隐藏
    //        //没有tabbar
    //        Rect.size.height = Rect.size.height + 49;
    //    }
    
    
    BOOL statusHidden = [[UIApplication sharedApplication] isStatusBarHidden];
    if (statusHidden==NO)
    {
        Rect.size.height = Rect.size.height - 20;
    }
    return Rect;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    CGRect rect = [self showWebRect];
    
    ZKShowMain * main = [[ZKShowMain alloc] initWithFrame:rect];
    main._delegate = self;
    main._clickDelegate = self;
    [self.view addSubview:main];
    [main release];
    
    
    main.backgroundColor = [UIColor redColor];
}

-(UIView *)ZKShowMain:(ZKShowMain *)main showViewForIndex:(int)index
{
    if (index==0)
    {
        UIView * aView = [[UIView alloc] initWithFrame:CGRectZero];
        aView.backgroundColor = [UIColor blackColor];
        [aView autorelease];
        
        return aView;
    }
    return nil;
}

-(int)numberOfAppsInZKShowMain:(ZKShowMain *)main
{
    return 15;
}

-(void)ZKShowMain:(ZKShowMain *)main clickedOnIndex:(int)index
{
    NSLog(@"ZKShowMain %d %@",index,main);
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
