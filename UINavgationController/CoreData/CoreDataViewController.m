//
//  CoreDataViewController.m
//  UINavgationController
//
//  Created by 张鑫 on 14-6-22.
//  Copyright (c) 2014年 niexin. All rights reserved.
//

#import "CoreDataViewController.h"

#import "User.h"
#import "Product.h"

@interface CoreDataViewController ()

@end

@implementation CoreDataViewController

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
    
    self.title = @"CoreData";
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
    //    [User add:@"张鑫" password:@"123456" age:28 sex:@"男"];
    //    [User add:@"焦素萍" password:@"123456" age:28 sex:@"女"];
    //    [User add:@"张旭东" password:@"123456" age:28 sex:@"女"];
    //    [User add:@"鲁加全" password:@"123456" age:28 sex:@"女"];
    
    
    [User query:nil];
    
    
    
    
    //    [Product add:@"1111" price:50.0 productor:@"zhangx1"];
    //    [Product add:@"2222" price:50.0 productor:@"zhangx2"];
    //    [Product add:@"3333" price:50.0 productor:@"zhangx3"];
    //    [Product add:@"4444" price:50.0 productor:@"zhangx4"];
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
