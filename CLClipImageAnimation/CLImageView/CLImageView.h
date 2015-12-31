//
//  CLImageView.h
//  CLClipImageAnimation
//
//  Created by Charles on 15/12/31.
//  Copyright © 2015年 Charles. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CLImageView : UIScrollView

- (instancetype)initWithFrame:(CGRect)frame andImage:(UIImage *)image;
@property (strong,nonatomic) UIImage * mImage;
@property (assign,nonatomic) CGRect orginFrame;

@end
