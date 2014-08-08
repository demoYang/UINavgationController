//
//  LastViewController.m
//  UINavgationController
//
//  Created by niexin on 12-10-26.
//  Copyright (c) 2012年 niexin. All rights reserved.
//

#import "LastViewController.h"
#import "UILabel-LineHeigh.h"

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]


@interface LastViewController ()

@end

@implementation LastViewController
-(UIColor*)getColorWithRGB:(NSString*)RGB{
    
    if (!RGB) {
        return [UIColor clearColor];
    }
    while (RGB.length < 6) {
        RGB = [RGB stringByAppendingString:@"0"];
    }
    float red = strtoul([[RGB substringToIndex:2] UTF8String],0,16);
    float green = strtoul([[RGB substringWithRange:NSMakeRange(2, 2)] UTF8String],0,16);
    float blue = strtoul([[RGB substringFromIndex:4] UTF8String],0,16);
    UIColor * color = [UIColor colorWithRed:red/255.0f green:green/255.0f blue:blue/255.0f alpha:1];
    return color;
    
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    static NSString * weekPosFmt   = @"c";//@"e"和@"c"是相同的，星期天都是一周的开始，返回1；
    
//    NSArray *weekDayArray = @[STR_SUNDAY,STR_MONDAY,STR_TUESDAY,STR_WEDNESDAY,STR_THURSDAY,STR_FRIDAY,STR_SATURDAY];
    
    [dateFormatter setDateFormat:weekPosFmt];
    NSString * temp = [dateFormatter stringFromDate:[NSDate date]];
    int     tempPos = [temp intValue] - 1;
    
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
            canAutorotate = NO;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"last View Controller";
    
//    [UIApplication sharedApplication].statusBarOrientation = UIInterfaceOrientationLandscapeRight;
//    self.navigationController.navigationBarHidden = YES;
//    [UIApplication sharedApplication].statusBarHidden = YES;
//    self.view.transform = CGAffineTransformMakeRotation(M_PI / 2);
    
   
//    UIButton* btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
//    [btn setImage:[UIImage imageNamed:@"logo.png"] forState:UIControlStateNormal];
//    UIBarButtonItem* item = [[UIBarButtonItem alloc]initWithCustomView:btn];
    

//    UIBarButtonItem* item = [[UIBarButtonItem alloc]initWithTitle:@"11" style:UIBarButtonItemStyleBordered target:self action:@selector(aa)];
//    self.navigationItem.leftBarButtonItem = item;
    
//    self.navigationItem.hidesBackButton = NO;
//    NSArray* tempArray = self.navigationController.viewControllers;
//    NSArray* navList = [[NSArray alloc]initWithObjects:[tempArray objectAtIndex:0],tempArray.lastObject, nil];
//    [self.navigationController setViewControllers:navList];
    
    //item按下是会有高亮效果的
    UIToolbar *tools = [[UIToolbar alloc]initWithFrame: CGRectMake(0.0f, 0.0f, 44.0f, 44.01f)]; // 44.01 shifts it up 1px for some reason
    tools.clipsToBounds = NO;
    tools.backgroundColor = [UIColor clearColor];
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(updateNewsBtnPressed:)];
    [tools setItems:[NSArray arrayWithObject:item]];
    UIBarButtonItem *updateBtn = [[UIBarButtonItem alloc]initWithCustomView:tools];
    [self.navigationItem setRightBarButtonItem:updateBtn];
    
    UIButton* channelBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 20)];
    [channelBtn setBackgroundImage:[UIImage imageNamed:@"dragDown.png"] forState:UIControlStateNormal];
    [channelBtn setBackgroundImage:[UIImage imageNamed:@"logo.png.png"] forState:UIControlStateHighlighted];
    [channelBtn setBackgroundImage:[UIImage imageNamed:@"dragUp.png"] forState:UIControlStateSelected];
    [channelBtn setBackgroundImage:[UIImage imageNamed:@"paletta_icon.png"] forState:UIControlStateSelected | UIControlStateHighlighted];
    [channelBtn addTarget:self action:@selector(btnSelected:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:channelBtn];
    
    
    UIButton* purchaseBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 50, 40, 20)];
    [purchaseBtn setBackgroundImage:[UIImage imageNamed:@"dragUp.png"] forState:UIControlStateNormal];
    [purchaseBtn setBackgroundImage:[UIImage imageNamed:@"logo.png.png"] forState:UIControlStateHighlighted];
    [purchaseBtn setBackgroundImage:[UIImage imageNamed:@"dragDown.png"] forState:UIControlStateSelected];
    [purchaseBtn setBackgroundImage:[UIImage imageNamed:@"paletta_icon.png"] forState:UIControlStateReserved];
    [purchaseBtn addTarget:self action:@selector(btnSelected:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:purchaseBtn];
    
    UITextField* asdf = [[UITextField alloc]initWithFrame:CGRectMake(10, 100, 60,30)];
    asdf.backgroundColor = [UIColor redColor];
    [self.view addSubview:asdf];
    
    
    UIImage* image = [[UIImage imageNamed:@"bubble_blue_recieve_doctor.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(53.0f,34.0f,20.0f,34.0f)];
    UIImageView* imageview = [[UIImageView alloc]initWithImage:image];
    imageview.frame = CGRectMake(100, 100, 100, 70);
    [self.view addSubview:imageview];
}

-(void)btnSelected:(id)sender{

    
    ((UIButton*)sender).selected = !((UIButton*)sender).selected;
    UIWindow* keyWindow = [[UIApplication sharedApplication].delegate window];
    LOGINFO(@"111111   width :%f === height :%f",keyWindow.rootViewController.view.frame.size.width,keyWindow.rootViewController.view.frame.size.height);
    LOGINFO(@"222222   width :%f === height :%f",keyWindow.rootViewController.view.bounds.size.width,keyWindow.rootViewController.view.bounds.size.height);
}


-(void)updateNewsBtnPressed:(id)sender{
    
    
    LOGINFO(@"%@",@"updateNewsBtnPressed");
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)backAction:(id)sender{
    
    
    
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)tapAction:(id)sender{
    
    
    [UIApplication sharedApplication].statusBarHidden = YES;
    
    
}
             




-(void)viewWillDisappear:(BOOL)animated{
//    [UIApplication sharedApplication].statusBarHidden = NO;
//    self.navigationController.navigationBarHidden = NO;
}


-(void)viewWillAppear:(BOOL)animated{
    LOGINFO(@"viewWillAppear");
}

-(void)viewDidAppear:(BOOL)animated{
    LOGINFO(@"viewDidAppear");
//    [UIApplication sharedApplication].statusBarHidden = NO;
    canAutorotate = YES;
    
    
}





-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField{
//    textField.inputView.transform = CGAffineTransformMakeRotation(M_PI / 2);
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
//    textField.inputView.transform = CGAffineTransformMakeRotation(M_PI / 2);
    return YES;
}


-(BOOL)shouldAutorotate{
    return canAutorotate;
}

-(NSUInteger)supportedInterfaceOrientations{
    
    if (canAutorotate && ([UIDevice currentDevice].orientation == UIDeviceOrientationLandscapeLeft ||
        [UIDevice currentDevice].orientation == UIDeviceOrientationLandscapeRight)) {
        
        
        

        
//        self.view.transform = CGAffineTransformMakeRotation(0);
//        self.view.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width);
        
    }
    
    
    return UIInterfaceOrientationMaskLandscape;
}

-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation{
    return toInterfaceOrientation == UIInterfaceOrientationPortrait;
}







@end
