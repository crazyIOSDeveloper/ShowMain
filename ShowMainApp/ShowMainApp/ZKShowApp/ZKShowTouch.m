//
//  ZKShowTouch.m
//  ShowMainApp
//
//  Created by zhangchaoqun on 13-6-20.
//  Copyright (c) 2013年 zhangchaoqun. All rights reserved.
//

#import "ZKShowTouch.h"

@implementation ZKShowTouch

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        CGRect rect = self.bounds;
        self.backgroundColor = [UIColor greenColor];
        iconImg = [[UIImageView alloc] initWithFrame:rect];
        [self addSubview:iconImg];
        
        CGSize size = CGSizeMake(50, 20);
        rect.size = size;
        nameLbl = [[UILabel alloc] initWithFrame:rect];
        nameLbl.textAlignment = UITextAlignmentCenter;
        nameLbl.backgroundColor = [UIColor clearColor];
        [self addSubview:nameLbl];
        nameLbl.text = @"测试";
        
    }
    return self;
}
-(void)dealloc
{
    [nameLbl release];
    [iconImg release];
    [super dealloc];
}
-(void)layoutSubviews
{
    CGRect rect = self.bounds;
    nameLbl.center = CGPointMake(rect.size.width/2.0, rect.size.height/2.0);
    iconImg.center = CGPointMake(rect.size.width/2.0, rect.size.height/2.0);
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
