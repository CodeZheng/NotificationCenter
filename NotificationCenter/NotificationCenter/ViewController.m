//
//  ViewController.m
//  NotificationCenter
//
//  Created by admin on 10/02/2017.
//  Copyright © 2017 admin. All rights reserved.
//

#import "ViewController.h"
#import "SecondViewController.h"
@interface ViewController ()<EatDelegate,UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIButton *pushBtn;
@property (weak, nonatomic) IBOutlet UITextField *textFiled;
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
    self.textFiled.delegate = self;
}


//限制TextField输入长度(标准)
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    if (textField == self.textFiled) {
        //这里的if时候为了获取删除操作,如果没有次if会造成当达到字数限制后删除键也不能使用的后果.
        if (range.length == 1 && string.length == 0) {
            return YES;
        }else if (self.textFiled.text.length >= 30) {
            self.textFiled.text = [textField.text substringToIndex:30];
            return NO;
        }
    }
    return YES;
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
