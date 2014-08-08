//
//  PrintLog.m
//  BJXH-doctor
//
//  Created by zhangxin on 14-6-3.
//  Copyright (c) 2014年 archermind. All rights reserved.
//

#import "PrintLog.h"





void printLog(int level ,NSString* file ,int line ,NSString* format, ...){
    if (level < LEVEL_CONTROL) {
        return;
    }
    
    va_list ap;
    va_start(ap, format);
    NSString* logFormat = [[NSString alloc]initWithFormat:format arguments:ap];
    va_end(ap);
    /*
     id sender;
     while ((sender = va_arg(ap, id))) {
        if ([sender isKindOfClass:[NSString class]]) {
     
        }
     }
    */
    NSString* levelStr = @"INFO";
    if (level == LEVEL_WARN) {
        levelStr = @"WARN";
    }else if (level == LEVEL_ERROR){
        levelStr = @"ERROR";
    }
    NSString* logStr = [NSString stringWithFormat:@"[%@]:%@ line:%d %@",levelStr,file,line,logFormat];
    NSLog(@"%@",logStr);
}
