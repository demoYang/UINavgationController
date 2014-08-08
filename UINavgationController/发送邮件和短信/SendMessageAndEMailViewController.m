//
//  sendMessageAndEMailViewController.m
//  UINavgationController
//
//  Created by niexin on 12-12-22.
//  Copyright (c) 2012年 niexin. All rights reserved.
//

#import "SendMessageAndEMailViewController.h"

@interface SendMessageAndEMailViewController ()

@end

@implementation SendMessageAndEMailViewController

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
    
    self.title = @"发送邮件和短信";
    
    address = @"366898509@qq.com";
    address = @"461503532@qq.com";

    UIButton* mailBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 100, screenWidth, 30)];
    mailBtn.backgroundColor = [UIColor redColor];
    [mailBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [mailBtn setTitle:@"发送邮件" forState:UIControlStateNormal];
    [mailBtn addTarget:self action:@selector(showMailPicker) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:mailBtn];
    
    UIButton* SMSBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 140, screenWidth, 30)];
    SMSBtn.backgroundColor = [UIColor redColor];
    [SMSBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [SMSBtn setTitle:@"发送短信" forState:UIControlStateNormal];
    [SMSBtn addTarget:self action:@selector(showSMSPicker) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:SMSBtn];
    
    // Do any additional setup after loading the view from its nib.
}

//邮件

-(void)showMailPicker {
    
    Class mailClass = (NSClassFromString(@"MFMailComposeViewController"));
    if (mailClass !=nil) {
        if ([mailClass canSendMail]) {
            [self displayMailComposerSheet];
        }else{
            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@""message:@"设备不支持邮件功能" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alert show];
        }
    }else{
        
        
        
    }
}

-(void)displayMailComposerSheet

{
    
    MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
    picker.mailComposeDelegate =self;
    [picker setSubject:@"文件分享"];
    // Set up recipients
    NSArray *toRecipients = [NSArray arrayWithObject:@"first@qq.com"];
    NSArray *ccRecipients = [NSArray arrayWithObjects:@"second@qq.com",@"third@qq.com", nil];
    NSArray *bccRecipients = [NSArray arrayWithObject:@"fourth@qq.com"];
    
    [picker setToRecipients:toRecipients];//收件人
    
    [picker setCcRecipients:ccRecipients];//抄送人
    
    [picker setBccRecipients:bccRecipients];//密送
    
    //发送图片附件
//    NSString *path = [[NSBundle mainBundle] pathForResource:@"rainy" ofType:@"jpg"];
//    NSData *myData = [NSData dataWithContentsOfFile:path];
//    [picker addAttachmentData:myData mimeType:@"image/jpeg" fileName:@"rainy.jpg"];
    
    //发送txt文本附件
//    NSString *path = [[NSBundle mainBundle] pathForResource:@"MyText" ofType:@"txt"];
//    NSData *myData = [NSData dataWithContentsOfFile:path];
//    [picker addAttachmentData:myData mimeType:@"text/txt" fileName:@"MyText.txt"];
    
    //发送doc文本附件
//    NSString *path = [[NSBundle mainBundle] pathForResource:@"MyText" ofType:@"doc"];
//    NSData *myData = [NSData dataWithContentsOfFile:path];
//    [picker addAttachmentData:myData mimeType:@"text/doc" fileName:@"MyText.doc"];
    
    //发送pdf文档附件
//    NSString *path = [[NSBundle mainBundle] pathForResource:@"CodeSigningGuide"ofType:@"pdf"];
//    NSData *myData = [NSData dataWithContentsOfFile:path];
//    [picker addAttachmentData:myData mimeType:@"file/pdf"fileName:@"rainy.pdf"];
    
    // Fill out the email body text
    NSString *emailBody = [NSString stringWithFormat:@"我分享了文件给您，地址是%@",address] ;
    [picker setMessageBody:emailBody isHTML:NO];
    [self presentModalViewController:picker animated:YES];
}

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error {
    // Notifies users about errors associated with the interface
    
    switch (result)
    
    {
        
        case MFMailComposeResultCancelled:
        
        LOGINFO(@"Result: Mail sending canceled");
        
        break;
        
        case MFMailComposeResultSaved:
        
        LOGINFO(@"Result: Mail saved");
        
        break;
        
        case MFMailComposeResultSent:
        
        LOGINFO(@"Result: Mail sent");
        
        break;
        
        case MFMailComposeResultFailed:
        
        LOGINFO(@"Result: Mail sending failed");
        
        break;
        
        default:
        
        LOGINFO(@"Result: Mail not sent");
        
        break;
        
    }
    [self dismissModalViewControllerAnimated:YES];
    
}

//短信

-(void)showSMSPicker{
    
    Class messageClass = (NSClassFromString(@"MFMessageComposeViewController"));
    if (messageClass != nil) {
        // Check whether the current device is configured for sending SMS messages
        if ([messageClass canSendText]) {
            [self displaySMSComposerSheet];
        }
        else {
            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@""message:@"设备不支持短信功能" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alert show];
        }
        
    }else {
        
        
        
    }
}

-(void)displaySMSComposerSheet{
    
    MFMessageComposeViewController *picker = [[MFMessageComposeViewController alloc] init];
    
    picker.messageComposeDelegate =self;
    
    NSString *smsBody =[NSString stringWithFormat:@"我分享了文件给您，地址是%@",address] ;
    
    picker.body=smsBody;
    
    [self presentModalViewController:picker animated:YES];
}

-(void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result{
    switch (result) {
        case MessageComposeResultCancelled :
            LOGINFO(@"%@",@"取消发送");
            
            break;
            
        case MessageComposeResultSent:
            LOGINFO(@"%@",@"发送成功");
            break;
            
        case MessageComposeResultFailed:
            LOGINFO(@"%@",@"发送失败");
            break;
            
        default:
            break;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
