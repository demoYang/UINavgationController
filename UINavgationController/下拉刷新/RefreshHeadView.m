//
//  RefreshHeadView.m
//  UINavgationController
//
//  Created by niexin on 12-11-16.
//  Copyright (c) 2012年 niexin. All rights reserved.
//

#import "RefreshHeadView.h"

@implementation RefreshHeadView

@synthesize refreshDelegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        CGFloat hight = frame.size.height;
        imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"dragDown.png"]];
        imageView.frame = CGRectMake(40, hight - 40, 20, 20);
        [self addSubview:imageView];
        
        label1 = [[UILabel alloc]initWithFrame:CGRectMake(70, hight - 50, 100, 15)];
        label1.textColor = [UIColor lightGrayColor];
        label1.font = [UIFont systemFontOfSize:14];
        [self addSubview:label1];
        
        
        label2 = [[UILabel alloc]initWithFrame:CGRectMake(70, hight - 40, 100, 15)];
        label2.textColor = [UIColor lightGrayColor];
        label2.font = [UIFont systemFontOfSize:14];
        [self addSubview:label2];
    }
    return self;
}

-(void)refreshScrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat offSetY = scrollView.contentOffset.y;
    label2.text = @"上次刷新：。。。。";
    if (offSetY > -60.0f) {
        label1.text = @"下拉刷新";
        imageView.image = [UIImage imageNamed:@"dragDown.png"];
    }else{
        label1.text = @"松开刷新";
        imageView.image = [UIImage imageNamed:@"dragUp.png"];
    }
}

-(void)refreshScrollViewDidEndDragging:(UIScrollView *)scrollView{
    CGFloat offSetY = scrollView.contentOffset.y;
    if (offSetY < -60.0f) {
        [scrollView setContentInset:UIEdgeInsetsMake(60, 0, 0, 0)];
        [refreshDelegate beginRefresh];
    }
}

@end








