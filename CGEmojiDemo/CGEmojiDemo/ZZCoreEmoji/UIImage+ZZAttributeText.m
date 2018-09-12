//
//  UIImage+ZZAttributeText.m
//  CGEmojiDemo
//
//  Created by LinZehua on 2018/9/8.
//  Copyright © 2018 林泽华. All rights reserved.
//

#import "UIImage+ZZAttributeText.h"
#import "ZZTextAttributes.h"

@implementation UIImage(ZZAttributeText)

+ (UIImage *)zz_imageWithAttributes:(ZZTextAttributes *)attributes {
    
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    style.alignment = NSTextAlignmentCenter;
    NSMutableDictionary *dict = @{
                                  NSFontAttributeName: attributes.font,
                                  NSForegroundColorAttributeName: attributes.textColor,
                                  NSParagraphStyleAttributeName: style
                                  }.mutableCopy;
    
    CGSize size = [attributes.text boundingRectWithSize:CGSizeMake(300,MAXFLOAT)
                                     options:NSStringDrawingUsesLineFragmentOrigin
                                  attributes:dict
                                     context:NULL].size;
    
    UIGraphicsBeginImageContextWithOptions(size, NO, 0.0f);
    
    [attributes.text drawInRect:CGRectMake(0, 0, size.width, size.height) withAttributes:dict];
    
    // 添加描边
    [dict setObject:attributes.borderColor forKey:NSStrokeColorAttributeName];
    [dict setObject:@(3) forKey:NSStrokeWidthAttributeName];
    [attributes.text drawInRect:CGRectMake(0, 0, size.width, size.height) withAttributes:dict];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}


@end
