//
//  ActiveViewController_Define.h
//  UINavgationController
//
//  Created by 张鑫 on 14-6-15.
//  Copyright (c) 2014年 niexin. All rights reserved.
//



#define isRetina_Size ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? (CGSizeEqualToSize(CGSizeMake(320*2, 480*2), [[UIScreen mainScreen] currentMode].size) || CGSizeEqualToSize(CGSizeMake(768*2, 1024*2), [[UIScreen mainScreen] currentMode].size) || CGSizeEqualToSize(CGSizeMake(320*2, 568*2), [[UIScreen mainScreen] currentMode].size)) : NO)


#define isRetina  [UIScreen mainScreen].scale == 2;

#define isIphone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(320*2, 568*2), [[UIScreen mainScreen] currentMode].size) : NO)

#define   screenSize        [UIScreen mainScreen].bounds.size
#define   screenHeight      [UIScreen mainScreen].bounds.size.height
#define   screenWidth       [UIScreen mainScreen].bounds.size.width








