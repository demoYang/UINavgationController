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
            /*  两种状态 ，开始和结束状态  */
            [CATransaction commit];
        }
            break;
        case 1:{
            [UIView animateWithDuration:3 animations:^{
               //两种状态 ，开始和结束状态
            }];
        }
            break;
        case 2:{
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:12];
            [UIView setAnimationCurve:UIViewAnimationCurveLinear];
            [UIView setAnimationDelegate:self];
            [UIView setAnimationDidStopSelector:@selector(stopAnimation)];
            //两种状态 ，开始和结束状态
            [UIView commitAnimations];
        }
            break;
        case 3:{
            CATransition *animation = [CATransition animation];
            [animation setDelegate:self];
            /* 设定动画类型
             kCATransitionFade 淡化
             kCATransitionPush 推挤
             kCATransitionReveal 揭开
             kCATransitionMoveIn 覆盖
             @"cube" 立方体
             @"suckEffect" 吸收
             @"oglFlip" 翻转
             @"rippleEffect" 波纹
             @"pageCurl" 翻页
             @"pageUnCurl" 反翻页
             @"cameraIrisHollowOpen" 镜头开
             @"cameraIrisHollowClose" 镜头关
             
             过渡方向
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
        case 4:{
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
        default:
            break;
    }
}
/*
 animationWithKeyPath的值：
 
 
 
 transform.scale = 比例轉換
 transform.scale.x = 闊的比例轉換
 transform.scale.y = 高的比例轉換
 transform.rotation.z = 平面圖的旋轉
 opacity = 透明度
 
 margin
 
 zPosition
 
 backgroundColor
 
 cornerRadius
 
 borderWidth
 
 bounds
 
 contents
 
 contentsRect
 
 cornerRadius
 
 frame
 
 hidden
 
 mask
 
 masksToBounds
 
 opacity
 
 position
 
 shadowColor
 
 shadowOffset
 
 shadowOpacity
 
 shadowRadius
 */
#pragma mark === 永久闪烁的动画 ======
-(CABasicAnimation *)opacityForever_Animation:(float)time
{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"opacity"];//必须写opacity才行。
    animation.fromValue = [NSNumber numberWithFloat:1.0f];
    animation.toValue = [NSNumber numberWithFloat:0.0f];//这是透明度。
    animation.autoreverses = YES;
    animation.duration = time;
    animation.repeatCount = MAXFLOAT;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    animation.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];///没有的话是均匀的动画。
    return animation;
}

#pragma mark =====横向、纵向移动===========
-(CABasicAnimation *)moveX:(float)time X:(NSNumber *)x
{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.translation.x"];///.y的话就向下移动。
    animation.toValue = x;
    animation.duration = time;
    animation.removedOnCompletion = NO;//yes的话，又返回原位置了。
    animation.repeatCount = MAXFLOAT;
    animation.fillMode = kCAFillModeForwards;
    return animation;
}

#pragma mark =====缩放-=============
-(CABasicAnimation *)scale:(NSNumber *)Multiple orgin:(NSNumber *)orginMultiple durTimes:(float)time Rep:(float)repertTimes
{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    animation.fromValue = Multiple;
    animation.toValue = orginMultiple;
    animation.autoreverses = YES;
    animation.repeatCount = repertTimes;
    animation.duration = time;//不设置时候的话，有一个默认的缩放时间.
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    return  animation;
}

#pragma mark =====组合动画-=============
-(CAAnimationGroup *)groupAnimation:(NSArray *)animationAry durTimes:(float)time Rep:(float)repeatTimes
{
    CAAnimationGroup *animation = [CAAnimationGroup animation];
    animation.animations = animationAry;
    animation.duration = time;
    animation.removedOnCompletion = NO;
    animation.repeatCount = repeatTimes;
    animation.fillMode = kCAFillModeForwards;
    return animation;
}

#pragma mark =====路径动画-=============
-(CAKeyframeAnimation *)keyframeAnimation:(CGMutablePathRef)path durTimes:(float)time Rep:(float)repeatTimes
{
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    animation.path = path;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    animation.autoreverses = NO;
    animation.duration = time;
    animation.repeatCount = repeatTimes;
    return animation;
}

#pragma mark ====旋转动画======
-(CABasicAnimation *)rotation:(float)dur degree:(float)degree direction:(int)direction repeatCount:(int)repeatCount
{
    CATransform3D rotationTransform = CATransform3DMakeRotation(degree, 0, 0, direction);
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform"];
    animation.toValue = [NSValue valueWithCATransform3D:rotationTransform];
    animation.duration  =  dur;
    animation.autoreverses = NO;
    animation.cumulative = NO;
    animation.fillMode = kCAFillModeForwards;
    animation.repeatCount = repeatCount;
    animation.delegate = self;
    
    return animation;
    
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
