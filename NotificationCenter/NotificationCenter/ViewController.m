//
//  ViewController.m
//  NotificationCenter
//
//  Created by admin on 10/02/2017.
//  Copyright © 2017 admin. All rights reserved.
//

#import "ViewController.h"
#import "SecondViewController.h"
@interface ViewController ()<EatDelegate>
@property (weak, nonatomic) IBOutlet UIButton *pushBtn;
@property (strong, nonatomic) SecondViewController *secondVC;
@end

@implementation ViewController

- (SecondViewController *)secondVC {
    if (!_secondVC) {
        self.secondVC = [[SecondViewController alloc]init];
    }
    return _secondVC;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(passValue:) name:@"passValue" object:nil];
    self.secondVC.eatDelegate = self;
}

- (void)eat:(NSString *)eat {
    [self performSelector:@selector(changeBackgroundColor) withObject:nil afterDelay:5];
    NSLog(@"delegate : %@",eat);
}

- (void)changeBackgroundColor {
    self.view.backgroundColor = [UIColor redColor];
}

- (void)passValue:(NSNotification *)ntf {
    NSLog(@"ntf.name : %@\n,ntf.object : %@\n,ntf.userInfo : %@",ntf.name,ntf.object,ntf.userInfo);
}

- (IBAction)push:(id)sender {
    [self.navigationController pushViewController:self.secondVC animated:NO];
}

- (void)viewWillAppear:(BOOL)animated {
    [self.secondVC passValue:^(NSString *stringValue) {
        NSLog(@"block : %@",stringValue);
    }];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"passValue" object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
