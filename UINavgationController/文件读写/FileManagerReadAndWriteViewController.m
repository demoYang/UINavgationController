//
//  FileManagerReadAndWriteViewController.m
//  UINavgationController
//
//  Created by niexin on 12-12-20.
//  Copyright (c) 2012年 niexin. All rights reserved.
//

#import "FileManagerReadAndWriteViewController.h"

@interface FileManagerReadAndWriteViewController ()

@end

@implementation FileManagerReadAndWriteViewController

@synthesize label;

@synthesize button1;
@synthesize button2;
@synthesize button3;
@synthesize button4;

@synthesize textField1;
@synthesize textField2;
@synthesize textField3;
@synthesize textField4;

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
    self.title = @"文件读写";
    UIBarButtonItem* item = [[UIBarButtonItem alloc]initWithTitle:@"nextStep" style:UIBarButtonItemStyleDone target:self action:@selector(nextStep:)];
    self.navigationItem.rightBarButtonItem = item;
    
    fileManager = [NSFileManager defaultManager];
    
    [button1 setTitle:@"creat" forState:UIControlStateNormal];
    [button2 setTitle:@"delete" forState:UIControlStateNormal];
    [button3 setTitle:@"write" forState:UIControlStateNormal];
    [button4 setTitle:@"read" forState:UIControlStateNormal];
    
    [button1 addTarget:self action:@selector(fileManagerCreat) forControlEvents:UIControlEventTouchUpInside];
    [button2 addTarget:self action:@selector(fileManagerDelete) forControlEvents:UIControlEventTouchUpInside];
    [button3 addTarget:self action:@selector(fileManagerWrite) forControlEvents:UIControlEventTouchUpInside];
    [button4 addTarget:self action:@selector(fileManagerRead) forControlEvents:UIControlEventTouchUpInside];
    
    label.numberOfLines = 10;
    
}
-(void)nextStep:(id)sender{
    LastViewController* lastView = [[LastViewController alloc] initWithNibName:@"LastViewController" bundle:nil];
    
    [self.navigationController pushViewController:lastView animated:YES];
}
-(void)fileManagerCreat{
    //创建文件管理器

    //获取路径
    //参数NSDocumentDirectory要获取那种路径
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];//取出需要的路径
    LOGINFO(@"file manager path:%@",documentsDirectory);
    //更改到待操作的目录下
    [fileManager changeCurrentDirectoryPath:[documentsDirectory stringByExpandingTildeInPath]];
    
    //创建文件fileName文件名称，contents文件的内容，如果开始没有内容可以设置为nil，attributes文件的属性，初始为nil
    [textField1 resignFirstResponder];
    NSString* fileName = textField1.text;
    [fileManager createFileAtPath:fileName contents:nil attributes:nil];
    
}

-(void)fileManagerDelete{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];//去处需要的路径
    LOGINFO(@"file manager path:%@",documentsDirectory);
    [textField2 resignFirstResponder];
    NSString* fileName = textField2.text;
    //更改到待操作的目录下
    [fileManager changeCurrentDirectoryPath:[documentsDirectory stringByExpandingTildeInPath]];
    [fileManager removeItemAtPath:fileName error:nil];
}

-(void)fileManagerWrite{
    
    //参数NSDocumentDirectory要获取那种路径
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];//去处需要的路径
    LOGINFO(@"file manager path:%@",documentsDirectory);
    [textField3 resignFirstResponder];
    NSString* fileName = [[textField3.text componentsSeparatedByString:@","]objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:fileName];
    
    //待写入的数据
    NSString *temp = [[textField3.text componentsSeparatedByString:@","]objectAtIndex:1];
    
    
    //创建数据缓冲
    NSMutableData *writer = [[NSMutableData alloc] init];
    
    //将字符串添加到缓冲中
    [writer appendData:[temp dataUsingEncoding:NSUTF8StringEncoding]];
    
    //将其他数据添加到缓冲中
//    int data0 = 100000;
//    float data1 = 23.45f;
//    [writer appendBytes:&data0 length:sizeof(data0)];
//    [writer appendBytes:&data1 length:sizeof(data1)];
    
    
    //将缓冲的数据写入到文件中
    [writer writeToFile:path atomically:YES];

}

-(void)fileManagerRead{
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];//去处需要的路径
    [textField4 resignFirstResponder];
    NSString* fileName = textField4.text;
    NSString *path = [documentsDirectory stringByAppendingPathComponent:fileName];
    LOGINFO(@"file manager path:%@",documentsDirectory);

    NSString *gData2;
    
    NSData *reader = [NSData dataWithContentsOfFile:path];
    gData2 = [[NSString alloc] initWithData:reader encoding:NSUTF8StringEncoding];
    
    label.text = gData2;
    
    //    读取工程中的文件：
    //    读取数据时，要看待读取的文件原有的文件格式，是字节码还是文本，我经常需要重文件中读取字节码，所以我写的是读取字节文件的方式。
    //用于存放数据的变量，因为是字节，所以是ＵInt8
    
    //获取字节的个数
    int length = [reader length];
    LOGINFO(@"——->bytesLength:%d", length);
    for(int i = 0; i < length; i++) { //读取数据 [reader getBytes:&b range:NSMakeRange(i, sizeof(b))]; LOGINFO(@”——–>data%d:%d”, i, b);
        
    }
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
