//
//  SixthViewController.h
//  UINavgationController
//
//  Created by niexin on 12-11-16.
//  Copyright (c) 2012年 niexin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RefreshHeadView.h"
#import "LastViewController.h"
#import "BaseViewController.h"

@interface RefreshViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate,RefreshHeadViewProtocol>{
    UITableView* tableview;
    RefreshHeadView* refreshView;
    NSInteger index;
}
@property(nonatomic ,strong)IBOutlet UITableView* tableview;
@end
