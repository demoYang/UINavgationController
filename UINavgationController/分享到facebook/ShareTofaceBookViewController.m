//
//  ShareTofaceBookViewController.m
//  UINavgationController
//
//  Created by niexin on 12-12-22.
//  Copyright (c) 2012年 niexin. All rights reserved.
//

#import "ShareTofaceBookViewController.h"
#import <Social/Social.h>
#import "AppDelegate.h"

@interface ShareTofaceBookViewController ()

@end

@implementation ShareTofaceBookViewController

NSString *const FBSessionStateChangedNotification = @"cn.topdeep.UINavigationController:FBSessionStateChangedNotification";

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        

    }
    return self;
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

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"facebook分享";
    UIBarButtonItem* item = [[UIBarButtonItem alloc]initWithTitle:@"nextStep" style:UIBarButtonItemStyleDone target:self action:@selector(nextStep:)];
    self.navigationItem.rightBarButtonItem = item;
    
    UIButton* shareBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 100, screenWidth, 30)];
    shareBtn.backgroundColor = [UIColor redColor];
    [shareBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [shareBtn setTitle:@"分享到Facebook" forState:UIControlStateNormal];
    [shareBtn addTarget:self action:@selector(sharetoFacebook) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:shareBtn];
    
    // Do any additional setup after loading the view from its nib.
}

//facebook 分享只可以上传图片链接


//void 


- (void)sharetoFacebook
{
    if ([UIDevice currentDevice].systemVersion.floatValue > 7.0) {
        //调用系统的方法
        if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook]) {
            SLComposeViewController* shareController = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
            [shareController setInitialText:@""];
            [shareController addImage:[UIImage imageNamed:@""]];
            [shareController addURL:[NSURL URLWithString:@""]];
            shareController.completionHandler = ^(SLComposeViewControllerResult result){
                if (result == SLComposeViewControllerResultCancelled) {
                    
                }else if (result == SLComposeViewControllerResultDone) {
                    
                }
            };
            [self presentModalViewController:shareController animated:YES];
        }
    }else{
        AppDelegate *appDelegate = [[UIApplication sharedApplication]delegate];
        
        LOGINFO(@"%@",@"Facebook sharing button pressed.");
        
        if (appDelegate.session.isOpen) {
            [self publishFeedToFacebook];
        } else {
            if (appDelegate.session.state != FBSessionStateCreated) {
                // Create a new, logged out session.
                appDelegate.session = [[FBSession alloc] init];
            }
            [appDelegate.session openWithBehavior:FBSessionLoginBehaviorForcingWebView completionHandler:^(FBSession *session, FBSessionState status, NSError *error) {
                [self publishFeedToFacebook];
            }];
        }
    }
}

- (void)publishFeedToFacebook {
    AppDelegate *appDelegate = [[UIApplication sharedApplication]delegate];
    if (appDelegate.session.isOpen) {
        NSString* imageUrl = @"";
        
        /* 把图片发送到服务器上，方便获取
        if (self.sendImage != nil) {
            if (addWaterMark) {
                NSString* imageName = [NSString stringWithFormat:@"%.0f.png",[[NSDate date] timeIntervalSince1970] * 1000000];
                if (![[FAPublicMethods getInstance]uploadImageToS3:sendImage imageName:imageName]) {
                    [[FAPublicMethods getInstance]showAlertViewWithTitle:@"S3_UPLOAD_ERROR" tag:0 message:@"Sorry, can't share picture right now" cancel:@"OK" delegate:nil other:nil];
                    return;
                }
                imageUrl = [NSString stringWithFormat:AWS_S3_VIRTUAL_FACE_IMGS_BUCKET,imageName];
            }else{
                imageUrl = [NSString stringWithFormat:AWS_S3_FEATURED_LOOKS_MODEL_IMGS_BUCKET,self.curatedLookSnapshot];
            }
        }else{
            imageUrl = [[PPHBiz getInstance] keyValuesGetValueByKey:PALETTA_APP_URL_KEY];
        }*/
        LOGINFO(imageUrl);
        NSString* name = @"share Title";
        NSString* caption = @"";
        NSString* description = @"";
        NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                       name, @"name",
                                       caption, @"caption",
                                       description, @"description",
                                       imageUrl, @"link",
                                       imageUrl, @"picture",
                                       nil];
        // Invoke the dialog
        [FBWebDialogs presentFeedDialogModallyWithSession:nil parameters:params handler:^(FBWebDialogResult result, NSURL *resultURL, NSError *error) {
            if (error) {
                // Error launching the dialog or publishing a story.
                LOGINFO (@"Error publishing facebook story.");
            } else {
                if (result == FBWebDialogResultDialogNotCompleted) {
                    // User clicked the "x" icon
                    LOGINFO (@"4:User canceled facebook feed publishing.");
                } else {
                    // Handle the publish feed callback
                    NSDictionary *urlParams = [self parseURLParams:[resultURL query]];
                    if (![urlParams valueForKey:@"post_id"]) {
                        // User clicked the Cancel button
                        LOGINFO(@"User canceled story publishing.");
                        
                    } else {
                        // User clicked the Share button
                        NSString *msg = [NSString stringWithFormat: @"Posted story, id: %@", [urlParams valueForKey:@"post_id"]];
                        LOGINFO(@"4:Feed posted to facebook \n%@",msg);
                        // Show the result in an alert
                    }
                }
            }
        }];
    }else{
        
    }
}

- (NSDictionary*)parseURLParams:(NSString *)query {
    NSArray *pairs = [query componentsSeparatedByString:@"&"];
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    for (NSString *pair in pairs) {
        NSArray *kv = [pair componentsSeparatedByString:@"="];
        NSString *val =
        [kv[1] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        params[kv[0]] = val;
    }
    return params;
}

//可以分享图片
- (void)publishStory
{
    UIImage* _postImage = nil;
    NSMutableDictionary* postParams = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                  @"http://www.paletta.mobi/", @"link",
                  _postImage ? _postImage : @"https://developers.facebook.com/attachment/iossdk_logo.png", @"picture",
                  @"zhangxin", @"name",
                  @"mobile social network for makeup lovers", @"caption",
                  @"I just created a wish list using Paletta mobile app.",@"message",
                  @"相关描述", @"description",
                  nil];
    
    
    [FBRequestConnection startWithGraphPath:(_postImage ? @"me/photos" : @"me/feed") parameters:postParams HTTPMethod:@"POST"      completionHandler:^(FBRequestConnection *connection,id result,NSError *error) {
        NSString *alertText;
        NSString *btnTitle;
        if (error) {
            alertText = [NSString stringWithFormat:@"error: domain = %@, code = %d",error.domain, error.code];
            btnTitle = @"Error";
        } else {
            //             alertText = [NSString stringWithFormat:@"Posted action, id: %@",[result objectForKey:@"id"]];
            alertText = @"Shared. Log into your facebook account to see the update";
            btnTitle = @"OK";
        }
        // Show the result in an alert
    }];
}


@end
