//
//  ViewController.m
//  CLClipImageAnimation
//
//  Created by Charles on 15/12/31.
//  Copyright © 2015年 Charles. All rights reserved.
//

#import "ViewController.h"
#import "CLClipImageView/CLClipImageView.h"
#import "DetailViewController.h"
typedef void (^Complete) ();

@interface ViewController ()
{
    BOOL isOpen;
}
@property (strong,nonatomic) CLImageView * leftTopImage;
@property (strong,nonatomic) CLImageView * rightTopImage;

@property (strong,nonatomic) CLImageView * leftCenterImage;
@property (strong,nonatomic) CLImageView * rightCenterImage;

@property (strong,nonatomic) CLImageView * leftBottomImage;
@property (strong,nonatomic) CLImageView * rightBottomImage;

@property (strong,nonatomic) UIScrollView * mTopScroll;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"割裂图像";
    [CLClipImageView addToCurrentView:self.view clipImage:[UIImage imageNamed:@"Default_image"] backgroundImage:@"" animationComplete:^{
        self.navigationController.navigationBarHidden = NO;
        [self makeTopView];
    }];
}

- (void)makeTopView{
    
    self.automaticallyAdjustsScrollViewInsets = YES;
    
    NSArray * array = @[@"4.jpg",@"12.jpg",@"15.jpg",@"13.jpg",@"12.jpg",@"15.jpg"];
    UIScrollView * scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64,kWidth, 200)];
    scrollView.contentSize = CGSizeMake(kWidth * array.count, 200);
    scrollView.backgroundColor = [UIColor clearColor];
    scrollView.pagingEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = YES;
    [self.view addSubview:scrollView];
    self.mTopScroll = scrollView;
    for (int i = 0; i<array.count; i++) {
        CLImageView * imageView = [[CLImageView alloc]initWithFrame:CGRectMake(kWidth * i+10,10, kWidth - 20, 200- 20)andImage:[UIImage imageNamed:array[i]]];
        imageView.backgroundColor = [UIColor blackColor];
        [scrollView addSubview:imageView];
    }
    [self makeMainView];
}

- (void)makeMainView{
    
    NSArray * array = @[@"4.jpg",@"12.jpg",@"15.jpg",@"13.jpg",@"12.jpg",@"15.jpg"];

    CLImageView * leftTop = [[CLImageView alloc]initWithFrame:CGRectMake(10,CGRectGetMaxY(self.mTopScroll.frame), kCellWidth, kCellHeight) andImage:[UIImage imageNamed:array[0]]];
    leftTop.backgroundColor = [UIColor blackColor];
    leftTop.userInteractionEnabled = YES;
    leftTop.tag = 200;
    self.leftTopImage = leftTop;
    [self.view addSubview:self.leftTopImage];
    
    CLImageView * rightTop = [[CLImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.leftTopImage.frame) + 10,CGRectGetMaxY(self.mTopScroll.frame), kCellWidth, kCellHeight) andImage:[UIImage imageNamed:array[1]]];
    rightTop.backgroundColor = [UIColor blackColor];
    rightTop.userInteractionEnabled = YES;
    rightTop.tag = 201;
    self.rightTopImage = rightTop;
    [self.view addSubview:self.rightTopImage];

    CLImageView * leftCenter = [[CLImageView alloc]initWithFrame:CGRectMake(10,CGRectGetMaxY(self.leftTopImage.frame) + 10, kCellWidth, kCellHeight) andImage:[UIImage imageNamed:array[2]]];
    leftCenter.backgroundColor = [UIColor blackColor];
    leftCenter.userInteractionEnabled = YES;
    leftCenter.tag = 202;
    leftCenter.mImage = array[2];
    self.leftCenterImage = leftCenter;
    [self.view addSubview:self.leftCenterImage];

    CLImageView * rightCenter = [[CLImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.leftCenterImage.frame) + 10,CGRectGetMaxY(self.rightTopImage.frame) + 10, kCellWidth, kCellHeight) andImage:[UIImage imageNamed:array[3]]];
    rightCenter.backgroundColor = [UIColor blackColor];
    rightCenter.userInteractionEnabled = YES;
    rightCenter.tag = 203;
    self.rightCenterImage = rightCenter;
    [self.view addSubview:self.rightCenterImage];

    CLImageView * leftBottom = [[CLImageView alloc]initWithFrame:CGRectMake(10,CGRectGetMaxY(self.leftCenterImage.frame) + 10, kCellWidth, kCellHeight) andImage:[UIImage imageNamed:array[4]]];
    leftBottom.backgroundColor = [UIColor blackColor];
    leftBottom.userInteractionEnabled = YES;
    leftBottom.tag = 204;
    self.leftBottomImage = leftBottom;
    [self.view addSubview:self.leftBottomImage];

    CLImageView * rightBottom = [[CLImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.leftBottomImage.frame) + 10,CGRectGetMaxY(self.rightCenterImage.frame) + 10, kCellWidth, kCellHeight) andImage:[UIImage imageNamed:array[5]]];
    rightBottom.backgroundColor = [UIColor blackColor];
    rightBottom.userInteractionEnabled = YES;
    rightBottom.tag = 205;
    self.rightBottomImage = rightBottom;
    [self.view addSubview:self.rightBottomImage];
    for (int i=0; i<6; i++) {
        CLImageView * imageView = [self.view viewWithTag:200+i];
        imageView.mImage = [UIImage imageNamed:array[i]];
        UITapGestureRecognizer * tapGuesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGuesture:)];
        tapGuesture.numberOfTapsRequired = 1;
        tapGuesture.numberOfTouchesRequired = 1;
        [imageView addGestureRecognizer:tapGuesture];
    }
}

