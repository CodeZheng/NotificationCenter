//
//  SecondViewController.m
//  NotificationCenter
//
//  Created by admin on 10/02/2017.
//  Copyright © 2017 admin. All rights reserved.
//

#import "SecondViewController.h"
#import "DrawCircleView.h"
#import <AVFoundation/AVFoundation.h>
#import "AVPlayerViewController.h"

@interface SecondViewController ()
@property (nonatomic, strong) UISlider *slider;
@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self uploadUI];
    [self playMovie];
}

- (void)playMovie {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(CGRectGetMidX(self.view.frame)-50, CGRectGetMidY(self.view.frame)-200, 100, 80);
    [btn setTitle:@"play" forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor purpleColor];
    [btn addTarget:self action:@selector(turnToAVPlayerVC:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

- (void)turnToAVPlayerVC:(UIButton *)sender {
    NSLog(@"PLAY ： %@",sender);
    AVPlayerViewController *aVC = [[AVPlayerViewController alloc]init];
    [self presentViewController:aVC animated:NO completion:nil];
}

- (void)uploadUI {
    self.view.backgroundColor = [UIColor whiteColor];
    
    //创建CircleView并添加旋转动画
    DrawCircleView *dcv = [[DrawCircleView alloc]initWithFrame:CGRectMake(CGRectGetMidX(self.view.frame)-100, CGRectGetMidY(self.view.frame)-100, 200, 200)];
    [self.view addSubview:dcv];
    CABasicAnimation *anima = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    anima.toValue = [NSNumber numberWithFloat:M_PI*2];
    anima.duration = 5;
    anima.repeatDuration = 4*60;
    dcv.backgroundColor = [UIColor redColor];
    dcv.layer.cornerRadius = 100;
    dcv.layer.masksToBounds = YES;
    [dcv.layer addAnimation:anima forKey:@"rotationAnimation"];
    
    //进度条slider
    CGRect sliderFrame = CGRectMake(50, CGRectGetMaxY(dcv.frame)+100, self.view.frame.size.width-100, 5);
    self.slider = [[UISlider alloc]initWithFrame:sliderFrame];
    
    //设置图片改变slider滑块的大小
    CGSize size = CGSizeMake(20, 20);
    CGRect rect = CGRectMake(0, 0, 20, 20);
    UIGraphicsBeginImageContext(size);
    [[UIImage imageNamed:@"100.jpg"]drawInRect:rect];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    [self.slider setThumbImage:scaledImage forState:UIControlStateNormal];
    [self.view addSubview:self.slider];

}


- (void)viewDidDisappear:(BOOL)animated {
    [[NSNotificationCenter defaultCenter]postNotificationName:@"passValue" object:@"valueTest船只" userInfo:@{@"key1":@"value1",@"key2":@"value2"}];
}

- (void)viewWillDisappear:(BOOL)animated {
    self.stringBlock(@"(-_-)view close");
    if ([self.eatDelegate respondsToSelector:@selector(eat:)]) {
        [self.eatDelegate eat:@"beef"];
    }
}

- (void)passValue:(void (^)(NSString *))valueBlock {
    self.stringBlock = valueBlock;
}

@end
