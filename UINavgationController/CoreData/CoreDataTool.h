//
//  CoreDataTool.h
//  UINavgationController
//
//  Created by 张鑫 on 14-6-22.
//  Copyright (c) 2014年 niexin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "PrintLog.h"

@interface CoreDataTool : NSObject{
    
}

@property(strong,nonatomic,readonly)NSManagedObjectModel* managedObjectModel;

@property(strong,nonatomic,readonly)NSManagedObjectContext* managedObjectContext;

@property(strong,nonatomic,readonly)NSPersistentStoreCoordinator* persistentStoreCoordinator;



+(CoreDataTool*)shareInstance;

@end
