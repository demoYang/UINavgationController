//
//  LastViewController.h
//  UINavgationController
//
//  Created by niexin on 12-10-26.
//  Copyright (c) 2012年 niexin. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BaseViewController.h"



@interface LastViewController : BaseViewController<UIWebViewDelegate, UITextFieldDelegate>{
    
    NSString* webContent;
    
    BOOL canAutorotate;
    
    UITextField* textFields;
    UIButton* btn;
    
    
    
}
@end
