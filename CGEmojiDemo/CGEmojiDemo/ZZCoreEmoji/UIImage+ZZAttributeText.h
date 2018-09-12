//
//  UIImage+ZZAttributeText.h
//  CGEmojiDemo
//
//  Created by LinZehua on 2018/9/8.
//  Copyright © 2018 林泽华. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZZTextAttributes;
@interface UIImage(ZZAttributeText)

+ (UIImage *)zz_imageWithAttributes:(ZZTextAttributes *)attributes;

@end
