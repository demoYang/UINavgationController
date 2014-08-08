//
//  FifthViewController.m
//  UINavgationController
//
//  Created by niexin on 12-11-8.
//  Copyright (c) 2012年 niexin. All rights reserved.
//

#import "DrawRectViewController.h"

@interface DrawRectViewController (){
    DrawView* drawView;
}

@end

@implementation DrawRectViewController

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
    self.title = @"DrawView";
    

    
    CGRect rect = self.view.bounds;
    rect.size.height -= 160;
    drawView = [[DrawView alloc]initWithFrame:rect];
    drawView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:drawView];
    
    NSArray* titles = [[NSArray alloc]initWithObjects:@"线图", @"圆形", @"文字", @"渐变色", @"路径", @"图片", @"艺术字",@"圆图" , nil];
    for (int i = 0; i < titles.count; i++) {
        
        NSString* title = [titles objectAtIndex:i];
        UIButton* btn = [[UIButton alloc]initWithFrame:CGRectMake(i % 5 * 61 + 11, rect.size.height + (i / 5) * 40, 50, 30)];
        btn.tag = i;
        btn.titleLabel.font = [UIFont systemFontOfSize:13];
        btn.backgroundColor = [UIColor redColor];
        [btn setTitle:title forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(drawImageRect:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.view addSubview:btn];
    }
    // Do any additional setup after loading the view from its nib.
}

-(void)drawImageRect:(id)sender{
    drawView.type = ((UIButton*)sender).tag;
    [drawView setNeedsDisplay];
}

-(void)saveDrowImage:(id)sender{
    UIGraphicsBeginImageContext(drawView.bounds.size);
    [drawView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    NSData* data = [NSData data];
    if (UIImagePNGRepresentation(image) == nil) {
        data = UIImageJPEGRepresentation(image, 1);
    } else {
        data = UIImagePNGRepresentation(image);
    }
    if (data) {
        NSString* imageName = @"browse_look0.png";
        
        NSArray *pathArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask,YES);
        NSString *downLoadDirectory = [pathArray objectAtIndex:0];
        NSString *iconDataPath = [downLoadDirectory stringByAppendingPathComponent:imageName];
        
        
        if ([[NSFileManager defaultManager]fileExistsAtPath:iconDataPath]) {
            LOGINFO(@"%@",@"file has existes");
        }
        
        BOOL rt = [data writeToFile:iconDataPath atomically:YES];
        if (rt) {
            LOGINFO(@"Picture Saved %@",iconDataPath);
        }else{
            UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"" message:@"picture saved false" delegate:self cancelButtonTitle:@"" otherButtonTitles: nil];
            [alert show];
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
