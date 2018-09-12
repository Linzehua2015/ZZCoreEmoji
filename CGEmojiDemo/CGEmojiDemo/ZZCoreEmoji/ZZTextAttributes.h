//
//  ZZTextAttributes.h
//  CGEmojiDemo
//
//  Created by LinZehua on 2018/9/8.
//  Copyright © 2018 林泽华. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZZTextAttributes : NSObject

// 文本样式
@property (nonatomic, copy) NSString *text;
@property (nonatomic, copy) UIFont *font;
@property (nonatomic, copy) UIColor *textColor;
@property (nonatomic, copy) UIColor *borderColor;

- (instancetype)initWithText:(NSString *)text
                        font:(UIFont *)font
                   textColor:(UIColor *)textColor
                 borderColor:(UIColor *)borderColor;
@end
