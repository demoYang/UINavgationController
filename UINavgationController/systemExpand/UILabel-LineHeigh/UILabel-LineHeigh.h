//
//  UILabel-LineHeigh.h
//  UINavgationController
//
//  Created by ZhangXin on 14-3-21.
//  Copyright (c) 2014年 niexin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel_LineHeigh : UILabel{
    CGFloat charSpace_;
    CGFloat lineSpace_;
}
@property(nonatomic, assign) CGFloat charSpace;
@property(nonatomic, assign) CGFloat lineSpace;

@end
