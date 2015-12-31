//
//  CLClipImageView.h
//  CLClipImageAnimation
//
//  Created by Charles on 15/12/31.
//  Copyright © 2015年 Charles. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^AnimationComplete) ();
@interface CLClipImageView : UIImageView
/**!
 *  @param view            要添加到的当前View
 *  @param image           要进行裁剪的图片
 *  @param backgroundImage 可以设置背景图片
 */
+ (void)addToCurrentView:(UIView *)view clipImage:(UIImage *)image backgroundImage:(NSString *)backgroundImage animationComplete:(AnimationComplete)complete;
//UIView 转换成UIImage
+(UIImage*)getImageFromView:(UIView*)view;

@end
