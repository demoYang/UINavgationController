//
//  UIDevice-Orientation.h
//  UINavgationController
//
//  Created by ZhangXin on 14-3-5.
//  Copyright (c) 2014年 niexin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIDevice (Orientation) <UIAccelerometerDelegate>
- (BOOL) isLandscape;
- (BOOL) isPortrait;
- (NSString *) orientationString;
- (float) orientationAngleRelativeToOrientation:(UIDeviceOrientation) someOrientation;
@property (nonatomic, readonly) BOOL isLandscape;
@property (nonatomic, readonly) BOOL isPortrait;
@property (nonatomic, readonly) NSString *orientationString;
@property (nonatomic, readonly) float orientationAngle;
@end