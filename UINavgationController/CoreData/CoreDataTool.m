//
//  CoreDataTool.m
//  UINavgationController
//
//  Created by 张鑫 on 14-6-22.
//  Copyright (c) 2014年 niexin. All rights reserved.
//

#import "CoreDataTool.h"


@implementation CoreDataTool

@synthesize managedObjectModel=_managedObjectModel;
@synthesize managedObjectContext=_managedObjectContext;
@synthesize persistentStoreCoordinator=_persistentStoreCoordinator;

+(CoreDataTool *)shareInstance{
    static CoreDataTool* instance;
    if (instance == nil) {
        
        @synchronized(self){
            if (instance == nil) {
                instance= [[CoreDataTool alloc] init];
            }
        }
    }
    return instance;
}

//托管对象
-(NSManagedObjectModel *)managedObjectModel
{
    if (_managedObjectModel!=nil) {
        return _managedObjectModel;
    }
//    NSURL* modelURL=[[NSBundle mainBundle] URLForResource:@"CoreDataExample" withExtension:@"momd"];
//    _managedObjectModel=[[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    _managedObjectModel=[NSManagedObjectModel mergedModelFromBundles:nil];
    return _managedObjectModel;
}
//托管对象上下文
-(NSManagedObjectContext *)managedObjectContext
{
    if (_managedObjectContext!=nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator* coordinator = [self persistentStoreCoordinator];
    if (coordinator!=nil) {
        _managedObjectContext=[[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
        
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return _managedObjectContext;
}
//持久化存储协调器
-(NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (_persistentStoreCoordinator!=nil) {
        return _persistentStoreCoordinator;
    }
//    NSURL* storeURL=[[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"CoreaDataExample.CDBStore"];
//    NSFileManager* fileManager=[NSFileManager defaultManager];
//    if(![fileManager fileExistsAtPath:[storeURL path]])
//    {
//        NSURL* defaultStoreURL=[[NSBundle mainBundle] URLForResource:@"CoreDataExample" withExtension:@"CDBStore"];
//        if (defaultStoreURL) {
//            [fileManager copyItemAtURL:defaultStoreURL toURL:storeURL error:NULL];
//        }
//    }
    NSString* docs=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject];
    NSURL* storeURL=[NSURL fileURLWithPath:[docs stringByAppendingPathComponent:@"navigation.db"]];
    LOGINFO(@"path is %@",storeURL);
    NSError* error=nil;
    _persistentStoreCoordinator=[[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        LOGINFO(@"Error: %@,%@",error,[error userInfo]);
    }
    return _persistentStoreCoordinator;
}
-(NSURL *)applicationDocumentsDirectory
{
    NSURL* url = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
    LOGINFO(@"%@",url);
    return url;
}

@end
