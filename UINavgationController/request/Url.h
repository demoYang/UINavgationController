//
//  Url.h
//  UINavgationController
//
//  Created by 张鑫 on 14-7-12.
//  Copyright (c) 2014年 niexin. All rights reserved.
//

#ifndef UINavgationController_Url_h
#define UINavgationController_Url_h



#endif


#import <Foundation/Foundation.h>
//#import "HxOther.h"
//#import "HXImage.h"
//#define HX_HTTP_IDP_SERVER //注意：！！此宏打开表示用得是开发服务器 206或者205 关闭此宏用得时外网服务器

#ifdef  HX_HTTP_IDP_SERVER
#define HX_HTTP_SERVER  @"http://10.20.34.206:8080/xhplant/"  // 114.215.108.158   10.20.34.206:8080
#define SIP_ID_SERVER   @"10.20.34.12"
#define SIP_DATA_SERVER @"http://10.20.34.50/voices/public/index/"
#else
#define HX_HTTP_SERVER  @"http://114.215.108.158:8080/xhplant/"  // 114.215.108.158   10.20.34.206:8080
#define SIP_ID_SERVER   @"42.96.190.17"
#define SIP_DATA_SERVER @"http://115.28.55.68/voices/public/index/"
#endif

//银联支付
#define API_GetPayFees  [NSString stringWithFormat:@"%@%@",HX_HTTP_SERVER,@"PatientClient/Control.do"]//@"http://10.20.34.206:8080/xhplant/PatientClient/Control.do"

//获取注册验证码
#define API_GetControl  [NSString stringWithFormat:@"%@%@",HX_HTTP_SERVER,@"CommonClient/Control.do"]//@"http://10.20.34.206:8080/xhplant/CommonClient/Control.do"

//获取注册验证码
#define API_GetDoctorControl  [NSString stringWithFormat:@"%@%@",HX_HTTP_SERVER,@"DoctorClient/Control.do"]//@"http://10.20.34.206:8080/xhplant/DoctorClient/Control.do"

//图片地址
#define API_ImageUrl [NSString stringWithFormat:@"%@%@",HX_HTTP_SERVER,@"File/LeavemessageDownLoad.do?fileName="]//@"http://10.20.34.206:8080/xhplant/File/LeavemessageDownLoad.do?fileName="

//患者图片地址
#define API_PatientImageUrl [NSString stringWithFormat:@"%@%@",HX_HTTP_SERVER,@"File/PatientDownLoad.do?fileName="]//@"http://10.20.34.206:8080/xhplant/File/PatientDownLoad.do?fileName="

//医生图片地址
#define API_DoctorImageUrl [NSString stringWithFormat:@"%@%@",HX_HTTP_SERVER,@"File/DoctorDownLoad.do?fileName="]//@"http://10.20.34.206:8080/xhplant/File/DoctorDownLoad.do?fileName="

// 医生圈心情下载图片
#define API_DoctorWeiboImageUrl [NSString stringWithFormat:@"%@%@",HX_HTTP_SERVER,@"File/doctorweiboDownLoad.do?fileName="]//@"http://10.20.34.206:8080/xhplant/File/doctorweiboDownLoad.do?fileName="

//科室图片
#define API_Department_ImageUrl [NSString stringWithFormat:@"%@%@",HX_HTTP_SERVER,@"File/RoomPictureDownLoad.do?fileName="]
//http://115.28.55.68/voices/public/index/sendstrmsg
//http://115.28.55.68/voices/public/index/list
//http://115.28.55.68/voices/public/index/upload


//发送sip离线消息
#define SendHistoryMessage  [NSString stringWithFormat:@"%@%@",SIP_DATA_SERVER,@"sendstrmsg"]
//获得sip离线消息
#define GetHistoryMessage   [NSString stringWithFormat:@"%@%@",SIP_DATA_SERVER,@"list"]
//SIP发送DATA数据
#define SendDataMessage     [NSString stringWithFormat:@"%@%@",SIP_DATA_SERVER,@"upload"]
#define MAIN_THREAD(block) dispatch_async(dispatch_get_main_queue(),^(void){b




                                 
                                 
                                 
                                 
                                 
