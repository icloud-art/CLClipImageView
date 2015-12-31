//
//  DetailViewController.m
//  CLClipImageAnimation
//
//  Created by Charles on 15/12/31.
//  Copyright © 2015年 Charles. All rights reserved.
//

#import "DetailViewController.h"
@interface DetailViewController ()
@property (strong,nonatomic) CLImageView * mImageView;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    
    self.mImageView = [[CLImageView alloc]initWithFrame:self.view.bounds andImage:self.image];
    self.mImageView.autoresizingMask = (1 << 6) -1;
    self.mImageView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.mImageView];
    
    UITapGestureRecognizer * tapGuesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGuesture:)];
    tapGuesture.numberOfTapsRequired = 1;
    tapGuesture.numberOfTouchesRequired = 1;
    [self.mImageView addGestureRecognizer:tapGuesture];

}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    NSLog(@"%@", NSStringFromCGRect([[[self.view subviews] lastObject] frame]));
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer
shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return ![gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]];
}

- (void)tapGuesture:(UITapGestureRecognizer *)sender{
    typedef void (^Animation)(void);
    self.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    Animation animation = ^{
        BOOL oldState = [UIView areAnimationsEnabled];
        [UIView setAnimationsEnabled:NO];
        [UIView setAnimationsEnabled:oldState];
    };
    [UIView transitionWithView:self.view
                      duration:0.5f
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:animation
                    completion:nil];
    [self dismissViewControllerAnimated:YES completion:nil];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
