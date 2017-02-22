//
//  ZXSlider.m
//  NotificationCenter
//
//  Created by admin on 22/02/2017.
//  Copyright © 2017 admin. All rights reserved.
//

#import "ZXSlider.h"

@implementation ZXSlider

- (CGRect)thumbRectForBounds:(CGRect)bounds trackRect:(CGRect)rect value:(float)value
{//返回滑块大小
    rect.origin.x = rect.origin.x - 10 ;
    rect.size.width = rect.size.width + 20;
    return CGRectInset ([super thumbRectForBounds:bounds trackRect:rect value:value], 10 , 10);
}

@end
