//
//  User.h
//  UINavgationController
//
//  Created by 张鑫 on 14-6-22.
//  Copyright (c) 2014年 niexin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface User : NSManagedObject

@property (nonatomic, retain) NSString * userName;
@property (nonatomic, retain) NSString * password;
@property (nonatomic, retain) NSNumber * age;
@property (nonatomic, retain) NSString * sex;


+ (BOOL)add:(NSString*)name password:(NSString*)pwd age:(NSInteger)age sex:(NSString*)sex ;
+ (NSMutableArray*)query:(id)sender;
+ (BOOL)update:(id)sender;
+ (BOOL)del:(id)sender ;

@end
