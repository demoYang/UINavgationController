//
//  Product.m
//  UINavgationController
//
//  Created by 张鑫 on 14-6-22.
//  Copyright (c) 2014年 niexin. All rights reserved.
//

#import "Product.h"
#import "CoreDataTool.h"


@implementation Product

@dynamic productName;
@dynamic price;
@dynamic productor;


//插入数据
+ (BOOL)add:(NSString*)name price:(CGFloat)price productor:(NSString*)pro {
    Product* user = (Product *)[NSEntityDescription insertNewObjectForEntityForName:@"Product" inManagedObjectContext:[CoreDataTool shareInstance].managedObjectContext];
    [user setProductName:name];
    [user setPrice:[NSNumber numberWithFloat:price]];
    [user setProductor:pro];
    
    NSError* error;
    BOOL isSaveSuccess=[[CoreDataTool shareInstance].managedObjectContext save:&error];
    if (!isSaveSuccess) {
        LOGINFO(@"Error:%@",error);
    }else{
        LOGINFO(@"Save successful!");
    }
    return isSaveSuccess;
}

@end
