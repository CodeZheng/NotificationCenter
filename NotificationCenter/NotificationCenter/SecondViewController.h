//
//  SecondViewController.h
//  NotificationCenter
//
//  Created by admin on 10/02/2017.
//  Copyright © 2017 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol EatDelegate <NSObject>

- (void)eat:(NSString *)eat;

@end

@interface SecondViewController : UIViewController
@property (nonatomic, copy) void (^stringBlock)(NSString*);
- (void)passValue:(void (^)(NSString *stringValue))valueBlock;
@property (nonatomic, assign) id<EatDelegate> eatDelegate;
@end
