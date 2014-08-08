//
//  ScrollViewCycleController.m
//  UINavgationController
//
//  Created by niexin on 13-1-6.
//  Copyright (c) 2013年 niexin. All rights reserved.
//

#import "ScrollViewCycleController.h"

@interface ScrollViewCycleController ()

@end

@implementation ScrollViewCycleController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
        // Do any additional setup after loading the view from its nib.
}
#pragma mark -
#pragma mark UIScrollViewDelegate

#define SET_FRAME(ARTICLEX) x = ARTICLEX.view.frame.origin.x + increase;\
if(x < 0) x = pageWidth * 2;\
if(x > pageWidth * 2) x = 0.0f;\
[ARTICLEX.view setFrame:CGRectMake(x, \
ARTICLEX.view.frame.origin.y,\
ARTICLEX.view.frame.size.width,\
ARTICLEX.view.frame.size.height)]
//将三个view都向右移动，并更新三个指针的指向，article2永远指向当前显示的view，article1是左边的，article3是右边的
@end
