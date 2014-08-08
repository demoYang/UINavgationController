//
//  SixthViewController.m
//  UINavgationController
//
//  Created by niexin on 12-11-16.
//  Copyright (c) 2012年 niexin. All rights reserved.
//

#import "RefreshViewController.h"

@interface RefreshViewController ()

@end

@implementation RefreshViewController

@synthesize tableview;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        index = 10;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"下拉刷新";
    UIBarButtonItem* item = [[UIBarButtonItem alloc]initWithTitle:@"nextStep" style:UIBarButtonItemStyleDone target:self action:@selector(nextStep:)];
    self.navigationItem.rightBarButtonItem = item;

    refreshView = [[RefreshHeadView alloc]initWithFrame:CGRectMake(0, -120, 320, 120)];
    refreshView.refreshDelegate = self;
    refreshView.backgroundColor = [UIColor whiteColor];
    [tableview addSubview:refreshView];
    

    // Do any additional setup after loading the view from its nib.
}
-(void)refresh{
    LOGINFO(@"%@",@"refresh");
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return index;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString* identify = @"identify";
    
//    FDFundGradeCell *cell = (FDFundGradeCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
//    if (nil == cell) {
//        NSArray *a = [[NSBundle mainBundle] loadNibNamed:@"FDFundGradeCell" owner:self options:nil];
//        cell = [a objectAtIndex:0];
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    }
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }

    cell.textLabel.text = @"textLabel";
    cell.detailTextLabel.text = @"detailTextLabel";
    cell.imageView.image = [UIImage imageNamed:@"logo.png"];
    return cell;
}
-(NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    return indexPath;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    [tableview deselectRowAtIndexPath:indexPath animated:YES];

    index--;
    
    [tableview deleteRowsAtIndexPaths:[[NSArray alloc]initWithObjects:indexPath, nil] withRowAnimation:UITableViewRowAnimationFade];
//    [tableView reloadRowsAtIndexPaths:[[NSArray alloc]initWithObjects:indexPath, nil] withRowAnimation:UITableViewRowAnimationFade];
    
//    LOGINFO(@"section = %d , row = %d",indexPath.section,indexPath.row);
}





-(void)nextStep:(id)sender{
    LastViewController* lastView = [[LastViewController alloc] initWithNibName:@"LastViewController" bundle:nil];
    
    [self.navigationController pushViewController:lastView animated:YES];

}
- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    LOGINFO(@"%@,,contentOffset = %f,,",@"scrollViewDidScroll",scrollView.contentOffset.y);
    [refreshView refreshScrollViewDidScroll:scrollView];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [refreshView refreshScrollViewDidEndDragging:scrollView];
}

-(void)beginRefresh{
//    [NSTimer timerWithTimeInterval:3 target:self selector:@selector(finishLoad) userInfo:nil repeats:NO];
    [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(finishLoad) userInfo:nil repeats:NO];
    
    LOGINFO(@"%@",@"刷新成功");
    
}

-(void)finishLoad{
    [tableview setContentInset:UIEdgeInsetsZero];
}








@end
