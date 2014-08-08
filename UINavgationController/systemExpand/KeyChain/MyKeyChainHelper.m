

#import "MyKeyChainHelper.h"

@implementation MyKeyChainHelper

+ (NSMutableDictionary *)getKeyChainQuery:(NSString *)service {  
    return [NSMutableDictionary dictionaryWithObjectsAndKeys:  
            (__bridge id)kSecClassGenericPassword,(__bridge id)kSecClass,
            service, (__bridge id)kSecAttrService,  
            service, (__bridge id)kSecAttrAccount,  
            (__bridge id)kSecAttrAccessibleAfterFirstUnlock,(__bridge id)kSecAttrAccessible,  
            nil];
}

+ (void) saveUserName:(NSString*)userName 
      userNameService:(NSString*)userNameService 
             psaaword:(NSString*)pwd 
      psaawordService:(NSString*)pwdService
{
    NSMutableDictionary *keychainQuery = [self getKeyChainQuery:userNameService];  
    SecItemDelete((__bridge CFDictionaryRef)keychainQuery);  
    [keychainQuery setObject:[NSKeyedArchiver archivedDataWithRootObject:userName] forKey:(__bridge id)kSecValueData];  
    SecItemAdd((__bridge CFDictionaryRef)keychainQuery, NULL); 
    
    keychainQuery = [self getKeyChainQuery:pwdService];  
    SecItemDelete((__bridge CFDictionaryRef)keychainQuery);  
    [keychainQuery setObject:[NSKeyedArchiver archivedDataWithRootObject:pwd] forKey:(__bridge id)kSecValueData];  
    SecItemAdd((__bridge CFDictionaryRef)keychainQuery, NULL); 
}

+ (void) deleteWithUserNameService:(NSString*)userNameService 
                   psaawordService:(NSString*)pwdService
{
    NSMutableDictionary *keychainQuery = [self getKeyChainQuery:userNameService];  
    SecItemDelete((__bridge CFDictionaryRef)keychainQuery); 
    
    keychainQuery = [self getKeyChainQuery:pwdService];  
    SecItemDelete((__bridge CFDictionaryRef)keychainQuery); 
}
+ (NSString*) getUserNameWithService:(NSString*)userNameService
{
    NSString* ret = nil;  
    NSMutableDictionary *keychainQuery = [self getKeyChainQuery:userNameService];  
    [keychainQuery setObject:(id)kCFBooleanTrue forKey:(__bridge id)kSecReturnData];  
    [keychainQuery setObject:(__bridge id)kSecMatchLimitOne forKey:(__bridge id)kSecMatchLimit];  
    CFDataRef keyData = NULL;  
    if (SecItemCopyMatching((__bridge CFDictionaryRef)keychainQuery, (CFTypeRef *)&keyData) == noErr) 
    {  
        @try 
        {  
            ret = [NSKeyedUnarchiver unarchiveObjectWithData:(__bridge NSData *)keyData];  
        } 
        @catch (NSException *e) 
        {  
            NSLog(@"Unarchive of %@ failed: %@", userNameService, e);  
        }
        @finally 
        {  
        }  
    }  
    if (keyData)   
        CFRelease(keyData);  
    return ret; 
}

+ (NSString*) getPasswordWithService:(NSString*)pwdService
{
    NSString* ret = nil;  
    NSMutableDictionary *keychainQuery = [self getKeyChainQuery:pwdService];  
    [keychainQuery setObject:(id)kCFBooleanTrue forKey:(__bridge id)kSecReturnData];  
    [keychainQuery setObject:(__bridge id)kSecMatchLimitOne forKey:(__bridge id)kSecMatchLimit];  
    CFDataRef keyData = NULL;  
    if (SecItemCopyMatching((__bridge CFDictionaryRef)keychainQuery, (CFTypeRef *)&keyData) == noErr) 
    {  
        @try 
        {  
            ret = [NSKeyedUnarchiver unarchiveObjectWithData:(__bridge NSData *)keyData];  
        } 
        @catch (NSException *e) 
        {  
            NSLog(@"Unarchive of %@ failed: %@", pwdService, e);  
        }
        @finally 
        {  
        }  
    }  
    if (keyData)   
        CFRelease(keyData);  
    return ret;
}














