//
//  BaseViewController.m
//  UINavgationController
//
//  Created by 张鑫 on 14-6-15.
//  Copyright (c) 2014年 niexin. All rights reserved.
//

#import "BaseViewController.h"
#import "LastViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
#if __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_6_1
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
    {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.extendedLayoutIncludesOpaqueBars = NO;
        self.modalPresentationCapturesStatusBarAppearance = NO;
    }
#endif
    self.view.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
    
    UIBarButtonItem* item = [[UIBarButtonItem alloc]initWithTitle:@"nextStep" style:UIBarButtonItemStyleDone target:self action:@selector(nextStep:)];
    self.navigationItem.rightBarButtonItem = item;
    
    // Do any additional setup after loading the view.
}

-(void)nextStep:(id)sender{
    LastViewController* lastView = [[LastViewController alloc] initWithNibName:@"LastViewController" bundle:nil];
    
    [self.navigationController pushViewController:lastView animated:YES];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    

    
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
