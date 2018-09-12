//
//  ZZTextAttributes.m
//  CGEmojiDemo
//
//  Created by LinZehua on 2018/9/8.
//  Copyright © 2018 林泽华. All rights reserved.
//

#import "ZZTextAttributes.h"

@implementation ZZTextAttributes 

- (instancetype)initWithText:(NSString *)text
                        font:(UIFont *)font
                   textColor:(UIColor *)textColor
                 borderColor:(UIColor *)borderColor
{
    self = [super init];
    if (self) {
        self.text = text;
        self.font = font;
        self.textColor = textColor;
        self.borderColor = borderColor;
    }
    return self;
}

@end
