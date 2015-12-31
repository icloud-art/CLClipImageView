//
//  CLClipImageView.m
//  CLClipImageAnimation
//
//  Created by Charles on 15/12/31.
//  Copyright © 2015年 Charles. All rights reserved.
//

#import "CLClipImageView.h"
#define Width view.frame.size.width
#define Height view.frame.size.height
#define imageW image.size.width * 0.5
#define imageH image.size.height * 0.5

@implementation CLClipImageView

+ (void)addToCurrentView:(UIView *)view clipImage:(UIImage *)image backgroundImage:(NSString *)backgroundImage animationComplete:(AnimationComplete)complete{
    
    // 左上半部
    UIImageView *topImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, Width*0.5, Height * 0.5)];
    topImgView.tag = 100;
    topImgView.image = [self clipImage:image withRect:CGRectMake(0, 0, imageW, imageH)];
    
    //右上半部
    UIImageView *topRightImgView = [[UIImageView alloc] initWithFrame:CGRectMake(Width * 0.5, 0, Width*0.5, Height * 0.5)];
    topRightImgView.tag = 101;
    topRightImgView.image = [self clipImage:image withRect:CGRectMake(imageW, 0, imageW, imageH)];
    
    // 左下半部
    UIImageView *bottomImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, Height * 0.5, Width*0.5, Height * 0.5)];
    bottomImgView.tag = 102;
    bottomImgView.image = [self clipImage:image withRect:CGRectMake(0, imageH, imageW, imageH)];
    //右下半部
    UIImageView *bottomRightImgView = [[UIImageView alloc] initWithFrame:CGRectMake(Width * 0.5, Height * 0.5, Width*0.5, Height * 0.5)];
    bottomRightImgView.tag = 103;
    bottomRightImgView.image = [self clipImage:image withRect:CGRectMake(imageW, imageH, imageW, imageH)];
    
    // 延时操作
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0f* NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 执行动画
        [UIView animateWithDuration:2.0f animations:^{
            
            CGRect topRect = topImgView.frame;
            topRect.origin.y -= imageH;
            topRect.origin.x -= imageW;
            topImgView.frame = topRect;
            
            CGRect rightTopRect = topRightImgView.frame;
            rightTopRect.origin.y -= imageH;
            rightTopRect.origin.x += imageW;
            topRightImgView.frame = rightTopRect;
            
            
            CGRect bottomRect = bottomImgView.frame;
            bottomRect.origin.y += imageH;
            bottomRect.origin.x -= imageW;
            bottomImgView.frame = bottomRect;
            
            CGRect rightBottomRect = bottomRightImgView.frame;
            rightBottomRect.origin.y += imageH;
            rightBottomRect.origin.x += imageW;
            bottomRightImgView.frame = rightBottomRect;
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                complete();
            });
        }];
    });
    
    // 背景图
    UIImageView *bgImage = [[UIImageView alloc] initWithFrame:view.bounds];
    bgImage.image = [UIImage imageNamed:backgroundImage];
    bgImage.userInteractionEnabled = YES;
    
//    UITapGestureRecognizer * tapOne = [[UITapGestureRecognizer alloc]initWithTarget:bgImage action:@selector(tapGuesture:)];
//    tapOne.numberOfTapsRequired = 1;
//    [bgImage addGestureRecognizer:tapOne];
    
    // 添加到视图
//    [view addSubview:bgImage];
    [view addSubview:topImgView];
    [view addSubview:topRightImgView];
    [view addSubview:bottomImgView];
    [view addSubview:bottomRightImgView];
}

- (void)tapGuesture:(UITapGestureRecognizer *)sender{
    UIImageView * leftTopImage = [self viewWithTag:100];
    UIImageView * rightTopImage = [self viewWithTag:101];
    UIImageView * leftBottomImage = [self viewWithTag:102];
    UIImageView * rightBottomImage = [self viewWithTag:103];
    [UIView animateWithDuration:2.0f animations:^{
        
        CGRect topRect = leftTopImage.frame;
        topRect.origin.y += leftTopImage.frame.size.width;
        topRect.origin.x += leftTopImage.frame.size.width;
        leftTopImage.frame = topRect;
        
        CGRect rightTopRect = rightTopImage.frame;
        rightTopRect.origin.y += rightBottomImage.frame.size.width;
        rightTopRect.origin.x -= rightBottomImage.frame.size.width;
        rightTopImage.frame = rightTopRect;
        
        CGRect bottomRect = leftBottomImage.frame;
        bottomRect.origin.y -= leftBottomImage.frame.size.height;
        bottomRect.origin.x += leftBottomImage.frame.size.width;
        leftBottomImage.frame = bottomRect;
        
        CGRect rightBottomRect = rightBottomImage.frame;
        rightBottomRect.origin.y -= rightBottomImage.frame.size.height;
        rightBottomRect.origin.x -= rightBottomImage.frame.size.width;
        rightBottomImage.frame = rightBottomRect;
        
    }];
}

// 返回裁剪后的图片
+ (UIImage *)clipImage:(UIImage *)image withRect:(CGRect)rect {
    CGRect clipFrame = rect;
    CGImageRef refImage = CGImageCreateWithImageInRect(image.CGImage, clipFrame);
    UIImage *newImage = [UIImage imageWithCGImage:refImage];
    CGImageRelease(refImage);
    return newImage;
}

+(UIImage*)getImageFromView:(UIView*)view
{
    CGSize s = view.bounds.size;
    // 下面方法，第一个参数表示区域大小。第二个参数表示是否是非透明的。如果需要显示半透明效果，需要传NO，否则传YES。第三个参数就是屏幕密度了
    UIGraphicsBeginImageContextWithOptions(s, NO, [UIScreen mainScreen].scale);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage*image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}


@end
