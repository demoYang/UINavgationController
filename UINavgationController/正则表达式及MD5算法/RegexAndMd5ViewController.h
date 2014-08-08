//
//  FourthViewController.h
//  UINavgationController
//
//  Created by niexin on 12-11-7.
//  Copyright (c) 2012年 niexin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DrawRectViewController.h"
#import "BaseViewController.h"

@interface RegexAndMd5ViewController : BaseViewController<UITextViewDelegate>{
    
    UITextView* md5TextView;
    UIButton* md5Button;
    UILabel* label1;
    UILabel* label2;
}
@property (nonatomic , strong)IBOutlet UILabel* label1;
@property (nonatomic , strong)IBOutlet UILabel* label2;
@property (nonatomic , strong)IBOutlet UITextView* md5TextView;
@property (nonatomic , strong)IBOutlet UIButton* md5Button;


-(IBAction)md5ButtonPredded:(id)sender;
@end

