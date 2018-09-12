//
//  ZZPointUtil.m
//  CGEmojiDemo
//
//  Created by 林泽华 on 2018/9/12.
//  Copyright © 2018 林泽华. All rights reserved.
//

#import "ZZPointUtil.h"

@implementation ZZPointUtil

CGFloat ZZPointDistance(CGPoint aPoint, CGPoint bPoint) {
    CGFloat deltaX = bPoint.x - aPoint.x;
    CGFloat deltaY = bPoint.y - aPoint.y;
    CGFloat distance = ABS(sqrt(deltaX * deltaX + deltaY * deltaY));
    return distance;
} 

@end
