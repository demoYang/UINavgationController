//
//  ThirdViewController.h
//  UINavgationController
//
//  Created by niexin on 12-11-7.
//  Copyright (c) 2012年 niexin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "RegexAndMd5ViewController.h"
#import "BaseViewController.h"

@interface TransformViewController : BaseViewController{
    UILabel* label1;
    UILabel* label2;
    UIButton* button;

    CALayer* layer;
}
@property(nonatomic ,strong) IBOutlet UIButton* button;
@property(nonatomic ,strong) IBOutlet UILabel* label1;
@property(nonatomic ,strong) IBOutlet UILabel* label2;

-(IBAction)buttonPressed:(id)sender;
@end
