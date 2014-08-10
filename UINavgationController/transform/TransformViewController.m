//
//  ThirdViewController.m
//  UINavgationController
//
//  Created by niexin on 12-11-7.
//  Copyright (c) 2012年 niexin. All rights reserved.
//

#import "TransformViewController.h"

@interface TransformViewController ()

@end

@implementation TransformViewController

@synthesize label1;
@synthesize label2;

@synthesize button;

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
    self.title = @"transform";
    
    UIBarButtonItem* item = [[UIBarButtonItem alloc]initWithTitle:@"nextStep" style:UIBarButtonItemStyleDone target:self action:@selector(nextStep:)];
    self.navigationItem.rightBarButtonItem = item;
    
    
    label1.textColor = [UIColor redColor];
    label1.backgroundColor = [UIColor blueColor];
    label1.layer.cornerRadius = 10;
    label1.layer.masksToBounds = YES;
    
    
    [self setTransform];
    
    [self setCATransform3D];
//    CALayer*
    layer = [[CALayer alloc]init];
    layer.frame = CGRectMake(10, 10, 30, 30);
    layer.contentsGravity = kCAGravityResizeAspect;
    //layer.contents只识别CGImage格式的图片
    layer.position = CGPointMake(150, 300);
    layer.contents = (id)[UIImage imageNamed:@"logo.png"].CGImage;
    [[self.view layer] addSublayer:layer];
    

    
    // Do any additional setup after loading the view from its nib.
}

//平面的效果
-(CGAffineTransform)sizeTransform{
    CGAffineTransform transform = CGAffineTransformIdentity;
    transform = CGAffineTransformScale(transform, 1.5, 1.5);//2d在xy方向上进行缩放！
    return transform;
}

-(CGAffineTransform)rotationTransform{
    CGFloat aa = rand() % 360;
    float value = aa * M_PI / 180;
    CGAffineTransform transform = CGAffineTransformMakeRotation(value);
    return transform;
}

-(CGAffineTransform)setTransform{
    CGAffineTransform transform = CGAffineTransformIdentity;
    CGAffineTransform rotationTransform = [self rotationTransform];
    CGAffineTransform sizeTransform = [self sizeTransform];

    transform = CGAffineTransformConcat(transform, sizeTransform);//transform的添加先后顺序对效果是有影响的
    transform = CGAffineTransformConcat(transform, rotationTransform);

    label1.transform = transform;
    
    return transform;
}
//3d变化效果
-(CATransform3D)setCATransform3D{
    //定义一个新的transform 没有任何效果！
    CATransform3D transform = CATransform3DIdentity;
    //旋转3d的以圆心到x,y,z的直线为周现转一定的角度
    CATransform3D rotationTransform = CATransform3DMakeRotation((M_PI / 180.0) * 180.0f, 1.0f, 1.0f, 1.0f);
    //按比例在xyz方向上放大
    CATransform3D sizeTransform = CATransform3DMakeScale(2.0f, 2.0f, 1.5f);
    //移动到xyz的坐标点上
    CATransform3D translationTransform = CATransform3DMakeTranslation(10.0f, 10.0f, 1.0f);

    //东环效果一CGAffineTransform的只为准，可以使用组合效果
//    layer.transform = CATransform3DMakeAffineTransform([self setTransform]);
    
    transform = CATransform3DConcat(transform, rotationTransform);
    transform = CATransform3DConcat(transform, sizeTransform);
    transform = CATransform3DConcat(transform, translationTransform);
    
    label2.layer.transform = transform;
    
    return transform;
}

-(IBAction)buttonPressed:(id)sender{
    
    NSInteger index = 2;
    switch (index) {
        case 0:{
            [CATransaction begin];
            [CATransaction setAnimationDuration:10.0f];
            
            
            
            [CATransaction commit];
        }
            break;
        case 1:{
            CATransition *animation = [CATransition animation];
            [animation setDelegate:self];
            // 设定动画类型
            // kCATransitionFade 淡化
            // kCATransitionPush 推挤
            // kCATransitionReveal 揭开
            // kCATransitionMoveIn 覆盖
            // @"cube" 立方体
            // @"suckEffect" 吸收 
            // @"oglFlip" 翻转
            // @"rippleEffect" 波纹
            // @"pageCurl" 翻页
            // @"pageUnCurl" 反翻页
            // @"cameraIrisHollowOpen" 镜头开
            // @"cameraIrisHollowClose" 镜头关
            /* 过渡效果
             fade     //交叉淡化过渡(不支持过渡方向)
             push     //新视图把旧视图推出去
             moveIn   //新视图移到旧视图上面
             reveal   //将旧视图移开,显示下面的新视图
             cube     //立方体翻滚效果
             oglFlip  //上下左右翻转效果
             suckEffect   //收缩效果，如一块布被抽走(不支持过渡方向)
             rippleEffect //滴水效果(不支持过渡方向)
             pageCurl     //向上翻页效果
             pageUnCurl   //向下翻页效果
             cameraIrisHollowOpen  //相机镜头打开效果(不支持过渡方向)
             cameraIrisHollowClose //相机镜头关上效果(不支持过渡方向)
             */
            
            /* 过渡方向
             fromRight;
             fromLeft;
             fromTop;
             fromBottom;
             */
            [animation setType:kCATransitionFade];
            [animation setSubtype:kCATransitionFromLeft];//方向
            [animation setDuration:1.5f];
            [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
            [self.label1.layer addAnimation:animation forKey:@"MTTransaction"];
        }
            break;
        case 2:{
            [CATransaction setValue:[NSNumber numberWithFloat:1.0] forKey:kCATransactionAnimationDuration];
            CABasicAnimation *FlipAnimation=[CABasicAnimation animationWithKeyPath:@"transform.rotation.y"];
            FlipAnimation.timingFunction= [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
            FlipAnimation.toValue= [NSNumber numberWithFloat:M_PI];
            FlipAnimation.duration=1;
            FlipAnimation.fillMode=kCAFillModeForwards;
            FlipAnimation.removedOnCompletion=NO;
            [layer addAnimation:FlipAnimation forKey:@"flip"];
            [CATransaction commit];
        }
            break;
        case 3:{
            [UIView animateWithDuration:3 animations:^{
               //两种状态 ，开始和结束状态
            }];
        }
            break;
        case 4:{
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:12];
            [UIView setAnimationCurve:UIViewAnimationCurveLinear];
            [UIView setAnimationDelegate:self];
            [UIView setAnimationDidStopSelector:@selector(stopAnimation)];
            //两种状态 ，开始和结束状态
            [UIView commitAnimations];
        }
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

-(BOOL)shouldAutorotate{
    return YES;
}

-(NSUInteger)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskAllButUpsideDown;
}

-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation{
    return (toInterfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
