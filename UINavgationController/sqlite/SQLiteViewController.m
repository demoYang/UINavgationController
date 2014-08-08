//
//  SQLiteViewController.m
//  UINavgationController
//
//  Created by niexin on 12-12-21.
//  Copyright (c) 2012年 niexin. All rights reserved.
//

#import "SQLiteViewController.h"

#import "Skintone.h"

@interface SQLiteViewController ()

@end

@implementation SQLiteViewController

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
    
    self.title = @"SQLite";
    
    [Skintone queryAll];

    // Do any additional setup after loading the view from its nib.
}

-(void)set{
    
}





- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