- (void)tapGuesture:(UITapGestureRecognizer *)sender{
    NSLog(@"tag is %zi",sender.view.tag);
    CLImageView * imageView = [self.view viewWithTag:sender.view.tag];
    __weak typeof(self) weakSelf = self;
    [self doAnimationsComplete:^{
        __strong typeof(self)strongSelf = weakSelf;
        DetailViewController * detailVC = [[DetailViewController alloc]init];
        detailVC.title = @"大美女";
        detailVC.image = imageView.mImage;
        typedef void (^Animation)(void);
        detailVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        Animation animation = ^{
            BOOL oldState = [UIView areAnimationsEnabled];
            [UIView setAnimationsEnabled:NO];
            [UIView setAnimationsEnabled:oldState];
        };
        [UIView transitionWithView:detailVC.view
                          duration:0.5f
                           options:UIViewAnimationOptionTransitionCrossDissolve
                        animations:animation
                        completion:nil];
        [strongSelf presentViewController:detailVC animated:YES completion:nil];
    }];
}

- (void)doAnimationsComplete:(Complete)complete{
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.35 animations:^{
        __strong typeof(self)strongSelf = weakSelf;
        isOpen = YES;
        strongSelf.navigationController.navigationBarHidden = YES;
        strongSelf.view.backgroundColor = [UIColor blackColor];

        strongSelf.mTopScroll.frame = CGRectMake(0, -strongSelf.mTopScroll.frame.size.height, strongSelf.mTopScroll.frame.size.width, strongSelf.mTopScroll.frame.size.height);
        
        strongSelf.leftTopImage.frame = CGRectMake(-strongSelf.leftTopImage.frame.size.width, strongSelf.leftTopImage.frame.origin.y, kCellWidth, kCellHeight);
        strongSelf.rightTopImage.frame = CGRectMake(kWidth, strongSelf.leftTopImage.frame.origin.y, kCellWidth, kCellHeight);
        strongSelf.leftCenterImage.frame = CGRectMake(-strongSelf.leftCenterImage.frame.size.width, strongSelf.leftCenterImage.frame.origin.y, kCellWidth, kCellHeight);
        strongSelf.rightCenterImage.frame = CGRectMake(kWidth, strongSelf.rightCenterImage.frame.origin.y, kCellWidth, kCellHeight);
        strongSelf.leftBottomImage.frame = CGRectMake(strongSelf.leftBottomImage.frame.origin.x, kHeight, kCellWidth, kCellHeight);
        strongSelf.rightBottomImage.frame = CGRectMake(strongSelf.rightBottomImage.frame.size.width, kHeight, kCellWidth, kCellHeight);

    } completion:^(BOOL finished) {
        complete();
    }];
}

- (void)normalAnimationsComplete:(Complete)complete{
    __weak typeof(self) weakSelf = self;

    [UIView animateWithDuration:0.35 animations:^{
        __strong typeof(self)strongSelf = weakSelf;
        strongSelf.navigationController.navigationBarHidden = NO;
        strongSelf.view.backgroundColor = [UIColor whiteColor];
        self.mTopScroll.frame = CGRectMake(0,64, self.mTopScroll.frame.size.width, self.mTopScroll.frame.size.height);
        strongSelf.leftTopImage.frame = strongSelf.leftTopImage.orginFrame;
        strongSelf.rightTopImage.frame = strongSelf.rightTopImage.orginFrame;
        strongSelf.leftCenterImage.frame =strongSelf.leftCenterImage.orginFrame;
        strongSelf.rightCenterImage.frame = strongSelf.rightCenterImage.orginFrame;
        strongSelf.leftBottomImage.frame =strongSelf.leftBottomImage.orginFrame;
        strongSelf.rightBottomImage.frame =strongSelf.rightBottomImage.orginFrame;
    } completion:^(BOOL finished) {
        complete();
    }];
}

- (void)viewWillAppear:(BOOL)animated{
    if (isOpen) {
        [self normalAnimationsComplete:^{
            isOpen = NO;
        }];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
