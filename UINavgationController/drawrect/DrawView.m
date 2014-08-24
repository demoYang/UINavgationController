//
//  DrawView.m
//  UINavgationController
//
//  Created by niexin on 12-11-7.
//  Copyright (c) 2012年 niexin. All rights reserved.
//

#import "DrawView.h"

#import "PrintLog.h"
@implementation DrawView

@synthesize type;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

#define KDGREED(x) ((x)  * M_PI * 2)
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
//    type = 1;//rand() % 6;
    
    switch (type) {
        case 0:{//正方形
            // Drawing code.画线条
            //获得处理的上下文
            CGContextRef context = UIGraphicsGetCurrentContext();
            //设置线条样式
            CGContextSetLineCap(context, kCGLineCapSquare);
            //设置线条粗细宽度
            CGContextSetLineWidth(context, 1.0); 
            //反图像失真，锯齿现象
            CGContextSetAllowsAntialiasing(context, TRUE);
            //设置边线色
            CGContextSetRGBStrokeColor(context, 1.0, 161.0/256.0, 112.0/256.0, 256.0/256.0);
            //开始一个起始路径
            CGContextBeginPath(context);
            //起始点设置为(0,0):注意这是上下文对应区域中的相对坐标，
            CGContextMoveToPoint(context, 10, 10);
            //设置下一个坐标点
            CGContextAddLineToPoint(context, 10, 100);
            //设置下一个坐标点
            CGContextAddLineToPoint(context, 100, 100);
            //点与点之间用圆弧
            CGContextAddArcToPoint(context, 100, 10, 90, 10, 10);
            //点与点之间用圆弧
            CGContextAddArcToPoint(context, 10, 10, 10, 20, 10);
            
            
            CGContextMoveToPoint(context, 10, 210);
            CGContextAddCurveToPoint(context, 110, 110, 210, 210, 320, 210);
            
            //把起点和中点连起来
            CGContextClosePath(context);
            //把图显示出来
            CGContextStrokePath(context);
            [[UIColor blueColor]setFill];//设置填充色
            [[UIColor blueColor]setStroke];//设置填充色

            break;
        }
        case 1:{//圆形
            //获得处理的上下文
            CGContextRef context = UIGraphicsGetCurrentContext();
            //设置线条样式
            CGContextSetLineCap(context, kCGLineCapSquare);
            //设置线条粗细宽度
            CGContextSetLineWidth(context, 1.0);
            //反图像失真，锯齿现象
            CGContextSetAllowsAntialiasing(context, TRUE);
            //设置线条颜色
            CGContextSetRGBStrokeColor(context, 1.0, 161.0/256.0, 112.0/256.0, 256.0/256.0);

            CGContextMoveToPoint(context, 100, 100);

            //画圆 //0表示顺时针，1表示逆时针;弧度时安顺时针算的
            CGContextAddArc(context, 100, 100, 80, M_PI * 0, M_PI * 0.9, 0);
            //用线条把图显示出来
            [[UIColor redColor] setFill];
            [[UIColor greenColor] setStroke];
            //用颜色涂满整个线条包围的区域,线条不会出现(用什么颜色有上面的setFill决定)
            CGContextDrawPath(context, kCGPathFillStroke);
            break;
        }
        case 2:{
            
            NSString* text = @"张鑫！！1234:：： aasdfasd";
            [text drawAtPoint:CGPointMake(20, 100) withFont:[UIFont systemFontOfSize:14]];
            
            CGContextRef context = UIGraphicsGetCurrentContext();
            CGContextSetRGBStrokeColor(context, 1.0, 161.0/256.0, 112.0/256.0, 256.0/256.0);
            CGContextSelectFont(context, "Arial", 14, kCGEncodingMacRoman);
            CGContextSetTextMatrix(context, CGAffineTransformMake(1.0,0.0, 0.0, -1.0, 0.0, 0.0));

            CGContextShowTextAtPoint(context, 20, 150, [text cStringUsingEncoding: NSUTF8StringEncoding], [text lengthOfBytesUsingEncoding:NSUTF8StringEncoding]);
            break;
        }
        case 3:{//点到点的渐变色
            CGContextRef context = UIGraphicsGetCurrentContext();
            CGFloat componets1 [] = {0.0f/255.0f, 0.0f/255.0f, 255.0f/255.0f, 1.0,
                                     250.0f/255.0f, 0.0f/255.0f, 0.0f/255.0f, 1.0,
                                     0.0f/255.0f, 255.0f/255.0f, 0.0f/255.0f, 1.0};//前6位起始色和结束色，后两位是开始和结束的透明度
            CGFloat componets2 [] = {0.0f, 0.5f, 1.0f};//渐变位置（范围）
            int x = 3;//变化的层次数，与上面的配合
            CGColorSpaceRef colorspace1 = CGColorSpaceCreateDeviceRGB();
            CGGradientRef gradient1 = CGGradientCreateWithColorComponents(colorspace1, componets1,componets2 , x);
            CGContextSaveGState(context);//
            
            //设置作用范围
//            CGContextClipToRect(context, CGRectMake(0,0,300,300));//在矩形中
//            CGContextAddEllipseInRect(context, rect);//在圆形中;

            CGPoint points [] = {CGPointMake(10, 10), CGPointMake(150, 50), CGPointMake(300, 10), CGPointMake(300, 200), CGPointMake(150, 160), CGPointMake(10, 200)};
            CGContextAddLines(context, points, 6);
            CGContextClosePath(context);//形成封闭空间
            CGContextClip(context);//超出部分裁剪掉
            //形成封闭的空间设置此封闭的空间为作用空间！
            
            CGContextDrawLinearGradient(context, gradient1, CGPointMake(0,0), CGPointMake(0,200),kCGGradientDrawsBeforeStartLocation);
            CGColorSpaceRelease(colorspace1);
            CGContextRestoreGState(context);
            
            [[UIColor blueColor]setFill];//设置填充色
            [[UIColor blueColor]setStroke];//设置填充色

            CGContextDrawRadialGradient(context, gradient1, CGPointMake(160, 300), 0, CGPointMake(160, 300), 50, kCGGradientDrawsBeforeStartLocation);
            
            break;
        }
        case 4:{//帧动画
            //Prepare the animation - we use keyframe animation for animations of this complexity
            //需要quartzcore。framework
            CAKeyframeAnimation *pathAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
            pathAnimation.calculationMode = kCAAnimationCubicPaced;
            pathAnimation.fillMode = kCAFillModeRemoved;
            pathAnimation.removedOnCompletion = YES;
            pathAnimation.duration = 4;
//            pathAnimation.repeatDuration = 6.0;//重复时间不可以与重复次数连用，有了重复时间重复次数就等于repeatDuration／duration
            pathAnimation.repeatCount = 4;
            pathAnimation.delegate = self;

            CGMutablePathRef curvedPath = CGPathCreateMutable();
            
            CGPathMoveToPoint(curvedPath, nil, 20, 20);
            CGPathAddLineToPoint(curvedPath, nil, 20, 200);
            CGPathAddLineToPoint(curvedPath, nil, 200, 200);
            CGPathAddLineToPoint(curvedPath, nil, 200, 20);
            CGPathAddLineToPoint(curvedPath, nil, 20, 20);
            //Now we have the path, we tell the animation we want to use this path - then we release the path
            pathAnimation.path = curvedPath;
            CGPathRelease(curvedPath);
            
            //We will now draw a circle at the start of the path which we will animate to follow the path
            //We use the same technique as before to draw to a bitmap context and then eventually create
                //a UIImageView which we add to our view

            
            UIGraphicsBeginImageContext(CGSizeMake(20,20));
            CGContextRef ctx = UIGraphicsGetCurrentContext();
            //    //Set context variables
            CGContextSetLineWidth(ctx, 1);
            CGContextSetFillColorWithColor(ctx, [UIColor greenColor].CGColor);
            CGContextSetStrokeColorWithColor(ctx, [UIColor redColor].CGColor);
            //    //Draw a circle - and paint it with a different outline (white) and fill color (green)
            CGContextAddEllipseInRect(ctx, CGRectMake(1, 1, 18, 18));//圆形
            
            CGContextDrawPath(ctx, kCGPathFillStroke);
            UIImage *circle = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
            
            if (circleView == nil) {
                circleView = [[UIImageView alloc] initWithImage:circle];
                circleView.frame = CGRectMake(10, 10, 20, 20);
                [self addSubview:circleView];
            }
            //Add the animation to the circleView - once you add the animation to the layer, the animation starts
            [circleView.layer addAnimation:pathAnimation forKey:@"moveTheSquare"];

            break;
        }
        case 5:{//paletta test
            CGFloat scale = 0.5;
            CGContextRef ctx = UIGraphicsGetCurrentContext();
            CGContextTranslateCTM(ctx, 0, self.frame.size.height);
            CGContextScaleCTM(ctx, scale, -1*scale);
            
            NSArray* arrayStr = [[NSArray alloc]initWithObjects:@"0489B1",@" DF0174",@" 151515",@"FA58F4",@" D8D8D8 ",@"61380B ",@"424242 ",@"FE642E ",@"610B4B ",@"61380B ",@"DBA901 ",@"A901DB ",@"E2A9F3 ",@"151515",@"2A1B0A ",@"151515", nil];
            NSMutableArray* colorArray = [[NSMutableArray alloc]initWithObjects:[UIColor clearColor], nil];
            for (NSString* str in arrayStr) {
                float R = strtoul([[str substringToIndex:2] UTF8String],0,16);
                float G = strtoul([[str substringWithRange:NSMakeRange(3, 2)] UTF8String],0,16);
                float B = strtoul([[str substringFromIndex:4] UTF8String],0,16);
                UIColor* color = [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:1];
                LOGINFO(@"R = %f ,G = %f ,B = %f ,",R,G,B);
                [colorArray addObject:color];
            }
            
            UIColor* color = [colorArray objectAtIndex:1];
            
            UIImage* image0 = [UIImage imageNamed:@"上睫毛阴影.png"];
            CGRect area0 = CGRectMake(0 , 0, image0.size.width, image0.size.height);
            CGContextDrawImage(ctx, area0, image0.CGImage);
            
            UIImage* image1 = [test addBackGroundColor:image0 color:color];
            CGRect area1 = CGRectMake(0 , 200, image0.size.width, image0.size.height);
            CGContextDrawImage(ctx, area1, image1.CGImage);
            
            UIImage* image2 = [test addBackGroundColor:image0 color:[UIColor clearColor]];
            CGRect area2 = CGRectMake(0 , 400, image0.size.width, image0.size.height);
            CGContextDrawImage(ctx, area2, image2.CGImage);
            
            //反的图
            CGContextDrawImage(ctx, CGRectMake(50, 200, 100, 100), image0.CGImage);
            
            //正的图
            UIGraphicsPushContext(ctx);
            [image0 drawInRect:CGRectMake(50, 50, 100, 100)];
            UIGraphicsPopContext();

            break;
        }
        case 6:{//话文字
           //字体渐变色
            UIFont * font = [UIFont systemFontOfSize:17];
            NSString* text = @"zhangixng ,,张鑫";
            int strokeSize = 1;
            UIColor* strokeColor = [UIColor blueColor];
            
            UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0.0f);
            CGContextRef context = UIGraphicsGetCurrentContext();
            
//            Prepare mask.
            CGContextSaveGState(context);
            CGContextSetTextDrawingMode(context, kCGTextFillStroke);
            CGContextSetLineWidth(context, strokeSize * 2.0f);
            CGContextSetLineJoin(context, kCGLineJoinRound);
            [[UIColor clearColor] setStroke];
            // Set white color for alpha mask.
           [[UIColor whiteColor] setFill];
            
            // Draw alpha mask.
            [text drawInRect:rect withFont:font];
            
            // Save alpha mask.
            CGImageRef alphaMask = CGBitmapContextCreateImage(context);
            
            // Clear the content.
            CGContextClearRect(context, rect);
            
            CGContextRestoreGState(context);
            
//            Draw text normally, or with gradient.
            
            CGContextSaveGState(context);
            // Invert everything, because CG works with an inverted coordinate system.
            CGContextTranslateCTM(context, 0.0f, rect.size.height);
            CGContextScaleCTM(context, 1.0f, -1.0f);
            
            // Clip the current context to alpha mask.
            CGContextClipToMask(context, rect, alphaMask);
            
            // Invert back to draw the gradient correctly.
            CGContextTranslateCTM(context, 0.0f, rect.size.height);
            CGContextScaleCTM(context, 1.0f, -1.0f);
            
            // Get gradient colors as CGColor.
            NSMutableArray *gradientColors = [NSMutableArray arrayWithObjects:(__bridge id)[UIColor redColor].CGColor,(__bridge id)[UIColor greenColor].CGColor, nil];
                        
            // Create gradient.
            CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
            CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef)gradientColors, NULL);
            CGPoint startPoint = CGPointMake(0,5);
            CGPoint endPoint = CGPointMake(0,30);
            
            // Draw gradient.
            CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, kCGGradientDrawsBeforeStartLocation | kCGGradientDrawsAfterEndLocation);
            
            // Clean up, because ARC doesn't handle CG.
            CGColorSpaceRelease(colorSpace);
            CGGradientRelease(gradient);
            CGContextRestoreGState(context);

            //            Draw stroke.
            CGContextSaveGState(context);
            CGContextSetTextDrawingMode(context, kCGTextStroke);
            // Create an image from the text.
            CGImageRef image = CGBitmapContextCreateImage(context);
            CGContextSetLineWidth(context, strokeSize * 2.0f);
            CGContextSetLineJoin(context, kCGLineJoinRound);
            [strokeColor setStroke];
            [text drawInRect:rect withFont:font];
            CGContextTranslateCTM(context, 0.0f, rect.size.height);
            CGContextScaleCTM(context, 1.0f, -1.0f); // Draw the saved image over half of the stroke.
            CGContextDrawImage(context, rect, image); // Clean up, because ARC doesn't handle CG.
            CGImageRelease(image);
            CGContextRestoreGState(context);
            
            UIImage *endimage = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
            [endimage drawInRect:rect];
            
            CGImageRelease(alphaMask);
            
            
        }
            break;
            
        case 7:{
            
            UIImage* image = [UIImage imageNamed:@"logo.png"];
            CGRect rect = CGRectMake(0, 0, 30, 30);
            
            UIGraphicsBeginImageContext(rect.size);
            CGContextRef ctx = UIGraphicsGetCurrentContext();
            //    //Set context variables
            CGContextSetLineWidth(ctx, 1);
            CGContextSetFillColorWithColor(ctx, [UIColor whiteColor].CGColor);
            CGContextSetStrokeColorWithColor(ctx, [UIColor clearColor].CGColor);
            //    //Draw a circle - and paint it with a different outline (white) and fill color (green)
            
            CGContextAddEllipseInRect(ctx, rect);//圆形
            
            CGContextClosePath(ctx);
            CGContextDrawPath(ctx, kCGPathFillStroke);
            
            
            UIImage *circle = UIGraphicsGetImageFromCurrentImageContext();
            CGContextClipToMask(ctx, rect, circle.CGImage);
            
            CGContextDrawImage(ctx, rect, image.CGImage);
            
            
            
            
            
            
            
            UIImage *circle1 = UIGraphicsGetImageFromCurrentImageContext();
            
            UIGraphicsEndImageContext();
            

            
            NSArray *paths= NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            NSString *documentsDirectory = [paths objectAtIndex:0];
            NSString *path = [documentsDirectory stringByAppendingPathComponent:@"asdf.png"];
            
            NSData* imageData = UIImagePNGRepresentation(circle);
            
            
            NSString *path1 = [documentsDirectory stringByAppendingPathComponent:@"asdf1.png"];
            NSData* imageData1 = UIImagePNGRepresentation(circle1);
            
            if ([imageData writeToFile:path atomically:YES]) {
                LOGINFO(@"asdfasdfasdfasd f %@",@"");
            }
            if ([imageData1 writeToFile:path1 atomically:YES]) {
                LOGINFO(@"asdfasdfasdfasd f %@",@"");
            }
            
        }
            break;
        default:
            break;
    }
    
}

-(void)animationDidStart:(CAAnimation *)anim{
    LOGINFO(@"%@",@"path start!!");
}

-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    if (flag) {
//        [circleView removeFromSuperview];
    }
    
    LOGINFO(@"%@",@"path finish!");
}
@end
