//
//  Skintone.m
//  UINavgationController
//
//  Created by 张鑫 on 14-6-22.
//  Copyright (c) 2014年 niexin. All rights reserved.
//

#import "Skintone.h"
#import "SQLiteTool.h"
@implementation Skintone

@synthesize skintoneId;
@synthesize skintoneName;
@synthesize RGB;


-(id)init{
    self = [super init];
    if (self) {
        
    }
    return self;
}



+ (NSArray*) queryAll{
    NSString* sql = @"select skintone_id, skintone_name, RGB from Skintone";
    [[SQLiteTool shareInstance] openDb:DB_NAME];
    [[SQLiteTool shareInstance] prepareSql:sql];
    NSMutableArray* list = [[NSMutableArray alloc]init];
    while ([SQLiteTool hasRows]) {
        Skintone* skin = [[Skintone alloc]init];
        skin.skintoneId = [SQLiteTool readIntegerAtColumnIndex:0];
        skin.skintoneName = [SQLiteTool readStringAtColumnIndex:1];
        skin.RGB = [SQLiteTool readStringAtColumnIndex:2];
        LOGINFO(@"%d,%@,%@",skin.skintoneId,skin.skintoneName,skin.RGB);
        [list addObject:skin];
    }
    return list;
}






@end