//-(void)readKeyChain{
//    NSString* accessGroup = @"";
//    NSString* identifier = @"";
//    NSMutableDictionary* genericPasswordQuery = [[NSMutableDictionary alloc] init];
//    [genericPasswordQuery setObject:(__bridge id)kSecClassGenericPassword forKey:(__bridge id)kSecClass];//1
//    [genericPasswordQuery setObject:identifier forKey:(__bridge id)kSecAttrGeneric];//2
//    if (accessGroup != nil){
//        [genericPasswordQuery setObject:accessGroup forKey:(__bridge id)kSecAttrAccessGroup];//3
//    }
//    [genericPasswordQuery setObject:(__bridge id)kSecMatchLimitOne forKey:(__bridge id)kSecMatchLimit];//4
//    [genericPasswordQuery setObject:(id)kCFBooleanTrue forKey:(__bridge id)kSecReturnAttributes];//5
//    
//    
//    NSDictionary *tempQuery = [NSDictionary dictionaryWithDictionary:genericPasswordQuery];
//    
//    CFDataRef keyData = NULL;
//    
//    if (SecItemCopyMatching((__bridge CFDictionaryRef)tempQuery, (CFTypeRef*)&keyData) == noErr){//6
//        //found and outDicitionary is not nil
//        
//        
//        @try
//        {
//            NSString* ret = [NSKeyedUnarchiver unarchiveObjectWithData:(__bridge NSData *)keyData];
//            NSLog(@"%@",ret);
//        }
//        @catch (NSException *e)
//        {
//            NSLog(@"Unarchive of %@ failed: %@", @"", e);
//        }
//        @finally
//        {
//        }
//        
//        
//    }else{
//        //not found
//    }
//    //    1.设置Class值，每个Class对应的都有不同的参数类型
//    //    2.用户确定的参数，一般是程序中使用的类别，比如说是"Password"或"Account Info"，作为search的主力条件
//    //    3.设置Group,如果不同程序都拥有这个组，那么不同程序间可以共享这个组的数据
//    //    4.只返回第一个匹配数据，查询方法使用，还有值kSecMatchLimitAll
//    //    5.返回数据为CFDicitionaryRef，查询方法使用
//    //    6.执行查询方法，判断返回值
//    //eg:这个是none-ARC的代码哦！ARC情况下会有bridge提示。
//}

//- (void)writeToKeychain
//{
//    NSDictionary *attributes = NULL;
//    NSMutableDictionary *updateItem = NULL;
//    OSStatus result;
//    //判断是增还是改
//    if (SecItemCopyMatching((CFDictionaryRef)genericPasswordQuery, (CFTypeRef *)&attributes) == noErr)
//    {
//        // First we need the attributes from the Keychain.
//        updateItem = [NSMutableDictionary dictionaryWithDictionary:attributes];
//        // Second we need to add the appropriate search key/values.
//        [updateItem setObject:[genericPasswordQuery objectForKey:(id)kSecClass] forKey:(id)kSecClass];
//        // Lastly, we need to set up the updated attribute list being careful to remove the class.
//        NSMutableDictionary *tempCheck = [self dictionaryToSecItemFormat:keychainItemData];
//        //删除kSecClass update不能update该字段，否则会报错
//        [tempCheck removeObjectForKey:(__bridge id)kSecClass];
//        //参数1表示search的，参数2表示需要更新后的值
//        result = SecItemUpdate((__bridge CFDictionaryRef)updateItem, (__bridge CFDictionaryRef)tempCheck);
//    }else{
//        //增加
//        result = SecItemAdd((CFDictionaryRef)[self dictionaryToSecItemFormat:keychainItemData], NULL);
//    }
//}

//data to secItem
//- (NSMutableDictionary *)dictionaryToSecItemFormat:(NSDictionary *)dictionaryToConvert
//{
//    // Create a dictionary to return populated with the attributes and data.
//    NSMutableDictionary *returnDictionary = [NSMutableDictionary dictionaryWithDictionary:dictionaryToConvert];
//    
//    //设置kSecClass
//    [returnDictionary setObject:(__bridge id)kSecClassGenericPassword forKey:(__bridge id)kSecClass];
//    //将Dictionary里的kSecValueData(一般就是这个keyChain里主要内容，比如说是password),NSString转换成NSData
//    NSString *passwordString = [dictionaryToConvert objectForKey:(__bridge id)kSecValueData];
//    [returnDictionary setObject:[passwordString dataUsingEncoding:NSUTF8StringEncoding] forKey:(__bridge id)kSecValueData];
//    return returnDictionary;
//}

//secItem to data
//- (NSMutableDictionary *)secItemFormatToDictionary:(NSDictionary *)dictionaryToConvert
//{
//    NSMutableDictionary *returnDictionary = [NSMutableDictionary dictionaryWithDictionary:dictionaryToConvert];
//    
//    // Add the proper search key and class attribute.
//    [returnDictionary setObject:(id)kCFBooleanTrue forKey:(__bridge id)kSecReturnData];
//    [returnDictionary setObject:(__bridge id)kSecClassGenericPassword forKey:(__bridge id)kSecClass];
//    
//    // Acquire the password data from the attributes.
//    NSData *passwordData = NULL;
//    if (SecItemCopyMatching((__bridge CFDictionaryRef)returnDictionary, (CFTypeRef *)&passwordData) == noErr)
//    {
//        // 删除多余的kSecReturnData数据
//        [returnDictionary removeObjectForKey:(__bridge id)kSecReturnData];
//        
//        // 对应前面的步骤，将数据从NSData转成NSString
//        NSString *password = [[NSString alloc] initWithBytes:[passwordData bytes] length:[passwordData length]
//                                                     encoding:NSUTF8StringEncoding];
//        [returnDictionary setObject:password forKey:(__bridge id)kSecValueData];
//    }
//    else
//    {
//        NSAssert(NO, @"Serious error, no matching item found in the keychain.\n");
//    }
//    return returnDictionary;
//}


@end
