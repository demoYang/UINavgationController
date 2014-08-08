//
//  FileManagerReadAndWriteViewController.h
//  UINavgationController
//
//  Created by niexin on 12-12-20.
//  Copyright (c) 2012年 niexin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LastViewController.h"
#import "BaseViewController.h"

@interface FileManagerReadAndWriteViewController : BaseViewController<UITextFieldDelegate>{
    NSFileManager* fileManager;
    
    UILabel* label;
    
    UITextField* textField1;
    UITextField* textField2;
    UITextField* textField3;
    UITextField* textField4;
    
    UIButton* button1;
    UIButton* button2;
    UIButton* button3;
    UIButton* button4;
}

@property (strong , nonatomic) IBOutlet UILabel* label;

@property (strong , nonatomic) IBOutlet UITextField* textField1;
@property (strong , nonatomic) IBOutlet UITextField* textField2;
@property (strong , nonatomic) IBOutlet UITextField* textField3;
@property (strong , nonatomic) IBOutlet UITextField* textField4;

@property (strong , nonatomic) IBOutlet UIButton* button1;
@property (strong , nonatomic) IBOutlet UIButton* button2;
@property (strong , nonatomic) IBOutlet UIButton* button3;
@property (strong , nonatomic) IBOutlet UIButton* button4;


@end
