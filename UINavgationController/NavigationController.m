//
//  NavigationController.m
//  UINavgationController
//
//  Created by niexin on 12-9-12.
//  Copyright (c) 2012年 niexin. All rights reserved.
//

#import "NavigationController.h"

@interface NavigationController ()

@end

@implementation NavigationController

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
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return [self.topViewController shouldAutorotateToInterfaceOrientation:interfaceOrientation];
}

-(BOOL)shouldAutorotate{
    return [self.topViewController shouldAutorotate];
}

-(NSUInteger)supportedInterfaceOrientations{

    return [self.topViewController supportedInterfaceOrientations];
}


@end
