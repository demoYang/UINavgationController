//
//  Product.h
//  UINavgationController
//
//  Created by 张鑫 on 14-6-22.
//  Copyright (c) 2014年 niexin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Product : NSManagedObject

@property (nonatomic, retain) NSString * productName;
@property (nonatomic, retain) NSNumber * price;
@property (nonatomic, retain) NSString * productor;


//插入数据
+ (BOOL)add:(NSString*)name price:(CGFloat)price productor:(NSString*)pro;
@end
