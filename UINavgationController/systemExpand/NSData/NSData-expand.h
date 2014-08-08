//
//  NSData-expand.h
//  UINavgationController
//
//  Created by 张鑫 on 14-6-21.
//  Copyright (c) 2014年 niexin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData(expand)

- (NSData *)AES256EncryptWithKey:(NSString *)key;
    
//数据解密
- (NSData *)AES256DecryptWithKey:(NSString *)key;

@end
