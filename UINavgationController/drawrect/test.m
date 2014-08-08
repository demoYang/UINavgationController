//
//  test.m
//  UINavgationController
//
//  Created by zhangxin on 13-1-17.
//  Copyright (c) 2013年 niexin. All rights reserved.
//

#import "test.h"

@implementation test

+(UIImage*)addBackGroundColor :(UIImage*)image color:(UIColor*)color{
    UIGraphicsBeginImageContext(image.size);
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGRect area = CGRectMake(0, 0, image.size.width, image.size.height);
    [image drawInRect: area];
    
    // overlay a red rectangle
    CGContextSetBlendMode( ctx, kCGBlendModeMultiply) ;
    //    CGContextSetBlendMode( ctx, kCGBlendModeColor) ;
    CIColor * cicolor = [CIColor colorWithCGColor:color.CGColor];
    CGContextSetRGBFillColor ( ctx,  cicolor.red, cicolor.green, cicolor.blue,  cicolor.alpha);
    CGContextFillRect ( ctx, area );
    
    // redraw image
    [image drawInRect: area blendMode: kCGBlendModeDestinationIn alpha: cicolor.alpha];
    
    UIImage * _image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    return _image;
}

@end
