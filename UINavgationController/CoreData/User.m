//
//  User.m
//  UINavgationController
//
//  Created by 张鑫 on 14-6-22.
//  Copyright (c) 2014年 niexin. All rights reserved.
//

#import "User.h"
#import "CoreDataTool.h"

@implementation User

@dynamic userName;
@dynamic password;
@dynamic age;
@dynamic sex;


//插入数据
+ (BOOL)add:(NSString*)name password:(NSString*)pwd age:(NSInteger)age sex:(NSString*)sex {
    User* user = (User *)[NSEntityDescription insertNewObjectForEntityForName:@"User" inManagedObjectContext:[CoreDataTool shareInstance].managedObjectContext];
    [user setUserName:name];
    [user setPassword:pwd];
    [user setAge:[NSNumber numberWithInteger:age]];
    [user setSex:sex];
    NSError* error;
    BOOL isSaveSuccess=[[CoreDataTool shareInstance].managedObjectContext save:&error];
    if (!isSaveSuccess) {
        LOGINFO(@"Error:%@",error);
    }else{
        LOGINFO(@"Save successful!");
    }
    return isSaveSuccess;
}
//查询
+ (NSMutableArray*)query:(id)sender {
    NSFetchRequest* request = [[NSFetchRequest alloc] init];
    NSEntityDescription* user = [NSEntityDescription entityForName:@"User" inManagedObjectContext:[CoreDataTool shareInstance].managedObjectContext];
    [request setEntity:user];

    NSSortDescriptor* sortDescriptor=[[NSSortDescriptor alloc] initWithKey:@"userName" ascending:NO];
    NSArray* sortDescriptions=[[NSArray alloc] initWithObjects:sortDescriptor, nil];
    [request setSortDescriptors:sortDescriptions];
    
    NSPredicate* predicate=[NSPredicate predicateWithFormat:@"Z_PK=%@",@"2"];
    [request setPredicate:predicate];
    
//    NSPredicate *predicateTemplate = [NSPredicate predicateWithFormat:
//                                      @"(mainAuthor.firstName like[cd] $FIRST_NAME) AND \
//                                      (mainAuthor.lastName like[cd] $LAST_NAME) AND \
                                      (publicationDate > $DATE)"];
    
    NSError* error=nil;
    NSMutableArray* mutableFetchResult=[[[CoreDataTool shareInstance].managedObjectContext executeFetchRequest:request error:&error] mutableCopy];
    if (mutableFetchResult == nil) {
        LOGINFO(@"Error:%@",error);
        return nil;
    }
    LOGINFO(@"The count of entry: %i",[mutableFetchResult count]);
    for (User* user in mutableFetchResult) {
        LOGINFO(@"name:%@+---age:%@------sex:%@",user.userName,user.age,user.sex);
    }
    return mutableFetchResult;
}
//更新
+ (BOOL)update:(id)sender {
    NSFetchRequest* request=[[NSFetchRequest alloc] init];
    NSEntityDescription* user=[NSEntityDescription entityForName:@"User" inManagedObjectContext:[CoreDataTool shareInstance].managedObjectContext];
    [request setEntity:user];
    //查询条件
    NSPredicate* predicate=[NSPredicate predicateWithFormat:@"name==%@",@"chen"];
    [request setPredicate:predicate];
    NSError* error=nil;
    NSMutableArray* mutableFetchResult=[[[CoreDataTool shareInstance].managedObjectContext executeFetchRequest:request error:&error] mutableCopy];
    if (mutableFetchResult==nil) {
        LOGINFO(@"Error:%@",error);
    }
    LOGINFO(@"The count of entry: %i",[mutableFetchResult count]);
    //更新age后要进行保存，否则没更新
    for (User* user in mutableFetchResult) {
        [user setAge:[NSNumber numberWithInt:12]];
    }
    return [[CoreDataTool shareInstance].managedObjectContext save:&error];
}
//删除
+ (BOOL)del:(id)sender {
    NSFetchRequest* request=[[NSFetchRequest alloc] init];
    NSEntityDescription* user=[NSEntityDescription entityForName:@"User" inManagedObjectContext:[CoreDataTool shareInstance].managedObjectContext];
    [request setEntity:user];
    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"name==%@",@"chen"];
    [request setPredicate:predicate];
    NSError* error=nil;
    NSMutableArray* mutableFetchResult=[[[CoreDataTool shareInstance].managedObjectContext executeFetchRequest:request error:&error] mutableCopy];
    if (mutableFetchResult==nil) {
        LOGINFO(@"Error:%@",error);
    }
    LOGINFO(@"The count of entry: %i",[mutableFetchResult count]);
    for (User* user in mutableFetchResult) {
        [[CoreDataTool shareInstance].managedObjectContext deleteObject:user];
    }
    
    if ([[CoreDataTool shareInstance].managedObjectContext save:&error]) {
        LOGINFO(@"Error:%@,%@",error,[error userInfo]);
        return YES;
    }
    return NO;
}

@end
