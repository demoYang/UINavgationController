//
//  FirstViewController.m
//  UINavgationController
//
//  Created by niexin on 12-10-26.
//  Copyright (c) 2012年 niexin. All rights reserved.
//

#import "NavRootViewController.h"

#import "CoreDataViewController.h"
#import "FileManagerReadAndWriteViewController.h"

@interface NavRootViewController ()

@end

@implementation NavRootViewController


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
    self.title = @"root";
    
    UIButton* logoBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];//rect是必须的
    [logoBtn setImage:[UIImage imageNamed:@"logo.png"] forState:UIControlStateNormal];
    [logoBtn addTarget:self action:@selector(logoButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem* item = [[UIBarButtonItem alloc]initWithCustomView:logoBtn];//只有initWithCustomView才可以改变大小
    
    UIView* view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];//view也是可以的
    view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"logo.png"]];
    UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(logoViewTapped:)];
    [view addGestureRecognizer:tap];
    
    UILabel* _label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 80, 30)];
    _label.text = @"1383";
    _label.backgroundColor = [UIColor clearColor];
    _label.textColor = [UIColor redColor];
    _label.font = [UIFont systemFontOfSize:12];
    UIBarButtonItem* _item = [[UIBarButtonItem alloc]initWithCustomView:_label];
    
    self.navigationItem.leftBarButtonItems = [[NSArray alloc]initWithObjects:item, _item, nil];
    
    UIBarButtonItem* item1 = [[UIBarButtonItem alloc]initWithTitle:@"返回1" style:UIBarButtonItemStyleDone target:self action:@selector(backButtonPressed:)];//backBarButtonItem必须设置一个UIBarButtonItem才能修改标题，而且事件添加无效！且只有在上一个界面添加返回按钮
    self.navigationItem.backBarButtonItem = item1;
    
    //右键
    UIBarButtonItem* item2 = [[UIBarButtonItem alloc]initWithTitle:@"next"style:UIBarButtonItemStyleBordered target:self action:@selector(nextStep:)];
    self.navigationItem.rightBarButtonItem = item2;

    LOGINFO(NSLocalizedString(@"key", @""));
    
//    view 定义xib文件的方法
//        NSArray* array = [[NSBundle mainBundle]loadNibNamed:@"ItemView" owner:nil options:nil];
//        ItemView* tempView = [array objectAtIndex:0];

//#define __IPHONE_7_0
    
#ifdef __IPHONE_6_0
    
    LOGINFO(@"%@",@"this is ios 6.0");
    
#elif __IPHONE_5_0
    
    LOGINFO(@"%@",@"this is ios 5.0");
#elif __IPHONE_4_0
    
    LOGINFO(@"%@",@"this is ios 4.0");
#endif
    
#if TARGET_IPHONE_SIMULATOR
    NSLog(@"run on simulator");
#else
    NSLog(@"run on device");
