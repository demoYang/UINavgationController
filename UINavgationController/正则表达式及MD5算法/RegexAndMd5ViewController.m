//
//  FourthViewController.m
//  UINavgationController
//
//  Created by niexin on 12-11-7.
//  Copyright (c) 2012年 niexin. All rights reserved.
//

#import "RegexAndMd5ViewController.h"
#import "NSString-expand.h"


@interface RegexAndMd5ViewController ()

@end

@implementation RegexAndMd5ViewController

@synthesize label1;
@synthesize label2;
@synthesize md5Button;
@synthesize md5TextView;

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
    self.title = @"正则表达式";
    
    
    UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
    [self.view addGestureRecognizer:tap];
    
    [self checkRegularString];
    [self getSubstringUsingRegular];
}

-(void)checkRegularString{
    //the methord for ios4.0
    NSString* email = @"366898509@qq.com";
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    BOOL ismail = [emailTest evaluateWithObject:email];
    if (ismail) {
        label2.text = @"it is a Email address!";
    }
}
//解析出一个字符串里面，符合表达式的字串
-(void)getSubstringUsingRegular{
    //@"http+:[^\\s]*"    解析网址表达式
    
    //组装一个字符串，把里面的网址解析出来
    NSString *urlString = @"sfdshttp://www.百baidu.com";
    NSError *error;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"http+:[^\\s]*" options:0 error:&error];
    if (regex != nil) {
        NSTextCheckingResult *matchRange = [regex firstMatchInString:urlString options:0 range:NSMakeRange(0, [urlString length])];
        
        if (matchRange) {
            for (int i = 0; i < matchRange.numberOfRanges; i++) {
                NSRange resultRange = [matchRange rangeAtIndex:i];
                //从urlString中截取数据
                NSString *result = [urlString substringWithRange:resultRange];
                LOGINFO(@"%@",result);
                label1.text = result;
            }
        }
    }
}

+(NSString *)disable_emoji:(NSString *)text
{
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"[^\\u0020-\\u007E\\u00A0-\\u00BE\\u2E80-\\uA4CF\\uF900-\\uFAFF\\uFE30-\\uFE4F\\uFF00-\\uFFEF\\u0080-\\u009F\\u2000-\\u201f\r\n]" options:NSRegularExpressionCaseInsensitive error:nil];
    NSString *modifiedString = [regex stringByReplacingMatchesInString:text
                                                               options:0
                                                                 range:NSMakeRange(0, [text length])
                                                          withTemplate:@""];
    return modifiedString;
}



-(void)tap:(id)sender{
    [self.md5TextView resignFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)nextStep:(id)sender{
    LastViewController* lastView = [[LastViewController alloc] initWithNibName:@"LastViewController" bundle:nil];
    
    [self.navigationController pushViewController:lastView animated:YES];

}

#define NUMBER_BEGIN 48
#define CAPTAL_LITTER_BEGIN 65
#define SMALL_LITTER_BEGIN 97

-(void)test{
    
    LOGINFO(@"%d",10);
    LOGINFO(@"%x",10);
    LOGINFO(@"%X",10);
    LOGINFO(@"%o\n",10);
    
    LOGINFO(@"%d",10);
    LOGINFO(@"%#x",10);
    LOGINFO(@"%#X",10);
    LOGINFO(@"%#o\n",10);
    
    LOGINFO(@"%d",10);
    LOGINFO(@"%d",0x10);
    LOGINFO(@"%d",0X10);
    LOGINFO(@"%d\n",010);
    
    char a = 'a';
    LOGINFO(@"%d",'1');
    LOGINFO(@"%d",a);
    LOGINFO(@"%d\n",'A');
    
    
    
}

-(IBAction)md5ButtonPredded:(id)sender{
    
    NSString* temp = md5TextView.text;
    
    temp = [temp md5];
    
    LOGINFO(@"%@",temp);
    md5TextView.text = temp;
}












@end
