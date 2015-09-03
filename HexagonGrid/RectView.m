//
//  RectView.m
//  RoundGrid
//
//  Created by Bartosz Olszanowski on 03.09.2015.
//  Copyright (c) 2015 Vorm. All rights reserved.
//

#import "RectView.h"

IB_DESIGNABLE
@implementation RectView

static const CGFloat kLineWidth = 2;

- (void)drawRect:(CGRect)rect {
    // Drawing code
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(kLineWidth/2, kLineWidth/2, self.bounds.size.width-kLineWidth, self.bounds.size.height-kLineWidth)];
    path.lineWidth = kLineWidth;
    [[UIColor orangeColor] setStroke];
    [path stroke];
}


@end
