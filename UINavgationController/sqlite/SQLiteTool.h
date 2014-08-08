//
//  SQLiteTool.h
//  UINavgationController
//
//  Created by 张鑫 on 14-6-22.
//  Copyright (c) 2014年 niexin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "sqlite3.h"
#import "PrintLog.h"

#define DB_NAME     @"area"

@interface SQLiteTool : NSObject{
    sqlite3* database;
    sqlite3_stmt* statement;
    char* errorMsg;
}

@property(nonatomic, readwrite) sqlite3_stmt* statement;
@property(nonatomic, readwrite) sqlite3* database;

+(SQLiteTool *)shareInstance;

+(BOOL)hasRows;

+(NSString*)readStringAtColumnIndex:(int)columnIndex;
+(NSInteger)readIntegerAtColumnIndex:(int)columnIndex;
+(double)readDoubleAtColumnIndex:(int)columnIndex;
+(NSDate*)readDateAtColumnIndex:(int)columnIndex;
+(BOOL)isNullAtColumnIndex:(int)columnIndex;
+(NSInteger)count;

-(BOOL)openDb:(NSString*)dbName;

-(void)closeDb;

-(BOOL)executeSql:(NSString*)sql;

-(BOOL)prepareSql:(NSString*)sql;

@end
