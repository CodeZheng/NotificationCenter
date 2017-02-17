//
//  DrawCircleView.m
//  NotificationCenter
//
//  Created by admin on 14/02/2017.
//  Copyright © 2017 admin. All rights reserved.
//

#import "DrawCircleView.h"

@implementation DrawCircleView

- (void)drawRect:(CGRect)rect {
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextAddEllipseInRect(ctx, rect);
    CGContextClip(ctx);
    UIImage *image = [UIImage imageNamed:@"100.jpg"];
    [image drawInRect:rect];
    CGContextStrokePath(ctx);
}

@end