#endif
    
    scrollView = [[UIScrollView alloc]initWithFrame:self.view.frame];
    
    
    [self.view addSubview:scrollView];
    
    NSInteger menuItemViewHight = 72;
    NSInteger menuItemViewWidth = 57;
    NSInteger upDownGap = 15;
    NSInteger leftRightGap = 18;
    
    NSArray* titleArray = [[NSArray alloc]initWithObjects:@"webView", @"transform", @"正则md5", @"drawrect", @"下拉刷新", @"CoreData", @"文件读写", @"SQLite", @"短信和邮件",@"分享", @"request", @"socket", nil];
    
    for (int i = 0; i < titleArray.count; i++) {
        NSInteger x = (i % 4) * (menuItemViewWidth + leftRightGap) + leftRightGap;
        NSInteger y = (i / 4) * (menuItemViewHight + upDownGap) + upDownGap;
        
        UIButton* itemBtn = [[UIButton alloc]initWithFrame:CGRectMake(x, y, menuItemViewWidth, menuItemViewHight)];
        itemBtn.tag = i;
        itemBtn.backgroundColor = [UIColor lightGrayColor];
        [itemBtn addTarget:self action:@selector(itemButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [itemBtn setImage:[UIImage imageNamed:@"logo.png"] forState:UIControlStateNormal];
        [itemBtn setImageEdgeInsets:UIEdgeInsetsMake(-10, 0, 10, 0)];
        [scrollView addSubview:itemBtn];
        
        UILabel* label = [[UILabel alloc]initWithFrame:CGRectMake(0, menuItemViewHight - 25, menuItemViewWidth, 20)];
        label.text = [titleArray objectAtIndex:i];
        label.textAlignment = UITextAlignmentCenter;
        label.backgroundColor = [UIColor clearColor];
        label.font = [UIFont systemFontOfSize:12];
        [itemBtn addSubview:label];
    }
}

-(void)viewWillAppear:(BOOL)animated{
    LOGINFO(@"%@",@"view will appear ");
    
   
    
}

-(void)viewWillDisappear:(BOOL)animated{
    LOGINFO(@"%@",@"view will disappear");
}

-(void)nextStep:(id)sender{
    
    
    
}
-(void)itemButtonPressed:(id)sender{
    LOGINFO(@"menu button pressed!!");
    NSInteger tag = ((UIButton*)sender).tag;
    switch (tag) {
        case 0:{
            WebViewViewController* second = [[WebViewViewController alloc]initWithNibName:@"WebViewViewController" bundle:nil];
            [self.navigationController pushViewController:second animated:YES];
        }
            break;
        case 1:{
            TransformViewController* lastView = [[TransformViewController alloc] initWithNibName:@"TransformViewController" bundle:nil];
            
            [self.navigationController pushViewController:lastView animated:YES];
        }
            break;
        case 2:{
            RegexAndMd5ViewController* lastView = [[RegexAndMd5ViewController alloc] initWithNibName:@"RegexAndMd5ViewController" bundle:nil];
            
            [self.navigationController pushViewController:lastView animated:YES];
        }
            break;
        case 3:{
            DrawRectViewController* fifthView = [[DrawRectViewController alloc] initWithNibName:@"DrawRectViewController" bundle:nil];
            
            [self.navigationController pushViewController:fifthView animated:YES];
        }
            break;
        case 4:{
            RefreshViewController* last = [[RefreshViewController alloc]initWithNibName:@"RefreshViewController" bundle:nil];
            
            [self.navigationController pushViewController:last animated:YES];
        }
            break;
        case 5:{
            CoreDataViewController* seventh = [[CoreDataViewController alloc] initWithNibName:nil bundle:nil];
            
            [self.navigationController pushViewController:seventh animated:YES];
        }
            break;
        case 6:{
            FileManagerReadAndWriteViewController* lastView = [[FileManagerReadAndWriteViewController alloc] initWithNibName:@"FileManagerReadAndWriteViewController" bundle:nil];
            
            [self.navigationController pushViewController:lastView animated:YES];
        }
            break;
        case 7:{
            SQLiteViewController* aqlite = [[SQLiteViewController alloc]initWithNibName:@"SQLiteViewController" bundle:nil];
            [self.navigationController pushViewController:aqlite animated:YES];
        }
            break;
        case 8:{
            SendMessageAndEMailViewController* ctl = [[SendMessageAndEMailViewController alloc]initWithNibName:@"SendMessageAndEMailViewController" bundle:nil];
            [self.navigationController pushViewController:ctl animated:YES];
        }
            break;
        case 9:{
            ShareTofaceBookViewController* ctl = [[ShareTofaceBookViewController alloc] initWithNibName: @"ShareTofaceBookViewController" bundle:nil];
            [self.navigationController pushViewController:ctl animated:YES];
        }
            break;
        case 10:{
            URLRequestViewController* ctl = [[URLRequestViewController alloc] init];
            [self.navigationController pushViewController:ctl animated:YES];
        }
            break;
        default:
            break;
    }
}
-(void)logoButtonPressed:(id)sender{
    LOGINFO(@"%@",@"logo button pressed!!");
    
    
    LOGINFO(@"%@", NSLocalizedString(@"key", @""));
    
}
-(void)backButtonPressed:(id)sender{
    LOGINFO(@"%@",@"back button pressed!!");
}
-(void)logoViewTapped:(id)sender{
    LOGINFO(@"%@",@"logo view tapped!!");
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(BOOL)shouldAutorotate{
    return YES;
}

-(NSUInteger)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskPortrait;
}

-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation{
    return toInterfaceOrientation == UIInterfaceOrientationPortrait;
}
@end
